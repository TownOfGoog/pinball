import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:forge2d/forge2d.dart';

class LeftHitbox extends BodyComponent with HasGameRef<Forge2DGame> {
  @override
  Body createBody() {
    final screenSize = gameRef.size;
    final shape = PolygonShape()
      ..set([
        Vector2(-5, -screenSize.y * 5),  // Bottom-left corner
        Vector2(5, -screenSize.y * 5),   // Bottom-right corner
        Vector2(5, screenSize.y * 5),    // Top-right corner
        Vector2(-5, screenSize.y * 5),   // Top-left corner
      ]);

    final fixtureDef = FixtureDef(shape)
      ..restitution = 0.0 // Adjust as needed
      ..density = 0.0 // Static body, no density
      ..friction = 0.0; // Adjust as needed

    final bodyDef = BodyDef()
      ..position = Vector2(-5, screenSize.y / 2) // Position at the left edge of the screen
      ..type = BodyType.static; // Static body type

    final body = gameRef.world.createBody(bodyDef);
    body.createFixture(fixtureDef);

    return body;
  }
}


class RightHitbox extends BodyComponent with HasGameRef<Forge2DGame> {
  @override
  Body createBody() {
    final screenSize = gameRef.size;
    final shape = PolygonShape()
      ..set([
        Vector2(-5, -screenSize.y * 5),  // Bottom-left corner
        Vector2(5, -screenSize.y * 5),   // Bottom-right corner
        Vector2(5, screenSize.y * 5),    // Top-right corner
        Vector2(-5, screenSize.y * 5),   // Top-left corner
      ]);

    final fixtureDef = FixtureDef(shape)
      ..restitution = 0.0 // Adjust as needed
      ..density = 0.0 // Static body, no density
      ..friction = 0.0; // Adjust as needed

    final bodyDef = BodyDef()
      ..position = Vector2(screenSize.x + 5, screenSize.y / 2) // Position at the right edge of the screen
      ..type = BodyType.static; // Static body type

    final body = gameRef.world.createBody(bodyDef);
    body.createFixture(fixtureDef);

    return body;
  }
}
