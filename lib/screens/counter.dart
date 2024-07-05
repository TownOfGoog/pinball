import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class BallCountText extends PositionComponent {
  int ballCount;

  BallCountText(this.ballCount);

  @override
  void render(Canvas canvas) {
    final textStyle = TextStyle(
      color: Colors.red,
      fontSize: 20,
    );
    final textSpan = TextSpan(text: 'Balls left: $ballCount', style: textStyle);
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(10, 40)); // Adjust position as needed
  }

  void updateBallCount(int count) {
    ballCount = count;
  }
}
