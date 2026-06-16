import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../data/exercise_database.dart';
import '../../models/exercise.dart';
import 'day_workout_details_screen.dart';

class WorkoutPlanScreen extends StatelessWidget {
  const WorkoutPlanScreen({super.key});

  // Schedule setup mapping each day of the week
  List<Map<String, dynamic>> _getScheduleData() {
    return [
      {
        'day': 'Monday',
        'category': 'Chest & Triceps',
        'difficulty': 'Intermediate',
        'duration': '25 min',
        'gradient': AppTheme.primaryGradient,
        'bodyParts': ['Chest', 'Arms'], // Chest and Tricep Dips
      },
      {
        'day': 'Tuesday',
        'category': 'Back & Biceps',
        'difficulty': 'Intermediate',
        'duration': '25 min',
        'gradient': AppTheme.blueGradient,
        'bodyParts': ['Back', 'Arms'], // Back and Bicep curls
      },
      {
        'day': 'Wednesday',
        'category': 'Legs Day',
        'difficulty': 'Advanced',
        'duration': '30 min',
        'gradient': AppTheme.orangeGradient,
        'bodyParts': ['Legs'],
      },
      {
        'day': 'Thursday',
        'category': 'Shoulders Shape',
        'difficulty': 'Intermediate',
        'duration': '20 min',
        'gradient': AppTheme.pinkGradient,
        'bodyParts': ['Shoulders'],
      },
      {
        'day': 'Friday',
        'category': 'Abs & Core Blast',
        'difficulty': 'Beginner',
        'duration': '15 min',
        'gradient': AppTheme.primaryGradient,
        'bodyParts': ['Abs', 'Core'],
      },
      {
        'day': 'Saturday',
        'category': 'Full Body HIIT',
        'difficulty': 'Advanced',
        'duration': '35 min',
        'gradient': AppTheme.orangeGradient,
        'bodyParts': ['Full Body'],
      },
      {
        'day': 'Sunday',
        'category': 'Yoga & Flexibility',
        'difficulty': 'Beginner',
        'duration': '20 min',
        'gradient': AppTheme.greenGradient,
        'bodyParts': ['Yoga', 'Recovery'],
      },
    ];
  }

  List<Exercise> _getExercisesForDay(List<String> bodyParts, String day) {
    final all = ExerciseDatabase.exercises;
    
    if (day == 'Monday') {
      // Chest + Triceps
      return all.where((e) => e.bodyPart == 'Chest' || e.id == 'arms_bench_dip' || e.id == 'arms_tricep_kickback_body').toList();
    } else if (day == 'Tuesday') {
      // Back + Biceps
      return all.where((e) => e.bodyPart == 'Back' || e.id == 'arms_towel_curl' || e.id == 'arms_doorway_curl').toList();
    } else if (day == 'Saturday') {
      // Full body + a few compound moves
      return all.where((e) => e.bodyPart == 'Full Body' || e.id == 'chest_pushup' || e.id == 'legs_bodyweight_squat' || e.id == 'core_plank').toList();
    }

    // Default filters
    return all.where((e) => bodyParts.contains(e.bodyPart)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final schedule = _getScheduleData();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Schedule'),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        itemCount: schedule.length,
        itemBuilder: (context, index) {
          final item = schedule[index];
          final dayName = item['day'] as String;
          final category = item['category'] as String;
          final difficulty = item['difficulty'] as String;
          final duration = item['duration'] as String;
          final gradient = item['gradient'] as LinearGradient;
          final bodyParts = item['bodyParts'] as List<String>;
          
          final exercises = _getExercisesForDay(bodyParts, dayName);

          return Hero(
            tag: 'day_card_$dayName',
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: Card(
                clipBehavior: Clip.antiAlias,
                elevation: 0,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DayWorkoutDetailsScreen(
                          dayName: dayName,
                          categoryName: category,
                          exercises: exercises,
                          difficulty: difficulty,
                          estimatedDuration: duration,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isDark 
                            ? [AppTheme.darkCard, AppTheme.darkCard.withOpacity(0.8)]
                            : [Colors.white, Colors.white],
                      ),
                      border: isDark 
                          ? Border.all(color: Colors.white.withOpacity(0.04), width: 1.2)
                          : Border.all(color: Colors.grey.shade200, width: 1),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        // Left Colored Ring/Gradient Block
                        Container(
                          width: 6,
                          height: 80,
                          decoration: BoxDecoration(
                            gradient: gradient,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(width: 20),
                        
                        // Center Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                dayName.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: AppTheme.primaryTeal.withOpacity(0.9),
                                  letterSpacing: 1.5,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                category,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.fitness_center_rounded,
                                    size: 14,
                                    color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${exercises.length} Exercises',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Icon(
                                    Icons.timer_outlined,
                                    size: 14,
                                    color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    duration,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        // Right Indicator / Difficulty
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: difficulty == 'Advanced'
                                    ? Colors.redAccent.withOpacity(0.12)
                                    : (difficulty == 'Intermediate'
                                        ? Colors.orangeAccent.withOpacity(0.12)
                                        : Colors.greenAccent.withOpacity(0.12)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                difficulty,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  color: difficulty == 'Advanced'
                                      ? Colors.redAccent
                                      : (difficulty == 'Intermediate' ? Colors.orangeAccent : Colors.green),
                                ),
                              ),
                            ),
                            const SizedBox(height: 18),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 16,
                              color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
