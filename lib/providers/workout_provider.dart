import 'dart:async';
import 'package:flutter/material.dart';
import '../models/exercise.dart';
import 'progress_provider.dart';

class WorkoutProvider extends ChangeNotifier {
  String? _activeWorkoutName;
  List<Exercise> _activeExercises = [];
  int _currentExerciseIndex = 0;
  bool _isTimerRunning = false;
  bool _isResting = false;
  int _restTimeRemaining = 0;
  int _elapsedSeconds = 0;
  int _totalWorkoutDurationSeconds = 0;
  Timer? _timer;

  // ==========================================
  // GETTERS
  // ==========================================
  String? get activeWorkoutName => _activeWorkoutName;
  List<Exercise> get activeExercises => _activeExercises;
  int get currentExerciseIndex => _currentExerciseIndex;
  bool get isTimerRunning => _isTimerRunning;
  bool get isResting => _isResting;
  int get restTimeRemaining => _restTimeRemaining;
  int get elapsedSeconds => _elapsedSeconds;
  int get totalWorkoutDurationSeconds => _totalWorkoutDurationSeconds;

  Exercise? get currentExercise {
    if (_activeExercises.isEmpty || _currentExerciseIndex >= _activeExercises.length) {
      return null;
    }
    return _activeExercises[_currentExerciseIndex];
  }

  double get workoutProgressPercentage {
    if (_activeExercises.isEmpty) return 0.0;
    return (_currentExerciseIndex / _activeExercises.length);
  }

  // ==========================================
  // WORKOUT STATE CONTROLS
  // ==========================================
  void startWorkout(String name, List<Exercise> exercises) {
    _activeWorkoutName = name;
    _activeExercises = exercises;
    _currentExerciseIndex = 0;
    _isTimerRunning = true;
    _elapsedSeconds = 0;
    _totalWorkoutDurationSeconds = 0;
    _startTimer();
    notifyListeners();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isTimerRunning) {
        if (_isResting) {
          if (_restTimeRemaining > 0) {
            _restTimeRemaining--;
          } else {
            _isResting = false;
          }
        } else {
          _elapsedSeconds++;
          _totalWorkoutDurationSeconds++;
        }
        notifyListeners();
      }
    });
  }

  void startRestPeriod() {
    _isResting = true;
    _restTimeRemaining = 30; // Default 30s rest
    notifyListeners();
  }

  void skipRest() {
    _isResting = false;
    _restTimeRemaining = 0;
    notifyListeners();
  }

  void extendRest(int seconds) {
    _restTimeRemaining += seconds;
    notifyListeners();
  }

  void toggleTimer() {
    _isTimerRunning = !_isTimerRunning;
    notifyListeners();
  }

  void pauseTimer() {
    _isTimerRunning = false;
    notifyListeners();
  }

  void resumeTimer() {
    _isTimerRunning = true;
    notifyListeners();
  }

  void skipExercise() {
    nextExercise();
  }

  void previousExercise() {
    if (_currentExerciseIndex > 0) {
      _currentExerciseIndex--;
      _elapsedSeconds = 0;
      notifyListeners();
    }
  }

  void nextExercise() {
    if (_currentExerciseIndex < _activeExercises.length - 1) {
      _currentExerciseIndex++;
      _elapsedSeconds = 0;
      startRestPeriod();
      notifyListeners();
    }
  }

  Map<String, dynamic> completeWorkout(ProgressProvider progressProvider) {
    _timer?.cancel();
    _timer = null;

    final name = _activeWorkoutName ?? 'Home Workout';
    final completedCount = _currentExerciseIndex + 1;
    final duration = _totalWorkoutDurationSeconds;

    // Calorie calculation based on active duration & difficulty levels
    double caloriesPerSec = 0.12; // default intermediate: 7.2 kcal/min
    if (currentExercise != null) {
      if (currentExercise!.difficulty == 'Beginner') {
        caloriesPerSec = 0.08; // 4.8 kcal/min
      } else if (currentExercise!.difficulty == 'Advanced') {
        caloriesPerSec = 0.16; // 9.6 kcal/min
      }
    }
    final calories = (duration * caloriesPerSec).round();

    // Score calculation
    double score = 0.0;
    if (_activeExercises.isNotEmpty) {
      score = (completedCount / _activeExercises.length) * 100.0;
    }

    // Save back to local storage
    progressProvider.addWorkoutSession(
      name: name,
      exercisesCount: completedCount,
      durationInSeconds: duration,
      caloriesBurned: calories,
      score: score,
    );

    final result = {
      'workoutName': name,
      'exercisesCompleted': completedCount,
      'totalTimeTaken': duration,
      'caloriesBurned': calories,
      'workoutScore': score,
      'completionDate': DateTime.now(),
    };

    // Clean up
    _activeWorkoutName = null;
    _activeExercises = [];
    _currentExerciseIndex = 0;
    _isTimerRunning = false;
    _elapsedSeconds = 0;
    _totalWorkoutDurationSeconds = 0;

    notifyListeners();
    return result;
  }

  void cancelWorkout() {
    _timer?.cancel();
    _timer = null;
    _activeWorkoutName = null;
    _activeExercises = [];
    _currentExerciseIndex = 0;
    _isTimerRunning = false;
    _isResting = false;
    _restTimeRemaining = 0;
    _elapsedSeconds = 0;
    _totalWorkoutDurationSeconds = 0;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
