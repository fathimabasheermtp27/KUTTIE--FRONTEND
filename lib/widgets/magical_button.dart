import 'package:flutter/material.dart';

class MagicalButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final List<Color> gradientColors;
  final VoidCallback onTap;

  const MagicalButton({
    super.key,
    required this.label,
    required this.icon,
    required this.gradientColors,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutBack,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          gradient: LinearGradient(colors: gradientColors),
          boxShadow: [
            BoxShadow(
              color: gradientColors.first.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 28),
            const SizedBox(width: 16),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
                fontFamily: 'ComicSans',
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
