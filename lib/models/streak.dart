class UserStreak {
  final int currentStreak;
  final int longestStreak;
  final DateTime? lastWorkoutDate;

  UserStreak({
    required this.currentStreak,
    required this.longestStreak,
    this.lastWorkoutDate,
  });

  factory UserStreak.fromMap(Map<dynamic, dynamic> map) {
    return UserStreak(
      currentStreak: map['currentStreak'] as int? ?? 0,
      longestStreak: map['longestStreak'] as int? ?? 0,
      lastWorkoutDate: map['lastWorkoutDate'] != null 
          ? DateTime.parse(map['lastWorkoutDate'] as String) 
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'lastWorkoutDate': lastWorkoutDate?.toIso8601String(),
    };
  }
}
