import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

class SpawnIndicator extends PositionComponent {
  final Paint _paint = Paint()..color = Colors.white;

  SpawnIndicator(Vector2 position)
      : super(
          position: position,
          size: Vector2.all(50.0), // Size of the indicator square
        );

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), _paint);
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Additional update logic if needed
  }
}
