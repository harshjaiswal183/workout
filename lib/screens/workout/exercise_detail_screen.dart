import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_theme.dart';
import '../../models/exercise.dart';
import '../../widgets/exercise_placeholder.dart';
import '../../providers/workout_provider.dart';
import 'workout_session_screen.dart';

class ExerciseDetailScreen extends StatelessWidget {
  final Exercise exercise;

  const ExerciseDetailScreen({
    super.key,
    required this.exercise,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(exercise.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline_rounded),
            onPressed: () {
              // Quick info alert
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(exercise.name),
                  content: Text(exercise.description),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'),
                    )
                  ],
                ),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ANIMATION / GIF CONTAINER
            Hero(
              tag: 'exercise_image_${exercise.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: ExercisePlaceholder(
                  bodyPart: exercise.bodyPart,
                  exerciseName: exercise.name,
                  animationPath: exercise.animationPath,
                  height: 220,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // QUICK META DATA CHIPS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildQuickStat(context, label: 'Sets', value: '${exercise.sets}'),
                _buildQuickStat(context, label: 'Reps', value: '${exercise.reps}'),
                _buildQuickStat(context, label: 'Duration', value: '${exercise.duration}s'),
                _buildQuickStat(context, label: 'Difficulty', value: exercise.difficulty),
              ],
            ),
            const SizedBox(height: 24),

            // DESCRIPTION SECTION
            Text(
              'Overview',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              exercise.description,
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
            const SizedBox(height: 24),

            // HOW TO PERFORM SECTION
            _buildSectionHeader(context, title: 'How To Perform', icon: Icons.format_list_numbered_rounded),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: exercise.steps.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: AppTheme.primaryTeal,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          exercise.steps[index],
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.4,
                            color: isDark ? Colors.white70 : Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 16),

            // BENEFITS SECTION
            _buildSectionHeader(context, title: 'Benefits', icon: Icons.verified_user_rounded),
            const SizedBox(height: 10),
            Column(
              children: exercise.benefits.map((b) => _buildCheckItem(context, text: b, isNegative: false)).toList(),
            ),
            const SizedBox(height: 16),

            // COMMON MISTAKES SECTION
            _buildSectionHeader(context, title: 'Common Mistakes', icon: Icons.warning_amber_rounded),
            const SizedBox(height: 10),
            Column(
              children: exercise.mistakes.map((m) => _buildCheckItem(context, text: m, isNegative: true)).toList(),
            ),
            const SizedBox(height: 16),

            // SAFETY TIPS SECTION
            _buildSectionHeader(context, title: 'Safety Tips', icon: Icons.health_and_safety_rounded),
            const SizedBox(height: 10),
            Column(
              children: exercise.safetyTips.map((s) => _buildCheckItem(context, text: s, isNegative: false, color: Colors.blueAccent)).toList(),
            ),
          ],
        ),
      ),
      
      // START INDIVIDUAL WORKOUT BUTTON
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: 52,
        child: FloatingActionButton.extended(
          onPressed: () {
            // Load and launch single exercise session
            context.read<WorkoutProvider>().startWorkout('Single Exercise: ${exercise.name}', [exercise]);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WorkoutSessionScreen()),
            );
          },
          backgroundColor: AppTheme.primaryTeal,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
          label: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.bolt, color: Colors.black, size: 20),
              SizedBox(width: 8),
              Text(
                'START THIS EXERCISE',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper builds
  Widget _buildQuickStat(BuildContext context, {required String label, required String value}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.primaryTeal),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, {required String title, required IconData icon}) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.primaryTeal, size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildCheckItem(BuildContext context, {required String text, required bool isNegative, Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = color ?? (isNegative ? Colors.redAccent : Colors.greenAccent);
    final icon = isNegative ? Icons.cancel_outlined : Icons.check_circle_outline_rounded;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13.5,
                height: 1.35,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
