import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:quran_journey/core/theme/quran_journey_palette.dart';

/// Islamic lattice: scroll-linked rotation (no always-on ticker — test-friendly).
class IslamicLatticeBackground extends StatelessWidget {
  const IslamicLatticeBackground({
    super.key,
    required this.palette,
    required this.page,
  });

  final QuranJourneyPalette palette;
  final double page;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _LatticePainter(
        rotation: page * 0.35,
        parallax: page,
        palette: palette,
      ),
      size: Size.infinite,
    );
  }
}

class _LatticePainter extends CustomPainter {
  _LatticePainter({
    required this.rotation,
    required this.parallax,
    required this.palette,
  });

  final double rotation;
  final double parallax;
  final QuranJourneyPalette palette;

  @override
  void paint(Canvas canvas, Size size) {
    final base = palette.emerald.withValues(alpha: 0.06);
    final stroke = palette.goldMuted.withValues(alpha: 0.12);
    final glow = palette.gold.withValues(alpha: 0.04);

    final rect = Offset.zero & size;
    final gradient = RadialGradient(
      center: Alignment(0.15 - parallax * 0.04, -0.35),
      radius: 1.15,
      colors: [
        palette.goldSubtle.withValues(alpha: 0.22),
        base,
        palette.emeraldMuted.withValues(alpha: 0.08),
      ],
      stops: const [0.0, 0.45, 1.0],
    );
    canvas.drawRect(rect, Paint()..shader = gradient.createShader(rect));

    final orb = Offset(size.width * (0.78 + parallax * 0.02), size.height * 0.18);
    canvas.drawCircle(
      orb,
      size.shortestSide * 0.42,
      Paint()..color = glow,
    );

    canvas.save();
    canvas.translate(size.width * 0.5, size.height * 0.42);
    canvas.rotate(rotation + parallax * 0.08);
    const step = 72.0;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.9
      ..color = stroke;

    for (double x = -size.width; x < size.width; x += step) {
      for (double y = -size.height; y < size.height; y += step) {
        _drawStar(canvas, Offset(x, y), 14, 6, paint);
      }
    }
    canvas.restore();
  }

  void _drawStar(Canvas canvas, Offset c, double outer, double inner, Paint paint) {
    const tips = 8;
    final path = Path();
    for (int i = 0; i < tips * 2; i++) {
      final r = i.isEven ? outer : inner;
      final a = -math.pi / 2 + (i * math.pi / tips);
      final p = Offset(c.dx + r * math.cos(a), c.dy + r * math.sin(a));
      if (i == 0) {
        path.moveTo(p.dx, p.dy);
      } else {
        path.lineTo(p.dx, p.dy);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _LatticePainter oldDelegate) {
    return oldDelegate.rotation != rotation ||
        oldDelegate.parallax != parallax ||
        oldDelegate.palette != palette;
  }
}
