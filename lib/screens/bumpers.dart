import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'ball.dart'; // Import your ball class here

class Bumper extends BodyComponent with HasGameRef<Forge2DGame> {
  final Paint paint = Paint()..color = Colors.orange; // Paint object for rendering
  final Vector2 initialPosition;
  final double width;
  final double height;
  final double angularImpulse; // Rotational impulse for this bumper

  Bumper(this.initialPosition, {this.width = 250.0, this.height = 20.0, this.angularImpulse = 10.0});

  @override
  Body createBody() {
    final shape = PolygonShape();
    final vertices = [
      Vector2(-width / 2, height / 2),  // Top-left
      Vector2(width / 2, height / 2),   // Top-right
      Vector2(0, -height / 2),          // Bottom-center (angled part)
    ];

    shape.set(vertices);

    final fixtureDef = FixtureDef(shape)
      ..restitution = 0.3 // Adjust restitution as needed
      ..density = 1.0;     // Adjust density as needed

    final bodyDef = BodyDef()
      ..position = initialPosition
      ..type = BodyType.static; // Static body type

    final body = gameRef.world.createBody(bodyDef);
    body.createFixture(fixtureDef);

    return body;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final path = Path();
    path.moveTo(-width / 2, height / 2);  // Top-left
    path.lineTo(width / 2, height / 2);   // Top-right
    path.lineTo(0, -height / 2);          // Bottom-center (angled part)
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  void onCollision(Set<Vector2> points, other) {
    if (other is FallingBall) {
      // Handle collision with ball
      // Example: Change bumper color
      paint.color = Colors.red;

      // Determine the direction of rotation based on the collision point
      final collisionPoint = points.first; // Assuming only one collision point
      final bumperCenter = body.worldCenter;
      final relativeCollisionPoint = collisionPoint - bumperCenter;
      
      // Calculate the sign of the angular impulse based on the relative position
      final sign = relativeCollisionPoint.x.sign; // Positive or negative based on x-axis

      // Apply rotational impulse to the bumper's body with direction
      final bumperBody = body;
      bumperBody.applyAngularImpulse(sign * angularImpulse);

      // Revert bumper color after a short delay
      Future.delayed(Duration(milliseconds: 100), () {
        paint.color = Colors.orange;
      });
    }
  }
}
