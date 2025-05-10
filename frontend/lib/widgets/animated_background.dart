import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({Key? key}) : super(key: key);

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Bubble> _bubbles = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    // Create bubbles
    for (int i = 0; i < 20; i++) {
      _bubbles.add(Bubble());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: BubblePainter(
            bubbles: _bubbles,
            animation: _controller,
          ),
          child: Container(),
        );
      },
    );
  }
}

class Bubble {
  final double x = math.Random().nextDouble();
  final double y = math.Random().nextDouble();
  final double size = math.Random().nextDouble() * 20 + 10;
  final Color color = Colors.blue.withOpacity(0.1);
  final double speed = math.Random().nextDouble() * 0.5 + 0.1;
}

class BubblePainter extends CustomPainter {
  final List<Bubble> bubbles;
  final Animation<double> animation;

  BubblePainter({required this.bubbles, required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    for (var bubble in bubbles) {
      final paint = Paint()
        ..color = bubble.color
        ..style = PaintingStyle.fill;

      final x = bubble.x * size.width;
      final y = (bubble.y + animation.value * bubble.speed) % 1 * size.height;

      canvas.drawCircle(Offset(x, y), bubble.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
} 