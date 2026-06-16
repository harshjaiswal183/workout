import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import 'dashboard/dashboard_screen.dart';
import 'workout/workout_plan_screen.dart';
import 'progress/progress_screen.dart';
import 'profile/profile_screen.dart';

class MainNavigationHolder extends StatefulWidget {
  final int initialIndex;
  
  const MainNavigationHolder({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<MainNavigationHolder> createState() => _MainNavigationHolderState();
}

class _MainNavigationHolderState extends State<MainNavigationHolder> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  final List<Widget> _screens = [
    const DashboardScreen(),
    const WorkoutPlanScreen(),
    const ProgressScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.3 : 0.08),
              blurRadius: 15,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: isDark ? AppTheme.darkCard : Colors.white,
          indicatorColor: isDark ? AppTheme.primaryTeal.withOpacity(0.15) : AppTheme.primaryPurple.withOpacity(0.1),
          destinations: [
            NavigationDestination(
              icon: Icon(
                Icons.dashboard_outlined,
                color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
              ),
              selectedIcon: const Icon(
                Icons.dashboard_rounded,
                color: AppTheme.primaryTeal,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.fitness_center_outlined,
                color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
              ),
              selectedIcon: const Icon(
                Icons.fitness_center_rounded,
                color: AppTheme.primaryTeal,
              ),
              label: 'Workouts',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.insights_outlined,
                color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
              ),
              selectedIcon: const Icon(
                Icons.insights_rounded,
                color: AppTheme.primaryTeal,
              ),
              label: 'Progress',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.person_outline_rounded,
                color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
              ),
              selectedIcon: const Icon(
                Icons.person_rounded,
                color: AppTheme.primaryTeal,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
