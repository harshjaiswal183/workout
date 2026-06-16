import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_theme.dart';
import '../../data/exercise_database.dart';
import '../../models/exercise.dart';
import '../../providers/profile_provider.dart';
import '../../providers/progress_provider.dart';
import '../../providers/workout_provider.dart';
import '../workout/day_workout_details_screen.dart';
import '../profile/profile_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  // Helper to get day name and target workout
  Map<String, String> _getTodayWorkoutInfo(int weekday) {
    switch (weekday) {
      case 1:
        return {'category': 'Chest & Triceps', 'difficulty': 'Intermediate', 'duration': '25 min'};
      case 2:
        return {'category': 'Back & Biceps', 'difficulty': 'Intermediate', 'duration': '25 min'};
      case 3:
        return {'category': 'Legs Day', 'difficulty': 'Advanced', 'duration': '30 min'};
      case 4:
        return {'category': 'Shoulders', 'difficulty': 'Intermediate', 'duration': '20 min'};
      case 5:
        return {'category': 'Abs & Core', 'difficulty': 'Beginner', 'duration': '15 min'};
      case 6:
        return {'category': 'Full Body HIIT', 'difficulty': 'Advanced', 'duration': '35 min'};
      case 7:
        return {'category': 'Recovery & Stretching', 'difficulty': 'Beginner', 'duration': '15 min'};
      default:
        return {'category': 'Full Body', 'difficulty': 'Intermediate', 'duration': '20 min'};
    }
  }

  List<Exercise> _getTodayExercises(int weekday) {
    final all = ExerciseDatabase.exercises;
    switch (weekday) {
      case 1: // Chest & Triceps
        return all.where((e) => e.bodyPart == 'Chest' || e.id == 'arms_bench_dip' || e.id == 'arms_tricep_kickback_body').toList();
      case 2: // Back & Biceps
        return all.where((e) => e.bodyPart == 'Back' || e.id == 'arms_towel_curl' || e.id == 'arms_doorway_curl').toList();
      case 3: // Legs
        return all.where((e) => e.bodyPart == 'Legs').toList();
      case 4: // Shoulders
        return all.where((e) => e.bodyPart == 'Shoulders').toList();
      case 5: // Abs & Core
        return all.where((e) => e.bodyPart == 'Abs' || e.bodyPart == 'Core').toList().take(8).toList();
      case 6: // Full Body
        return all.where((e) => e.bodyPart == 'Full Body' || e.id == 'chest_pushup' || e.id == 'legs_bodyweight_squat' || e.id == 'core_plank').toList();
      case 7: // Recovery
        return all.where((e) => e.bodyPart == 'Recovery').toList();
      default:
        return all.take(6).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final progressProvider = Provider.of<ProgressProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final now = DateTime.now();
    final todayName = DateFormat('EEEE').format(now);
    final todayDate = DateFormat('MMMM dd').format(now);
    final workoutInfo = _getTodayWorkoutInfo(now.weekday);
    final todayExercises = _getTodayExercises(now.weekday);

    // Calc weekly target percentage
    final double weeklyMinutes = progressProvider.getWeeklyWorkoutMinutes().values.fold(0.0, (a, b) => a + b);
    final double dailyTargetMins = profileProvider.profile.dailyTarget.toDouble();
    final double weeklyTargetMins = dailyTargetMins * 5; // e.g. 5 days target
    final double targetPercentage = weeklyTargetMins > 0 ? (weeklyMinutes / weeklyTargetMins).clamp(0.0, 1.0) : 0.0;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER SECTION
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back,',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        profileProvider.profile.name,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to Profile Screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ProfileScreen(showAppBar: true)),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppTheme.primaryTeal, width: 2),
                      ),
                      child: CircleAvatar(
                        radius: 22,
                        backgroundColor: AppTheme.primaryPurple.withOpacity(0.2),
                        child: const Icon(Icons.person, color: AppTheme.primaryTeal),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // STREAK & LIFETIME STATS ROW
              Row(
                children: [
                  // Streak Card
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: AppTheme.primaryGradient,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primaryTeal.withOpacity(0.25),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.15),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.local_fire_department_rounded,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${progressProvider.streak.currentStreak} Days',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const Text(
                                'Workout Streak',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // QUICK STATS SECTION
              Row(
                children: [
                  _buildStatCard(
                    context,
                    title: 'Calories Burned',
                    value: '${progressProvider.totalCaloriesBurned} kcal',
                    icon: Icons.local_fire_department,
                    color: Colors.redAccent,
                  ),
                  const SizedBox(width: 16),
                  _buildStatCard(
                    context,
                    title: 'Total Duration',
                    value: '${(progressProvider.totalWorkoutDurationSeconds / 60).round()} mins',
                    icon: Icons.timer_outlined,
                    color: Colors.blueAccent,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // TODAY'S WORKOUT SECTION
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Today's Session",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$todayName, $todayDate',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // TODAY'S WORKOUT CARD
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DayWorkoutDetailsScreen(
                        dayName: todayName,
                        categoryName: workoutInfo['category']!,
                        exercises: todayExercises,
                        difficulty: workoutInfo['difficulty']!,
                        estimatedDuration: workoutInfo['duration']!,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/workout_bg.jpg'), // Fallback if missing
                      fit: BoxFit.cover,
                    ),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF3A1C71), Color(0xFFD76D77), Color(0xFFFFA07A)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepPurple.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          workoutInfo['difficulty']!.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        workoutInfo['category']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${todayExercises.length} Exercises • ${workoutInfo['duration']}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'View Details',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_forward,
                              color: Colors.black,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // HYDRATION TRACKER (Moved here)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hydration Tracker',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => progressProvider.resetWater(),
                        icon: const Icon(Icons.refresh, size: 20, color: AppTheme.primaryTeal),
                        tooltip: 'Reset Water Intake',
                      ),
                      TextButton.icon(
                        onPressed: () => _showWaterTargetDialog(context, profileProvider),
                        icon: const Icon(Icons.edit, size: 16, color: AppTheme.primaryTeal),
                        label: const Text('Set Goal', style: TextStyle(color: AppTheme.primaryTeal, fontSize: 12)),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            width: 60,
                            height: 80,
                            decoration: BoxDecoration(
                              color: isDark ? Colors.white.withOpacity(0.05) : Colors.blue.shade50,
                              borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(10),
                                top: Radius.circular(4),
                              ),
                              border: Border.all(
                                color: AppTheme.primaryTeal.withOpacity(0.3),
                                width: 2,
                              ),
                            ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            width: 56,
                            height: (progressProvider.todayWaterMl / profileProvider.profile.waterTarget * 76).clamp(0.0, 76.0),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppTheme.primaryTeal.withOpacity(0.7),
                                  AppTheme.primaryTeal,
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                              borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${progressProvider.todayWaterMl} / ${profileProvider.profile.waterTarget} ml',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              progressProvider.todayWaterMl >= profileProvider.profile.waterTarget 
                                  ? 'Goal Achieved! 🎉' 
                                  : 'Daily Hydration Goal',
                              style: TextStyle(
                                fontSize: 12,
                                color: progressProvider.todayWaterMl >= profileProvider.profile.waterTarget 
                                    ? AppTheme.primaryTeal 
                                    : (isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary),
                                fontWeight: progressProvider.todayWaterMl >= profileProvider.profile.waterTarget ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                _buildWaterButton(context, '+50ml', 50, profileProvider.profile.waterTarget),
                                const SizedBox(width: 4),
                                _buildWaterButton(context, '+100ml', 100, profileProvider.profile.waterTarget),
                                const SizedBox(width: 4),
                                _buildWaterButton(context, '+250ml', 250, profileProvider.profile.waterTarget),
                                const SizedBox(width: 4),
                                _buildWaterButton(context, '+500ml', 500, profileProvider.profile.waterTarget),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // RECOMMENDED WORKOUT
              Text(
                'Recommended For You',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              _buildRecommendedCard(
                context,
                title: 'Full Body Fat Blast',
                category: 'Full Body',
                exercisesCount: 8,
                duration: '35 mins',
                difficulty: 'Advanced',
                gradient: AppTheme.pinkGradient,
              ),
              const SizedBox(height: 12),
              _buildRecommendedCard(
                context,
                title: 'Post-Workout Cool Down',
                category: 'Recovery',
                exercisesCount: 6,
                duration: '15 mins',
                difficulty: 'Beginner',
                gradient: AppTheme.greenGradient,
              ),
              const SizedBox(height: 24),

              // YOGA SECTION
              Text(
                'Yoga & Mindfulness',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              _buildRecommendedCard(
                context,
                title: 'Morning Yoga Flow',
                category: 'Recovery',
                exercisesCount: 5,
                duration: '20 mins',
                difficulty: 'Beginner',
                gradient: AppTheme.primaryGradient,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget for Stats Card
  Widget _buildStatCard(
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
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(height: 12),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Recommended Card Generator
  Widget _buildRecommendedCard(
    BuildContext context, {
    required String title,
    required String category,
    required int exercisesCount,
    required String duration,
    required String difficulty,
    required LinearGradient gradient,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Pick exercise instances for the recommendation
    final exercises = ExerciseDatabase.exercises
        .where((e) => e.bodyPart.toLowerCase() == category.toLowerCase())
        .toList();

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DayWorkoutDetailsScreen(
              dayName: 'Special',
              categoryName: title,
              exercises: exercises.isNotEmpty ? exercises : ExerciseDatabase.exercises.take(exercisesCount).toList(),
              difficulty: difficulty,
              estimatedDuration: duration,
            ),
          ),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                  gradient: gradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.play_circle_outline,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          '$exercisesCount Exercises • $duration',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.white.withOpacity(0.08) : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        difficulty,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: difficulty == 'Advanced' 
                              ? Colors.redAccent 
                              : (difficulty == 'Intermediate' ? Colors.orangeAccent : Colors.green),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWaterButton(BuildContext context, String label, int amount, int target) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () {
          Provider.of<ProgressProvider>(context, listen: false).logWater(amount, target);
        },
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 8),
          side: const BorderSide(color: AppTheme.primaryTeal),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryTeal,
          ),
        ),
      ),
    );
  }

  void _showWaterTargetDialog(BuildContext context, ProfileProvider profileProvider) {
    final controller = TextEditingController(text: profileProvider.profile.waterTarget.toString());
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Set Daily Water Goal'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Target in ml',
            suffixText: 'ml',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final val = int.tryParse(controller.text);
              if (val != null && val > 0) {
                profileProvider.updateProfile(profileProvider.profile.copyWith(waterTarget: val));
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
