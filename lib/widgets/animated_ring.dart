import 'package:flutter/material.dart';

class AnimatedRing extends StatelessWidget {
  final double value;
  final Color color;
  final String label;
  final String subtitle;

  const AnimatedRing({
    super.key,
    required this.value,
    required this.color,
    required this.label,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: value),
      duration: const Duration(milliseconds: 1500),
      curve: Curves.easeOutCirc,
      builder: (context, animValue, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // Outer glow
            Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.2),
                    blurRadius: 40,
                    spreadRadius: animValue * 10,
                  )
                ],
              ),
            ),
            // Track
            SizedBox(
              width: 200,
              height: 200,
              child: CircularProgressIndicator(
                value: 1.0,
                strokeWidth: 8,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
            // Animated Progress
            SizedBox(
              width: 200,
              height: 200,
              child: CircularProgressIndicator(
                value: animValue,
                strokeWidth: 8,
                strokeCap: StrokeCap.round,
                color: color,
              ),
            ),
            // Center Text
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'AQI (Внутри)',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    height: 1.0,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'μg/m³',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: color.withOpacity(0.5)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: color,
                              blurRadius: 6,
                              spreadRadius: 2,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
