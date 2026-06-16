import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class ExercisePlaceholder extends StatefulWidget {
  final String bodyPart;
  final String exerciseName;
  final String? animationPath;
  final double height;

  const ExercisePlaceholder({
    super.key,
    required this.bodyPart,
    required this.exerciseName,
    this.animationPath,
    this.height = 200,
  });

  @override
  State<ExercisePlaceholder> createState() => _ExercisePlaceholderState();
}

class _ExercisePlaceholderState extends State<ExercisePlaceholder> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.92, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.3, end: 0.7).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  // Get color based on muscle group/body part
  Color _getThemeColor() {
    switch (widget.bodyPart.toLowerCase()) {
      case 'chest':
        return Colors.orangeAccent;
      case 'back':
        return Colors.indigoAccent;
      case 'legs':
        return Colors.greenAccent;
      case 'shoulders':
        return Colors.amberAccent;
      case 'arms':
        return Colors.redAccent;
      case 'abs':
      case 'core':
        return Colors.cyanAccent;
      case 'recovery':
        return Colors.tealAccent;
      case 'yoga':
        return Colors.purpleAccent;
      default:
        return AppTheme.primaryTeal;
    }
  }

  IconData _getIcon() {
    switch (widget.bodyPart.toLowerCase()) {
      case 'chest':
        return Icons.sports_gymnastics;
      case 'back':
        return Icons.accessibility_new;
      case 'legs':
        return Icons.directions_run;
      case 'shoulders':
        return Icons.sports_handball;
      case 'arms':
        return Icons.fitness_center;
      case 'abs':
      case 'core':
        return Icons.adjust;
      case 'recovery':
        return Icons.spa;
      case 'yoga':
        return Icons.self_improvement;
      default:
        return Icons.bolt;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = _getThemeColor();
    final iconData = _getIcon();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: widget.height,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: isDark 
            ? [Color(0xFF1E1A3A), Color(0xFF0F0C1B)]
            : [Colors.grey.shade200, Colors.grey.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: isDark
            ? []
            : [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background pulsing circles
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: widget.height * 0.7 * _scaleAnimation.value,
                    height: widget.height * 0.7 * _scaleAnimation.value,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: themeColor.withOpacity(0.05 * _opacityAnimation.value),
                      border: Border.all(color: themeColor.withOpacity(0.15 * _opacityAnimation.value), width: 1.5),
                    ),
                  ),
                  Container(
                    width: widget.height * 0.55 * _scaleAnimation.value,
                    height: widget.height * 0.55 * _scaleAnimation.value,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: themeColor.withOpacity(0.07 * _opacityAnimation.value),
                      border: Border.all(color: themeColor.withOpacity(0.25 * _opacityAnimation.value), width: 1),
                    ),
                  ),
                ],
              );
            },
          ),
          
          // Main Content
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.animationPath != null && widget.animationPath!.isNotEmpty)
                  Flexible(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        widget.animationPath!,
                        height: widget.height * 0.7,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildFallbackIcon(themeColor, iconData);
                        },
                      ),
                    ),
                  )
                else
                  _buildFallbackIcon(themeColor, iconData),
                
                if (widget.height > 140 && widget.exerciseName.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Text(
                    widget.exerciseName,
                    style: TextStyle(
                      fontSize: widget.height > 180 ? 18 : 15,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                
                if (widget.height > 170) ...[
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                      color: themeColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      widget.bodyPart.toUpperCase(),
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        color: themeColor.withOpacity(0.95),
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFallbackIcon(Color themeColor, IconData iconData) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        padding: EdgeInsets.all(widget.height > 100 ? 20 : 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [themeColor, themeColor.withBlue(255).withRed(100)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: themeColor.withOpacity(0.4),
              blurRadius: 15,
              offset: const Offset(0, 6),
            )
          ],
        ),
        child: Icon(
          iconData,
          size: widget.height * (widget.height > 100 ? 0.22 : 0.4),
          color: Colors.white,
        ),
      ),
    );
  }
}
