import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';


class PinballTable extends Component with HasGameRef {
  late SpriteComponent sprite;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = SpriteComponent()
      ..sprite = await gameRef.loadSprite('background.png')
      ..size = Vector2(200, 400) // Adjust size as needed
      ..anchor = Anchor.center; // Adjust anchor point as needed

    final screenSize = gameRef.size;
    sprite.size = screenSize;
    // Get the sprite's original size
    final originalSize = sprite.sprite!.originalSize;

    // Calculate the aspect ratio of the sprite
    final aspectRatio = originalSize.x / originalSize.y;

    // Calculate the new size while maintaining the aspect ratio
    Vector2 newSize;
    if (screenSize.x / aspectRatio <= screenSize.y) {
      // Fit to width
      newSize = Vector2(screenSize.x, screenSize.x / aspectRatio);
    } else {
      // Fit to height
      newSize = Vector2(screenSize.y * aspectRatio, screenSize.y);
    }

    // Set the new size
    sprite.size = newSize;
 // Adjust position as needed
    sprite.position = screenSize / 2; // Center the sprite


    // Add the sprite to the game component list
    gameRef.add(sprite);
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Add custom update logic if needed
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // The sprite is rendered automatically by Flame
  }
}






