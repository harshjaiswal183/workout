class UserProfile {
  final String name;
  final double height; // in cm
  final double weight; // in kg
  final int age;
  final String fitnessGoal; // e.g., "Build Muscle", "Lose Weight", "Stay Fit", "Stamina"
  final int dailyTarget; // in minutes
  final int waterTarget; // in ml
  final bool isDarkMode;
  final String profilePicture;

  UserProfile({
    required this.name,
    required this.height,
    required this.weight,
    required this.age,
    required this.fitnessGoal,
    required this.dailyTarget,
    this.waterTarget = 2500,
    required this.isDarkMode,
    required this.profilePicture,
  });

  factory UserProfile.fromMap(Map<dynamic, dynamic> map) {
    return UserProfile(
      name: map['name'] as String? ?? 'Athletic User',
      height: (map['height'] as num? ?? 175.0).toDouble(),
      weight: (map['weight'] as num? ?? 70.0).toDouble(),
      age: map['age'] as int? ?? 25,
      fitnessGoal: map['fitnessGoal'] as String? ?? 'Stay Fit',
      dailyTarget: map['dailyTarget'] as int? ?? 30, // 30 minutes daily target default
      waterTarget: map['waterTarget'] as int? ?? 2500,
      isDarkMode: map['isDarkMode'] as bool? ?? false,
      profilePicture: map['profilePicture'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'height': height,
      'weight': weight,
      'age': age,
      'fitnessGoal': fitnessGoal,
      'dailyTarget': dailyTarget,
      'waterTarget': waterTarget,
      'isDarkMode': isDarkMode,
      'profilePicture': profilePicture,
    };
  }

  UserProfile copyWith({
    String? name,
    double? height,
    double? weight,
    int? age,
    String? fitnessGoal,
    int? dailyTarget,
    int? waterTarget,
    bool? isDarkMode,
    String? profilePicture,
  }) {
    return UserProfile(
      name: name ?? this.name,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      age: age ?? this.age,
      fitnessGoal: fitnessGoal ?? this.fitnessGoal,
      dailyTarget: dailyTarget ?? this.dailyTarget,
      waterTarget: waterTarget ?? this.waterTarget,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }
}
