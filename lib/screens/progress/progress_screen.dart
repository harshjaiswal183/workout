import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/theme/app_theme.dart';
import '../../providers/progress_provider.dart';
import '../../models/workout_session.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _formatDuration(int seconds) {
    final mins = seconds ~/ 60;
    if (mins > 0) return '$mins min';
    return '$seconds sec';
  }

  @override
  Widget build(BuildContext context) {
    final progressProvider = Provider.of<ProgressProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final history = progressProvider.history.reversed.toList(); // Newest first

    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Progress'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.primaryTeal,
          labelColor: AppTheme.primaryTeal,
          unselectedLabelColor: isDark ? Colors.white70 : Colors.black54,
          tabs: const [
            Tab(text: 'Analytics', icon: Icon(Icons.analytics_outlined)),
            Tab(text: 'History Log', icon: Icon(Icons.history)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // ANALYTICS TAB
          _buildAnalyticsTab(context, progressProvider),

          // HISTORY LOG TAB
          _buildHistoryTab(context, history, progressProvider),
        ],
      ),
    );
  }

  // ==========================================
  // TAB 1: ANALYTICS
  // ==========================================
  Widget _buildAnalyticsTab(BuildContext context, ProgressProvider provider) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final double weeklyMinutes = provider.getWeeklyWorkoutMinutes().values.fold(0.0, (a, b) => a + b);

    if (provider.history.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.primaryTeal.withOpacity(0.1),
                ),
                child: const Icon(
                  Icons.bar_chart_rounded,
                  size: 64,
                  color: AppTheme.primaryTeal,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'No Data Yet',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Complete your first workout to see weekly charts, calorie analytics, and history metrics.',
                style: TextStyle(
                  color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // STATS OVERVIEW CARDS
          Row(
            children: [
              _buildOverviewCard(
                context,
                title: 'Total Workouts',
                value: '${provider.totalWorkoutsCompleted}',
                icon: Icons.fitness_center_rounded,
                color: AppTheme.primaryTeal,
              ),
              const SizedBox(width: 16),
              _buildOverviewCard(
                context,
                title: 'Active Streak',
                value: '${provider.streak.currentStreak} Days',
                icon: Icons.local_fire_department_rounded,
                color: Colors.orangeAccent,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildOverviewCard(
                context,
                title: 'Calories Burned',
                value: '${provider.totalCaloriesBurned} kcal',
                icon: Icons.flash_on_rounded,
                color: Colors.pinkAccent,
              ),
              const SizedBox(width: 16),
              _buildOverviewCard(
                context,
                title: 'Workout Time',
                value: '${(provider.totalWorkoutDurationSeconds / 60).round()} mins',
                icon: Icons.timer,
                color: Colors.blueAccent,
              ),
            ],
          ),
          const SizedBox(height: 28),

          // CHART 1: WEEKLY WORKOUT TIME
          Text(
            'Weekly Workout Time (Minutes)',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 8, left: 8, right: 16),
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: (weeklyMinutes > 60 ? weeklyMinutes : 60).toDouble(),
                    barTouchData: BarTouchData(enabled: true),
                    titlesData: FlTitlesData(
                      show: true,
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            switch (value.toInt()) {
                              case 1: return const Text('M', style: TextStyle(fontSize: 11));
                              case 2: return const Text('T', style: TextStyle(fontSize: 11));
                              case 3: return const Text('W', style: TextStyle(fontSize: 11));
                              case 4: return const Text('T', style: TextStyle(fontSize: 11));
                              case 5: return const Text('F', style: TextStyle(fontSize: 11));
                              case 6: return const Text('S', style: TextStyle(fontSize: 11));
                              case 7: return const Text('S', style: TextStyle(fontSize: 11));
                              default: return const Text('');
                            }
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    gridData: const FlGridData(show: false),
                    barGroups: provider.getWeeklyWorkoutMinutes().entries.map((entry) {
                      return BarChartGroupData(
                        x: entry.key,
                        barRods: [
                          BarChartRodData(
                            toY: entry.value,
                            gradient: AppTheme.primaryGradient,
                            width: 14,
                            borderRadius: BorderRadius.circular(4),
                          )
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 28),

          // CHART 2: CALORIES BURNED
          Text(
            'Weekly Calories Burned',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 8, left: 8, right: 16),
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: (provider.totalCaloriesBurned > 500 ? provider.totalCaloriesBurned : 500).toDouble(),
                    barTouchData: BarTouchData(enabled: true),
                    titlesData: FlTitlesData(
                      show: true,
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            switch (value.toInt()) {
                              case 1: return const Text('M', style: TextStyle(fontSize: 11));
                              case 2: return const Text('T', style: TextStyle(fontSize: 11));
                              case 3: return const Text('W', style: TextStyle(fontSize: 11));
                              case 4: return const Text('T', style: TextStyle(fontSize: 11));
                              case 5: return const Text('F', style: TextStyle(fontSize: 11));
                              case 6: return const Text('S', style: TextStyle(fontSize: 11));
                              case 7: return const Text('S', style: TextStyle(fontSize: 11));
                              default: return const Text('');
                            }
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    gridData: const FlGridData(show: false),
                    barGroups: provider.getWeeklyCaloriesBurned().entries.map((entry) {
                      return BarChartGroupData(
                        x: entry.key,
                        barRods: [
                          BarChartRodData(
                            toY: entry.value,
                            color: Colors.redAccent,
                            width: 14,
                            borderRadius: BorderRadius.circular(4),
                          )
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 28),

          // CHART 3: WORKOUT CATEGORIES
          Text(
            'Workout Categories Breakdown',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 220,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // Pie chart
                    Expanded(
                      flex: 4,
                      child: PieChart(
                        PieChartData(
                          sectionsSpace: 4,
                          centerSpaceRadius: 40,
                          sections: _buildCategoryPieSections(provider.getWorkoutCategoryBreakdown()),
                        ),
                      ),
                    ),
                    // Legend
                    Expanded(
                      flex: 3,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _buildCategoryLegends(provider.getWorkoutCategoryBreakdown()),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 28),

          // CHART 4: WEIGHT HISTORY
          Text(
            'Weight Progress Tracker',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 220,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 12, left: 12, right: 24),
                child: LineChart(
                  LineChartData(
                    gridData: const FlGridData(show: false),
                    titlesData: FlTitlesData(
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 22,
                          interval: 5,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              '#${value.toInt() + 1}',
                              style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
                            );
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        spots: provider.getWeightSpots(),
                        isCurved: true,
                        gradient: const LinearGradient(colors: [AppTheme.primaryTeal, AppTheme.primaryPurple]),
                        barWidth: 4,
                        isStrokeCapRound: true,
                        dotData: const FlDotData(show: true),
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                            colors: [
                              AppTheme.primaryTeal.withOpacity(0.3),
                              AppTheme.primaryPurple.withOpacity(0.1),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                    ),
                  ),
                  Icon(icon, color: color, size: 20),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> _buildCategoryPieSections(Map<String, double> breakdown) {
    final colors = [
      AppTheme.primaryTeal,
      AppTheme.primaryPurple,
      Colors.orangeAccent,
      Colors.pinkAccent,
      Colors.blueAccent,
      Colors.greenAccent,
      Colors.yellowAccent,
      Colors.redAccent,
    ];

    int index = 0;
    return breakdown.entries.where((e) => e.value > 0).map((entry) {
      final color = colors[index % colors.length];
      index++;
      return PieChartSectionData(
        color: color,
        value: entry.value,
        title: '${entry.value.round()}',
        radius: 20,
        titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
      );
    }).toList();
  }

  List<Widget> _buildCategoryLegends(Map<String, double> breakdown) {
    final colors = [
      AppTheme.primaryTeal,
      AppTheme.primaryPurple,
      Colors.orangeAccent,
      Colors.pinkAccent,
      Colors.blueAccent,
      Colors.greenAccent,
      Colors.yellowAccent,
      Colors.redAccent,
    ];

    int index = 0;
    return breakdown.entries.where((e) => e.value > 0).map((entry) {
      final color = colors[index % colors.length];
      index++;
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '${entry.key} (${entry.value.round()})',
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  // ==========================================
  // TAB 2: HISTORY LOG
  // ==========================================
  Widget _buildHistoryTab(BuildContext context, List<WorkoutSession> history, ProgressProvider provider) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (history.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.history_toggle_off_rounded, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text('No workout history logs found.', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(
              'Your completed workouts show up here.',
              style: TextStyle(color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        itemCount: history.length,
        itemBuilder: (context, index) {
          final session = history[index];
          final dateStr = DateFormat('dd MMM yyyy').format(session.completionDate);
          final timeStr = DateFormat('hh:mm a').format(session.completionDate);

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Icon
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryTeal.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.fitness_center_rounded,
                      color: AppTheme.primaryTeal,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  
                  // Text details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          session.workoutName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              '${session.exercisesCompletedCount} exercises',
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text('•', style: TextStyle(color: Colors.grey)),
                            const SizedBox(width: 8),
                            Text(
                              _formatDuration(session.totalTimeTaken),
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$dateStr at $timeStr',
                          style: TextStyle(
                            fontSize: 11,
                            color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Calories burned
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '+${session.caloriesBurned}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Colors.redAccent,
                        ),
                      ),
                      const Text(
                        'kcal',
                        style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final confirm = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Reset All Logs?'),
              content: const Text('Are you sure you want to clear your workout history? This will also reset your active streak.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('CANCEL'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('RESET ALL', style: TextStyle(color: Colors.redAccent)),
                ),
              ],
            ),
          );
          if (confirm == true) {
            await provider.clearHistory();
          }
        },
        label: const Text('CLEAR LOGS', style: TextStyle(fontSize: 12, color: Colors.black)),
        icon: const Icon(Icons.delete_sweep_rounded, color: Colors.black),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}
