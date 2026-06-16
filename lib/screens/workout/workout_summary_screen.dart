import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_theme.dart';
import '../main_navigation_holder.dart';

class WorkoutSummaryScreen extends StatelessWidget {
  final Map<String, dynamic> summaryData;

  const WorkoutSummaryScreen({
    super.key,
    required this.summaryData,
  });

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    if (minutes > 0) {
      return '$minutes min $remainingSeconds sec';
    }
    return '$remainingSeconds sec';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final workoutName = summaryData['workoutName'] as String? ?? 'Home Workout';
    final completedCount = summaryData['exercisesCompleted'] as int? ?? 0;
    final totalTime = summaryData['totalTimeTaken'] as int? ?? 0;
    final calories = summaryData['caloriesBurned'] as int? ?? 0;
    final score = (summaryData['workoutScore'] as num? ?? 100.0).toDouble();
    final completionDate = summaryData['completionDate'] as DateTime? ?? DateTime.now();

    final dateStr = DateFormat('dd MMM yyyy').format(completionDate);
    final timeStr = DateFormat('hh:mm a').format(completionDate);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [Color(0xFF0F0C1B), Color(0xFF0D0B18)]
                : [Color(0xFFF0F2F6), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  // VICTORY TROPHY / CHECKMARK
                  Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppTheme.primaryGradient,
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryTeal.withOpacity(0.3),
                          blurRadius: 25,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    child: const Icon(
                      Icons.emoji_events_rounded,
                      size: 68,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // COMPLETED HEADER
                  const Text(
                    'Workout Completed!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    workoutName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryTeal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 36),

                  // STATS GRID CARD
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          // Row 1: Duration & Calories
                          Row(
                            children: [
                              _buildStatItem(
                                context,
                                title: 'Duration',
                                value: _formatDuration(totalTime),
                                icon: Icons.timer_outlined,
                              ),
                              Container(width: 1, height: 50, color: isDark ? Colors.white24 : Colors.grey.shade300),
                              _buildStatItem(
                                context,
                                title: 'Calories',
                                value: '$calories kcal',
                                icon: Icons.local_fire_department_outlined,
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Divider(color: Colors.white12),
                          ),
                          // Row 2: Exercises & Rating
                          Row(
                            children: [
                              _buildStatItem(
                                context,
                                title: 'Exercises',
                                value: '$completedCount Completed',
                                icon: Icons.fitness_center_rounded,
                              ),
                              Container(width: 1, height: 50, color: isDark ? Colors.white24 : Colors.grey.shade300),
                              _buildStatItem(
                                context,
                                title: 'Performance Score',
                                value: '${score.round()}%',
                                icon: Icons.star_border_rounded,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // DATE DETAILS CARD
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.calendar_today_rounded, size: 14, color: Colors.grey),
                              const SizedBox(width: 8),
                              Text(dateStr, style: const TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w600)),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.access_time_rounded, size: 14, color: Colors.grey),
                              const SizedBox(width: 8),
                              Text(timeStr, style: const TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 48),

                  // BOTTOM CONTROLS
                  Row(
                    children: [
                      // Back to dashboard
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => const MainNavigationHolder(initialIndex: 0)),
                              (route) => false,
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(0, 52),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          child: const Text('DASHBOARD'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // View progress
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => const MainNavigationHolder(initialIndex: 2)),
                              (route) => false,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryTeal,
                            minimumSize: const Size(0, 52),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          child: const Text(
                            'VIEW PROGRESS',
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: AppTheme.primaryTeal, size: 20),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
