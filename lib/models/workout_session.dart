class WorkoutSession {
  final String id;
  final String workoutName;
  final int exercisesCompletedCount;
  final int totalTimeTaken; // in seconds
  final int caloriesBurned;
  final DateTime completionDate;
  final double workoutScore; // e.g. score between 0.0 and 100.0

  WorkoutSession({
    required this.id,
    required this.workoutName,
    required this.exercisesCompletedCount,
    required this.totalTimeTaken,
    required this.caloriesBurned,
    required this.completionDate,
    required this.workoutScore,
  });

  factory WorkoutSession.fromMap(Map<dynamic, dynamic> map) {
    return WorkoutSession(
      id: map['id'] as String? ?? '',
      workoutName: map['workoutName'] as String? ?? '',
      exercisesCompletedCount: map['exercisesCompletedCount'] as int? ?? 0,
      totalTimeTaken: map['totalTimeTaken'] as int? ?? 0,
      caloriesBurned: map['caloriesBurned'] as int? ?? 0,
      completionDate: map['completionDate'] != null 
          ? DateTime.parse(map['completionDate'] as String) 
          : DateTime.now(),
      workoutScore: (map['workoutScore'] as num? ?? 100.0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'workoutName': workoutName,
      'exercisesCompletedCount': exercisesCompletedCount,
      'totalTimeTaken': totalTimeTaken,
      'caloriesBurned': caloriesBurned,
      'completionDate': completionDate.toIso8601String(),
      'workoutScore': workoutScore,
    };
  }
}
