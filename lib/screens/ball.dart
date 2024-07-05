import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class FallingBall extends BodyComponent with HasCollisionDetection, HasGameRef<Forge2DGame> {
  final Vector2 position;

  FallingBall(this.position);


  @override
  Body createBody() {
    final ballSize = gameRef.size.x / 44;
    final shape = CircleShape()..radius = ballSize; // Adjust radius as needed
    final fixtureDef = FixtureDef(shape)
      ..density = 20
      ..restitution = 8.0;
    final bodyDef = BodyDef()
      ..position = position
      ..type = BodyType.dynamic;
    final body = gameRef.world.createBody(bodyDef);

    body.createFixture(fixtureDef);
    body.userData = this; // Set user data to this component for collision identification

    return body;
    
  }

  @override
  void onCollisionStart(Set<Vector2> points, BodyComponent other) {
    print('Collision detected with ${other.runtimeType}');
    // Handle collision logic here
  }
}
