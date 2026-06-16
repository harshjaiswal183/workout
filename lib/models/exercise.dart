class Exercise {
  final String id;
  final String name;
  final String bodyPart; // e.g. "Chest", "Back", etc.
  final String difficulty; // e.g. "Beginner", "Intermediate", "Advanced"
  final String description;
  final List<String> steps;
  final List<String> benefits;
  final List<String> mistakes;
  final List<String> safetyTips;
  final int duration; // in seconds
  final int sets;
  final int reps;
  final String animationPath;

  Exercise({
    required this.id,
    required this.name,
    required this.bodyPart,
    required this.difficulty,
    required this.description,
    required this.steps,
    required this.benefits,
    required this.mistakes,
    required this.safetyTips,
    required this.duration,
    required this.sets,
    required this.reps,
    required this.animationPath,
  });

  factory Exercise.fromMap(Map<dynamic, dynamic> map) {
    return Exercise(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      bodyPart: map['bodyPart'] as String? ?? '',
      difficulty: map['difficulty'] as String? ?? 'Intermediate',
      description: map['description'] as String? ?? '',
      steps: List<String>.from(map['steps'] ?? []),
      benefits: List<String>.from(map['benefits'] ?? []),
      mistakes: List<String>.from(map['mistakes'] ?? []),
      safetyTips: List<String>.from(map['safetyTips'] ?? []),
      duration: map['duration'] as int? ?? 30,
      sets: map['sets'] as int? ?? 3,
      reps: map['reps'] as int? ?? 10,
      animationPath: map['animationPath'] as String? ?? (map['gifPath'] as String? ?? ''),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'bodyPart': bodyPart,
      'difficulty': difficulty,
      'description': description,
      'steps': steps,
      'benefits': benefits,
      'mistakes': mistakes,
      'safetyTips': safetyTips,
      'duration': duration,
      'sets': sets,
      'reps': reps,
      'animationPath': animationPath,
    };
  }
}
