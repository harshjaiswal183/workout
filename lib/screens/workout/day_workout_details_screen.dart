import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_theme.dart';
import '../../models/exercise.dart';
import '../../providers/workout_provider.dart';
import '../../widgets/exercise_placeholder.dart';
import 'exercise_detail_screen.dart';
import 'workout_session_screen.dart';

class DayWorkoutDetailsScreen extends StatelessWidget {
  final String dayName;
  final String categoryName;
  final List<Exercise> exercises;
  final String difficulty;
  final String estimatedDuration;

  const DayWorkoutDetailsScreen({
    super.key,
    required this.dayName,
    required this.categoryName,
    required this.exercises,
    required this.difficulty,
    required this.estimatedDuration,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // COLLAPSIBLE APP BAR
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            stretch: true,
            backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                categoryName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(color: Colors.black45, blurRadius: 8)],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Show animation of the first exercise as header background
                  if (exercises.isNotEmpty)
                    Opacity(
                      opacity: 0.8,
                      child: ExercisePlaceholder(
                        bodyPart: exercises[0].bodyPart,
                        exerciseName: '',
                        animationPath: exercises[0].animationPath,
                        height: 220,
                      ),
                    ),
                  // Gradient Overlay for readability
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.3),
                          isDark ? AppTheme.darkBackground : AppTheme.lightBackground
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  // Visual elements
                  Positioned(
                    bottom: 70,
                    left: 20,
                    right: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildBadge(context, label: dayName.toUpperCase(), color: AppTheme.primaryTeal),
                        const SizedBox(width: 8),
                        _buildBadge(context, label: difficulty, color: Colors.orangeAccent),
                        const SizedBox(width: 8),
                        _buildBadge(context, label: estimatedDuration, color: Colors.blueAccent),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // EXERCISE LIST
          SliverPadding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 100),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final exercise = exercises[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 14),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExerciseDetailScreen(exercise: exercise),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            // Exercise Icon/Mini Placeholder
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                width: 75,
                                height: 75,
                                color: isDark ? Colors.black26 : Colors.grey.shade100,
                                child: ExercisePlaceholder(
                                  bodyPart: exercise.bodyPart,
                                  exerciseName: '',
                                  animationPath: exercise.animationPath,
                                  height: 75,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),

                            // Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    exercise.name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    '${exercise.sets} Sets • ${exercise.reps} Reps',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(Icons.timer_outlined, size: 12, color: AppTheme.primaryTeal),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          '${exercise.duration}s hold/duration',
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
                                            color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                childCount: exercises.length,
              ),
            ),
          ),
        ],
      ),
      
      // FLOATING ACTION BUTTON TO START
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: 56,
        child: FloatingActionButton.extended(
          onPressed: () {
            // Load and launch session
            context.read<WorkoutProvider>().startWorkout(categoryName, exercises);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WorkoutSessionScreen()),
            );
          },
          backgroundColor: AppTheme.primaryTeal,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
          label: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.play_arrow_rounded, color: Colors.black, size: 28),
              SizedBox(width: 8),
              Text(
                'START WORKOUT',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadge(BuildContext context, {required String label, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.25),
        border: Border.all(color: color.withOpacity(0.5), width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
