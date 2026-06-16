import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/workout_session.dart';
import '../models/streak.dart';
import '../services/local_storage_service.dart';

class ProgressProvider extends ChangeNotifier {
  List<WorkoutSession> _history = [];
  late UserStreak _streak;
  int _todayWaterMl = 0;
  List<Map<dynamic, dynamic>> _weightHistory = [];

  List<WorkoutSession> get history => _history;
  UserStreak get streak => _streak;
  int get todayWaterMl => _todayWaterMl;
  List<Map<dynamic, dynamic>> get weightHistory => _weightHistory;

  String get _todayDateKey {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  ProgressProvider() {
    loadData();
  }

  void loadData() {
    _history = LocalStorageService.getWorkoutHistory();
    _streak = LocalStorageService.getUserStreak();
    _todayWaterMl = LocalStorageService.getWaterIntake(_todayDateKey);
    _weightHistory = LocalStorageService.getWeightHistory();

    // Populate initial weight records if empty
    if (_weightHistory.isEmpty) {
      final profile = LocalStorageService.getUserProfile();
      _weightHistory = [
        {
          'date': DateTime.now().subtract(const Duration(days: 7)).toIso8601String(),
          'weight': profile.weight,
        },
        {
          'date': DateTime.now().toIso8601String(),
          'weight': profile.weight,
        }
      ];
      LocalStorageService.saveWeightHistory(_weightHistory);
    }

    _checkAndResetStreakIfNeeded();
  }

  void _checkAndResetStreakIfNeeded() {
    final lastDate = _streak.lastWorkoutDate;
    if (lastDate != null) {
      final now = DateTime.now();
      final difference = DateTime(now.year, now.month, now.day)
          .difference(DateTime(lastDate.year, lastDate.month, lastDate.day))
          .inDays;
      if (difference > 1) {
        // Missed day: reset current streak to 0, keep longest
        _streak = UserStreak(
          currentStreak: 0,
          longestStreak: _streak.longestStreak,
          lastWorkoutDate: _streak.lastWorkoutDate,
        );
        LocalStorageService.saveUserStreak(_streak);
        notifyListeners();
      }
    }
  }

  Future<void> addWorkoutSession({
    required String name,
    required int exercisesCount,
    required int durationInSeconds,
    required int caloriesBurned,
    required double score,
  }) async {
    final session = WorkoutSession(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      workoutName: name,
      exercisesCompletedCount: exercisesCount,
      totalTimeTaken: durationInSeconds,
      caloriesBurned: caloriesBurned,
      completionDate: DateTime.now(),
      workoutScore: score,
    );

    // Save history
    await LocalStorageService.addWorkoutSession(session);
    _history = LocalStorageService.getWorkoutHistory();

    // Streak Logic
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    int newStreak = _streak.currentStreak;
    final lastWorkout = _streak.lastWorkoutDate;

    if (lastWorkout == null) {
      newStreak = 1;
    } else {
      final lastWorkoutDay = DateTime(lastWorkout.year, lastWorkout.month, lastWorkout.day);
      final difference = today.difference(lastWorkoutDay).inDays;

      if (difference == 1) {
        newStreak += 1;
      } else if (difference > 1) {
        newStreak = 1;
      }
      // If difference is 0 (workout completed today already), do not increase streak
    }

    final newLongest = newStreak > _streak.longestStreak ? newStreak : _streak.longestStreak;
    _streak = UserStreak(
      currentStreak: newStreak,
      longestStreak: newLongest,
      lastWorkoutDate: now,
    );
    await LocalStorageService.saveUserStreak(_streak);

    notifyListeners();
  }

  // ==========================================
  // GETTERS FOR STATS
  // ==========================================
  int get totalWorkoutsCompleted => _history.length;

  int get totalCaloriesBurned {
    return _history.fold(0, (sum, session) => sum + session.caloriesBurned);
  }

  int get totalWorkoutDurationSeconds {
    return _history.fold(0, (sum, session) => sum + session.totalTimeTaken);
  }

  // ==========================================
  // CHART AGGREGATIONS
  // ==========================================
  
  // Weekly workout minutes for the current week (index 1 = Mon, 7 = Sun)
  Map<int, double> getWeeklyWorkoutMinutes() {
    final map = {1: 0.0, 2: 0.0, 3: 0.0, 4: 0.0, 5: 0.0, 6: 0.0, 7: 0.0};
    final now = DateTime.now();
    
    // Calculate start of Monday of the current week
    final currentWeekMonday = now.subtract(Duration(days: now.weekday - 1));
    final startOfMonday = DateTime(currentWeekMonday.year, currentWeekMonday.month, currentWeekMonday.day);

    for (var session in _history) {
      if (session.completionDate.isAfter(startOfMonday) || 
          session.completionDate.isAtSameMomentAs(startOfMonday)) {
        final day = session.completionDate.weekday;
        if (map.containsKey(day)) {
          map[day] = (map[day] ?? 0.0) + (session.totalTimeTaken / 60.0);
        }
      }
    }
    return map;
  }

  // Monthly workout count for the current year (index 1 = Jan, 12 = Dec)
  Map<int, double> getMonthlyWorkoutCounts() {
    final map = <int, double>{};
    for (int i = 1; i <= 12; i++) {
      map[i] = 0.0;
    }
    final now = DateTime.now();
    for (var session in _history) {
      if (session.completionDate.year == now.year) {
        final month = session.completionDate.month;
        if (map.containsKey(month)) {
          map[month] = (map[month] ?? 0.0) + 1.0;
        }
      }
    }
    return map;
  }

  // Weekly calories burned for current week (index 1 = Mon, 7 = Sun)
  Map<int, double> getWeeklyCaloriesBurned() {
    final map = {1: 0.0, 2: 0.0, 3: 0.0, 4: 0.0, 5: 0.0, 6: 0.0, 7: 0.0};
    final now = DateTime.now();
    final currentWeekMonday = now.subtract(Duration(days: now.weekday - 1));
    final startOfMonday = DateTime(currentWeekMonday.year, currentWeekMonday.month, currentWeekMonday.day);

    for (var session in _history) {
      if (session.completionDate.isAfter(startOfMonday) || 
          session.completionDate.isAtSameMomentAs(startOfMonday)) {
        final day = session.completionDate.weekday;
        if (map.containsKey(day)) {
          map[day] = (map[day] ?? 0.0) + session.caloriesBurned.toDouble();
        }
      }
    }
    return map;
  }

  // Workout count by main muscle categories
  Map<String, double> getWorkoutCategoryBreakdown() {
    final map = {
      'Chest': 0.0,
      'Back': 0.0,
      'Legs': 0.0,
      'Shoulders': 0.0,
      'Arms': 0.0,
      'Abs': 0.0,
      'Full Body': 0.0,
      'Recovery': 0.0,
    };
    for (var session in _history) {
      final name = session.workoutName;
      String cat = 'Full Body';
      if (name.contains('Chest')) cat = 'Chest';
      else if (name.contains('Back')) cat = 'Back';
      else if (name.contains('Legs')) cat = 'Legs';
      else if (name.contains('Shoulders')) cat = 'Shoulders';
      else if (name.contains('Abs')) cat = 'Abs';
      else if (name.contains('Recovery') || name.contains('Stretching')) cat = 'Recovery';
      else if (name.contains('Arms') || name.contains('Triceps') || name.contains('Biceps')) cat = 'Arms';

      map[cat] = (map[cat] ?? 0.0) + 1.0;
    }
    return map;
  }

  // ==========================================
  // WATER & WEIGHT MANAGEMENT
  // ==========================================
  Future<void> addWeightRecord(double weight) async {
    final now = DateTime.now();
    _weightHistory.add({
      'date': now.toIso8601String(),
      'weight': weight,
    });
    
    // Keep last 30 entries
    if (_weightHistory.length > 30) {
      _weightHistory.removeAt(0);
    }
    
    await LocalStorageService.saveWeightHistory(_weightHistory);
    
    // Sync profile
    final profile = LocalStorageService.getUserProfile();
    await LocalStorageService.saveUserProfile(profile.copyWith(weight: weight));

    notifyListeners();
  }

  Future<void> logWater(int amountMl, int targetMl) async {
    if (_todayWaterMl >= targetMl && amountMl > 0) return; // Stop if already at or above target
    
    _todayWaterMl += amountMl;
    if (_todayWaterMl < 0) _todayWaterMl = 0;
    if (_todayWaterMl > targetMl) _todayWaterMl = targetMl; // Cap at target

    await LocalStorageService.saveWaterIntake(_todayDateKey, _todayWaterMl);
    notifyListeners();
  }

  Future<void> resetWater() async {
    _todayWaterMl = 0;
    await LocalStorageService.saveWaterIntake(_todayDateKey, _todayWaterMl);
    notifyListeners();
  }

  double calculateBMI(double heightCm) {
    if (heightCm <= 0) return 0.0;
    final currentWeight = _weightHistory.isNotEmpty 
        ? (_weightHistory.last['weight'] as num).toDouble() 
        : LocalStorageService.getUserProfile().weight;
    final heightMeters = heightCm / 100.0;
    return currentWeight / (heightMeters * heightMeters);
  }

  List<FlSpot> getWeightSpots() {
    final List<FlSpot> spots = [];
    for (int i = 0; i < _weightHistory.length; i++) {
      final val = (_weightHistory[i]['weight'] as num).toDouble();
      spots.add(FlSpot(i.toDouble(), val));
    }
    return spots;
  }

  Future<void> clearHistory() async {
    await LocalStorageService.clearAll();
    loadData();
    notifyListeners();
  }
}
