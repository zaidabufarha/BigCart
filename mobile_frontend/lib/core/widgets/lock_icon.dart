import 'dart:math' as math;

import 'package:flutter/material.dart';

/// An outline padlock with no keyhole: a rounded body and a round shackle.
/// Material's lock icons all have a keyhole dot, the design doesn't.
/// Takes its colour and size from the surrounding IconTheme like a normal
/// Icon, so text fields tint it the same as their other icons.
class LockIcon extends StatelessWidget {
  final double? size;
  final Color? color;

  const LockIcon({this.size, this.color, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = IconTheme.of(context);
    final s = size ?? theme.size ?? 24;
    // Center so a parent's minimum size (text fields give icons 48x48) adds
    // space around the lock instead of stretching the drawing
    return Center(
      widthFactor: 1,
      heightFactor: 1,
      child: CustomPaint(
        size: Size.square(s),
        painter: _LockPainter(color ?? theme.color ?? Colors.black),
      ),
    );
  }
}

class _LockPainter extends CustomPainter {
  final Color color;

  _LockPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    // drawn on a 24x24 grid, like Material icons, then scaled
    final k = size.width / 24;
    final stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2 * k
      ..strokeCap = StrokeCap.round;

    // body
    canvas.drawRRect(
      RRect.fromLTRBR(5 * k, 10 * k, 19 * k, 21 * k, Radius.circular(2 * k)),
      stroke,
    );
    // shackle: two short uprights joined by a half circle
    final shackle = Path()
      ..moveTo(8 * k, 10 * k)
      ..lineTo(8 * k, 7 * k)
      ..arcTo(
        Rect.fromCircle(center: Offset(12 * k, 7 * k), radius: 4 * k),
        math.pi,
        math.pi,
        false,
      )
      ..lineTo(16 * k, 10 * k);
    canvas.drawPath(shackle, stroke);
  }

  @override
  bool shouldRepaint(_LockPainter old) => old.color != color;
}
