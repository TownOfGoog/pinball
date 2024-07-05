import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:forge2d/forge2d.dart';
import 'package:flutter/material.dart';
import 'ball.dart';

class Bouncer extends BodyComponent with ContactCallbacks, HasGameRef<Forge2DGame> {
  final Vector2 initialPosition;
  late CircleShape shape;
  Paint paint;

  Bouncer(this.initialPosition)
      : paint = Paint()..color = Colors.blue; // Initial color

  @override
  Body createBody() {
    shape = CircleShape()..radius = 5.0; // Adjust radius as needed
    final fixtureDef = FixtureDef(shape)
      ..restitution = 1.0 // Adjust restitution (bounciness)
      ..density = 1.0 // Adjust density
      ..friction = 0.0; // Adjust friction

    final bodyDef = BodyDef()
      ..position = initialPosition
      ..type = BodyType.kinematic; // Kinematic body type, unaffected by gravity

    final body = world.createBody(bodyDef);
    body.createFixture(fixtureDef);
    body.userData = this; // Set user data to this component for collision identification

    return body;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final topLeft = body.position - Vector2(shape.radius, shape.radius);
    canvas.drawCircle(topLeft.toOffset(), shape.radius, paint);
  }

  @override
  void beginContact(Object other, Contact contact) {
    if (other is FallingBall) {
      print('Collision detected with FallingBall');
      // Change color upon collision
      paint.color = Colors.red;
      // Revert to original color after a tenth of a second
      Future.delayed(Duration(milliseconds: 100), () {
        paint.color = Colors.blue;
      });
    }
  }
}
