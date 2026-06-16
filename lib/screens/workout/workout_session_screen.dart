import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_theme.dart';
import '../../providers/progress_provider.dart';
import '../../providers/workout_provider.dart';
import '../../widgets/exercise_placeholder.dart';
import 'workout_summary_screen.dart';

class WorkoutSessionScreen extends StatelessWidget {
  const WorkoutSessionScreen({super.key});

  String _formatDuration(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$remainingSeconds';
  }

  @override
  Widget build(BuildContext context) {
    final workoutProvider = Provider.of<WorkoutProvider>(context);
    final progressProvider = Provider.of<ProgressProvider>(context, listen: false);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final currentExercise = workoutProvider.currentExercise;
    final activeExercises = workoutProvider.activeExercises;
    final currentIndex = workoutProvider.currentExerciseIndex;

    // Guard if no active exercise
    if (currentExercise == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline_rounded, size: 64, color: Colors.orangeAccent),
              const SizedBox(height: 16),
              const Text('No active workout session found.'),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      );
    }

    // IF RESTING: Show Rest Intermission Screen
    if (workoutProvider.isResting) {
      final nextExercise = currentIndex < activeExercises.length ? activeExercises[currentIndex] : null;
      
      return Scaffold(
        backgroundColor: isDark ? const Color(0xFF0F0F0F) : Colors.grey.shade50,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                children: [
                  const Text(
                    'REST PERIOD',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                      color: AppTheme.primaryTeal,
                    ),
                  ),
                  const SizedBox(height: 60),
                  
                  // Circular Timer
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: CircularProgressIndicator(
                          value: workoutProvider.restTimeRemaining / 30, // assuming 30s base
                          strokeWidth: 12,
                          backgroundColor: AppTheme.primaryTeal.withOpacity(0.1),
                          valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryTeal),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${workoutProvider.restTimeRemaining}',
                            style: const TextStyle(
                              fontSize: 64,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const Text(
                            'SECONDS',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 60),
                  
                  // Next Exercise Preview
                  if (nextExercise != null) ...[
                    const Text(
                      'UP NEXT',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: SizedBox(
                                width: 80,
                                height: 80,
                                child: ExercisePlaceholder(
                                  bodyPart: nextExercise.bodyPart,
                                  exerciseName: nextExercise.name,
                                  animationPath: nextExercise.animationPath,
                                  height: 80,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    nextExercise.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${nextExercise.sets} Sets x ${nextExercise.reps} Reps',
                                    style: TextStyle(
                                      color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  
                  const SizedBox(height: 40),
                  
                  // Controls
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => workoutProvider.extendRest(10),
                          icon: const Icon(Icons.add, color: AppTheme.primaryTeal),
                          label: const Text('+10s', style: TextStyle(color: AppTheme.primaryTeal)),
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(0, 56),
                            side: const BorderSide(color: AppTheme.primaryTeal),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => workoutProvider.skipRest(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryTeal,
                            foregroundColor: Colors.black,
                            minimumSize: const Size(0, 56),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            elevation: 0,
                          ),
                          child: const Text(
                            'SKIP REST',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    // Calculations
    final progressNum = workoutProvider.workoutProgressPercentage;
    final totalDurationStr = _formatDuration(workoutProvider.totalWorkoutDurationSeconds);
    final exerciseDurationStr = _formatDuration(workoutProvider.elapsedSeconds);

    return WillPopScope(
      onWillPop: () async {
        final exit = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Quit Workout?'),
            content: const Text('Are you sure you want to stop this workout session? Your progress will not be saved.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('CANCEL'),
              ),
              TextButton(
                onPressed: () {
                  workoutProvider.cancelWorkout();
                  Navigator.pop(context, true);
                },
                child: const Text('QUIT', style: TextStyle(color: Colors.redAccent)),
              ),
            ],
          ),
        );
        return exit ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(workoutProvider.activeWorkoutName ?? 'Session'),
          leading: IconButton(
            icon: const Icon(Icons.close_rounded),
            onPressed: () async {
              final exit = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Quit Workout?'),
                  content: const Text('Are you sure you want to stop? Unsaved progress will be lost.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('CANCEL'),
                    ),
                    TextButton(
                      onPressed: () {
                        workoutProvider.cancelWorkout();
                        Navigator.pop(context, true);
                      },
                      child: const Text('QUIT', style: TextStyle(color: Colors.redAccent)),
                    ),
                  ],
                ),
              );
              if (exit == true && context.mounted) {
                Navigator.pop(context);
              }
            },
          ),
        ),
        body: Column(
          children: [
            // Linear Progress Indicator
            LinearProgressIndicator(
              value: progressNum,
              minHeight: 6,
              backgroundColor: isDark ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryTeal),
            ),
            
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // 1. Exercise Visual Representation (Animation) AT THE TOP
                    ExercisePlaceholder(
                      bodyPart: currentExercise.bodyPart,
                      exerciseName: currentExercise.name,
                      animationPath: currentExercise.animationPath,
                      height: 280,
                    ),

                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          // 2. Progress Header: Exercise 2 of 5
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Exercise ${currentIndex + 1} of ${activeExercises.length}',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.primaryTeal,
                                ),
                              ),
                              Text(
                                '${(progressNum * 100).round()}% Completed',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // 3. Target details
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Chip(
                                label: Text(currentExercise.bodyPart),
                                avatar: const Icon(Icons.circle_notifications, size: 16),
                              ),
                              const SizedBox(width: 12),
                              Chip(
                                label: Text('${currentExercise.sets} Sets x ${currentExercise.reps} Reps'),
                                avatar: const Icon(Icons.repeat, size: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),

                          // 4. TIMERS SECTION
                          const Text(
                            'ELAPSED TIME',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 2,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            exerciseDurationStr,
                            style: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 12),
                          
                          // Total Workout Timer
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.timer_outlined,
                                size: 16,
                                color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Total Workout Time: $totalDurationStr',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // PLAYBACK CONTROLS
            Container(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 32, top: 16),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.darkCard : Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
                    blurRadius: 15,
                    offset: const Offset(0, -4),
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Primary Controls: Prev, Play/Pause, Next
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Previous Button
                      IconButton.filledTonal(
                        onPressed: currentIndex > 0
                            ? () => workoutProvider.previousExercise()
                            : null,
                        icon: const Icon(Icons.skip_previous_rounded),
                        iconSize: 28,
                      ),

                      // Play/Pause / Resume Trigger
                      GestureDetector(
                        onTap: () => workoutProvider.toggleTimer(),
                        child: Container(
                          width: 72,
                          height: 72,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: AppTheme.primaryGradient,
                          ),
                          child: Icon(
                            workoutProvider.isTimerRunning
                                ? Icons.pause_rounded
                                : Icons.play_arrow_rounded,
                            size: 38,
                            color: Colors.black,
                          ),
                        ),
                      ),

                      // Next Button / Skip
                      IconButton.filledTonal(
                        onPressed: currentIndex < activeExercises.length - 1
                            ? () => workoutProvider.nextExercise()
                            : null,
                        icon: const Icon(Icons.skip_next_rounded),
                        iconSize: 28,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Bottom Buttons: Skip & Complete
                  Row(
                    children: [
                      // Skip button
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: currentIndex < activeExercises.length - 1
                              ? () => workoutProvider.skipExercise()
                              : null,
                          icon: const Icon(Icons.fast_forward_rounded),
                          label: const Text('SKIP'),
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(0, 48),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Complete button
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Run finish logic
                            final summaryResults = workoutProvider.completeWorkout(progressProvider);
                            // Navigate to Summary screen
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WorkoutSummaryScreen(summaryData: summaryResults),
                              ),
                            );
                          },
                          icon: const Icon(Icons.check_circle_outline_rounded, color: Colors.black),
                          label: const Text(
                            'COMPLETE',
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryTeal,
                            minimumSize: const Size(0, 48),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
