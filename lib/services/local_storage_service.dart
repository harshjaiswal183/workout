import 'package:hive_flutter/hive_flutter.dart';
import '../models/user_profile.dart';
import '../models/workout_session.dart';
import '../models/streak.dart';

class LocalStorageService {
  static const String _profileBoxName = 'profile_box';
  static const String _historyBoxName = 'history_box';
  static const String _streakBoxName = 'streak_box';
  static const String _weightBoxName = 'weight_box';
  static const String _waterBoxName = 'water_box';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(_profileBoxName);
    await Hive.openBox(_historyBoxName);
    await Hive.openBox(_streakBoxName);
    await Hive.openBox(_weightBoxName);
    await Hive.openBox(_waterBoxName);
  }

  // ==========================================
  // PROFILE OPERATIONS
  // ==========================================
  static UserProfile getUserProfile() {
    final box = Hive.box(_profileBoxName);
    final data = box.get('user_profile');
    if (data == null) {
      return UserProfile(
        name: 'FitHome Athlete',
        height: 175.0,
        weight: 70.0,
        age: 25,
        fitnessGoal: 'Stay Fit',
        dailyTarget: 30, // 30 mins
        isDarkMode: false,
        profilePicture: '',
      );
    }
    return UserProfile.fromMap(Map<dynamic, dynamic>.from(data as Map));
  }

  static Future<void> saveUserProfile(UserProfile profile) async {
    final box = Hive.box(_profileBoxName);
    await box.put('user_profile', profile.toMap());
  }

  // ==========================================
  // HISTORY OPERATIONS
  // ==========================================
  static List<WorkoutSession> getWorkoutHistory() {
    final box = Hive.box(_historyBoxName);
    final List<dynamic>? list = box.get('sessions') as List<dynamic>?;
    if (list == null) return [];
    return list
        .map((e) => WorkoutSession.fromMap(Map<dynamic, dynamic>.from(e as Map)))
        .toList();
  }

  static Future<void> saveWorkoutHistory(List<WorkoutSession> history) async {
    final box = Hive.box(_historyBoxName);
    final data = history.map((e) => e.toMap()).toList();
    await box.put('sessions', data);
  }

  static Future<void> addWorkoutSession(WorkoutSession session) async {
    final history = getWorkoutHistory();
    history.add(session);
    await saveWorkoutHistory(history);
  }

  // ==========================================
  // STREAK OPERATIONS
  // ==========================================
  static UserStreak getUserStreak() {
    final box = Hive.box(_streakBoxName);
    final data = box.get('user_streak');
    if (data == null) {
      return UserStreak(currentStreak: 0, longestStreak: 0);
    }
    return UserStreak.fromMap(Map<dynamic, dynamic>.from(data as Map));
  }

  static Future<void> saveUserStreak(UserStreak streak) async {
    final box = Hive.box(_streakBoxName);
    await box.put('user_streak', streak.toMap());
  }

  // ==========================================
  // WEIGHT OPERATIONS
  // ==========================================
  static List<Map<dynamic, dynamic>> getWeightHistory() {
    final box = Hive.box(_weightBoxName);
    final List<dynamic>? list = box.get('weight_records') as List<dynamic>?;
    if (list == null) return [];
    return list.map((e) => Map<dynamic, dynamic>.from(e as Map)).toList();
  }

  static Future<void> saveWeightHistory(List<Map<dynamic, dynamic>> records) async {
    final box = Hive.box(_weightBoxName);
    await box.put('weight_records', records);
  }

  // ==========================================
  // WATER OPERATIONS
  // ==========================================
  static int getWaterIntake(String dateKey) {
    final box = Hive.box(_waterBoxName);
    return box.get(dateKey, defaultValue: 0) as int;
  }

  static Future<void> saveWaterIntake(String dateKey, int amountMl) async {
    final box = Hive.box(_waterBoxName);
    await box.put(dateKey, amountMl);
  }

  // Clear data (for testing/reset)
  static Future<void> clearAll() async {
    await Hive.box(_profileBoxName).clear();
    await Hive.box(_historyBoxName).clear();
    await Hive.box(_streakBoxName).clear();
    await Hive.box(_weightBoxName).clear();
    await Hive.box(_waterBoxName).clear();
  }
}
