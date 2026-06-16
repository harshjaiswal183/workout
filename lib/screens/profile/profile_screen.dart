import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_theme.dart';
import '../../models/user_profile.dart';
import '../../providers/profile_provider.dart';
import '../../providers/progress_provider.dart';
import '../../providers/theme_provider.dart';

class ProfileScreen extends StatefulWidget {
  final bool showAppBar;

  const ProfileScreen({
    super.key,
    this.showAppBar = false,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController _nameController;
  late TextEditingController _heightController;
  late TextEditingController _weightController;
  late TextEditingController _ageController;
  
  String _selectedGoal = 'Stay Fit';
  int _selectedTarget = 30;

  final List<String> _goals = ['Stay Fit', 'Build Muscle', 'Lose Weight', 'Gain Stamina'];
  final List<int> _targets = [15, 20, 30, 45, 60, 90, 120];

  @override
  void initState() {
    super.initState();
    final profile = Provider.of<ProfileProvider>(context, listen: false).profile;
    
    _nameController = TextEditingController(text: profile.name);
    _heightController = TextEditingController(text: profile.height.toString());
    _weightController = TextEditingController(text: profile.weight.toString());
    _ageController = TextEditingController(text: profile.age.toString());
    _selectedGoal = profile.fitnessGoal;
    _selectedTarget = profile.dailyTarget;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _saveProfile(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final oldProfile = Provider.of<ProfileProvider>(context, listen: false).profile;
      
      final updatedProfile = oldProfile.copyWith(
        name: _nameController.text.trim(),
        height: double.parse(_heightController.text.trim()),
        weight: double.parse(_weightController.text.trim()),
        age: int.parse(_ageController.text.trim()),
        fitnessGoal: _selectedGoal,
        dailyTarget: _selectedTarget,
      );

      Provider.of<ProfileProvider>(context, listen: false).updateProfile(updatedProfile);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Profile updated successfully!'),
          backgroundColor: AppTheme.primaryTeal,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  void _showWeightLogDialog(BuildContext context, ProgressProvider progress) {
    final controller = TextEditingController(text: _weightController.text);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log Weight'),
        content: TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'Weight (kg)',
            suffixText: 'kg',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          ElevatedButton(
            onPressed: () {
              final weight = double.tryParse(controller.text);
              if (weight != null) {
                progress.addWeightRecord(weight);
                setState(() {
                  _weightController.text = weight.toString();
                });
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryTeal),
            child: const Text('SAVE', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: widget.showAppBar 
          ? AppBar(title: const Text('My Profile')) 
          : AppBar(title: const Text('My Profile'), automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 40),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // PROFILE PIX CARD
              Center(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppTheme.primaryTeal, width: 3),
                      ),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: AppTheme.primaryPurple.withOpacity(0.2),
                        child: const Icon(
                          Icons.sports_gymnastics_rounded,
                          size: 54,
                          color: AppTheme.primaryTeal,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _nameController.text.isNotEmpty ? _nameController.text : 'Athlete',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _selectedGoal.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryTeal,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // BMI CALCULATOR CARD
              Consumer<ProgressProvider>(
                builder: (context, progress, child) {
                  final double height = double.tryParse(_heightController.text) ?? 0.0;
                  final bmi = progress.calculateBMI(height);
                  
                  String status = 'Normal';
                  Color statusColor = Colors.green;
                  if (bmi < 18.5) {
                    status = 'Underweight';
                    statusColor = Colors.orange;
                  } else if (bmi >= 25 && bmi < 30) {
                    status = 'Overweight';
                    statusColor = Colors.orange;
                  } else if (bmi >= 30) {
                    status = 'Obese';
                    statusColor = Colors.red;
                  }

                  return Card(
                    elevation: 0,
                    color: AppTheme.primaryTeal.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: AppTheme.primaryTeal.withOpacity(0.2)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Current BMI Index',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  bmi.toStringAsFixed(1),
                                  style: const TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.w900,
                                    color: AppTheme.primaryTeal,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: statusColor.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    status,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: statusColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          SizedBox(
                            width: 100,
                            child: ElevatedButton(
                              onPressed: () {
                                _showWeightLogDialog(context, progress);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primaryTeal,
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                elevation: 0,
                              ),
                              child: const Text(
                                'Log\nWeight',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),

              // SECTION 1: ACCOUNT PROFILE
              Text(
                'Personal Settings',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              
              // Name Form Field
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(14))),
                ),
                validator: (value) => (value == null || value.isEmpty) ? 'Please enter your name' : null,
                onChanged: (val) => setState(() {}),
              ),
              const SizedBox(height: 16),

              // Height, Weight, Age Row
              Row(
                children: [
                  // Height
                  Expanded(
                    child: TextFormField(
                      controller: _heightController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        labelText: 'Height (cm)',
                        prefixIcon: Icon(Icons.height),
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(14))),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Required';
                        if (double.tryParse(value) == null) return 'Invalid';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Weight
                  Expanded(
                    child: TextFormField(
                      controller: _weightController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        labelText: 'Weight (kg)',
                        prefixIcon: Icon(Icons.monitor_weight_outlined),
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(14))),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Required';
                        if (double.tryParse(value) == null) return 'Invalid';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Age
                  Expanded(
                    child: TextFormField(
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Age',
                        prefixIcon: Icon(Icons.calendar_today_outlined),
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(14))),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Required';
                        if (int.tryParse(value) == null) return 'Invalid';
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // SECTION 2: FITNESS PREFERENCES
              Text(
                'Workout Preferences',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              // Goal selection using Choice Chips
              const Text(
                'Fitness Goal',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: _goals.map((goal) {
                  final isSelected = _selectedGoal == goal;
                  return ChoiceChip(
                    label: Text(goal),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _selectedGoal = goal;
                        });
                      }
                    },
                    selectedColor: AppTheme.primaryTeal.withOpacity(0.25),
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isSelected ? AppTheme.primaryTeal : (isDark ? Colors.white60 : Colors.black87),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              // Daily Target Dropdown
              const Text(
                'Daily Target Duration',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<int>(
                value: _selectedTarget,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.timer_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(14))),
                ),
                items: _targets.map((target) {
                  return DropdownMenuItem<int>(
                    value: target,
                    child: Text('$target minutes / day'),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      _selectedTarget = val;
                    });
                  }
                },
              ),
              const SizedBox(height: 32),

              // SECTION 3: SYSTEM PREFERENCES
              Text(
                'Preferences & Settings',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              
              // Dark Mode Toggle Switch
              Card(
                child: SwitchListTile(
                  title: const Text('Dark Theme Mode', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: const Text('Use dynamic dark workout theme'),
                  secondary: const Icon(Icons.dark_mode_outlined, color: AppTheme.primaryTeal),
                  value: themeProvider.isDarkMode,
                  onChanged: (val) {
                    themeProvider.toggleTheme();
                  },
                ),
              ),
              const SizedBox(height: 24),

              // SAVE CHANGES BUTTON
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: () => _saveProfile(context),
                  icon: const Icon(Icons.save_rounded, color: Colors.black),
                  label: const Text(
                    'SAVE PROFILE INFORMATION',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryTeal,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
