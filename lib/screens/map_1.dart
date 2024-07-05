import 'dart:math' as math;
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:pinball/screens/bumpers.dart';
import 'package:pinball/screens/spawn_indicator.dart';
import 'counter.dart'; // Adjust this import based on your project structure
import 'bouncer.dart';
import 'walls.dart';
import 'ground.dart';
import 'ball.dart';
import 'objects.dart';
import 'altBall.dart';
import 'package:sensors/sensors.dart';

class MyGame extends Forge2DGame with HasCollisionDetection {
  final int maxBalls = 100; // Maximum number of balls that can be spawned
  int ballCount = 0; // Counter for the number of balls spawned
  int score = 0; // Current score

  late Bouncer bouncer;
  late Bouncer bouncer1;
  late TextComponent scoreText; // TextComponent for the score
  late SpawnIndicator spawnIndicator; // Spawn indicator
  late Bumper leftBumper;
  late Bumper rightBumper;


  late Bouncer bouncer2;
  late Bouncer bouncer3;
  late Bouncer bouncer4;
  late Bouncer bouncer5;
  late Bouncer bouncer6;
  late Bouncer bouncer7;
  late Bouncer bouncer8;
  late Bouncer bouncer9;
  late Bouncer bouncer10;
  late Bouncer bouncer11;
  late Bouncer bouncer12;
  late Bouncer bouncer13;
  late Bouncer bouncer14;
  late Bouncer bouncer15;
  late Bouncer bouncer16;
  late Bouncer bouncer17;
  late Bouncer bouncer18;


  double spawnTime = 0.0; // Timer variable
  double spawnPositionX = 0.0; // Current spawn position

  MyGame()
      : super(
          gravity: Vector2(0, 110),
          zoom: 10,
        );

  @override
  Future<void> onLoad() async {
    final screenSize = size;
    super.onLoad();
    add(PinballTable());
    add(LeftHitbox());
    add(RightHitbox());
    debugMode = true;

    leftBumper = Bumper(Vector2(0, screenSize.y - 90), angularImpulse: 10.0);
    add(leftBumper);
    rightBumper = Bumper(Vector2(screenSize.x , screenSize.y - 90), angularImpulse: -10.0);
    add(rightBumper);



    // Initialize ball count text component
    var ballCountText = BallCountText(maxBalls);
    add(ballCountText); // Add ball count text component to the game

    // Initialize score text component
    scoreText = TextComponent(
      text: 'Score: $score',
      textRenderer: TextPaint(
        style: TextStyle(
          color: Colors.green,
          fontSize: 20,
          fontFamily: 'PressStart2P', // Adjust font family if needed
        ),
      ),
      position: Vector2(size.x / 2, 40), // Position as needed
    );
    add(scoreText);

    // Initialize bouncers
    bouncer = Bouncer(Vector2(screenSize.x / 2, screenSize.y / 2));
    add(bouncer);
    final bouncer1 = Bouncer(Vector2(screenSize.x / 3, screenSize.y / 3));
    add(bouncer1);
    final bouncer2 = Bouncer(Vector2(screenSize.x / 8*4, screenSize.y / 9*3));
    add(bouncer2);
    final bouncer3 = Bouncer(Vector2(screenSize.x / 8*3, screenSize.y / 9*3));
    add(bouncer3);
    final bouncer4 = Bouncer(Vector2(screenSize.x / 8*2, screenSize.y / 9*5));
    add(bouncer4);
    final bouncer5 = Bouncer(Vector2(screenSize.x / 8*3, screenSize.y / 9*5));
    add(bouncer5);
    final bouncer6 = Bouncer(Vector2(screenSize.x / 8*4, screenSize.y / 9*5));
    add(bouncer6);
    final bouncer7 = Bouncer(Vector2(screenSize.x / 8*5, screenSize.y / 9*5));
    add(bouncer7);
    final bouncer8 = Bouncer(Vector2(screenSize.x / 8*6, screenSize.y / 9*5));
    add(bouncer8);
    final bouncer9 = Bouncer(Vector2(screenSize.x / 8*7, screenSize.y / 9*5));





    // Initialize spawn indicator
    spawnIndicator = SpawnIndicator(Vector2(screenSize.x / 2, 110)); // Adjusted lower position
    add(spawnIndicator);

    // Initialize accelerometer event subscription
    accelerometerEvents.listen((AccelerometerEvent event) {
      final double shakeThreshold = 240.0; // Adjust as needed
      double acceleration = event.x * event.x + event.y * event.y + event.z * event.z;

      if (acceleration > shakeThreshold) {
        // Additional logic to filter out minor movements
        if (event.x.abs() > 8.0 || event.y.abs() > 8.0 || event.z.abs() > 8.0) {
          // Check if maximum balls limit is reached
          if (ballCount < maxBalls) {
            // Spawn a FallingBall when a visceral shake is detected
            add(FallingBall(Vector2(spawnPositionX, 105))); // Adjust position as needed
            ballCount++; // Increment the ball count
            score += 100; // Increase the score
            scoreText.text = 'Score: $score'; // Update score text
            ballCountText.updateBallCount(maxBalls - ballCount); // Update ball count text
          }
        }
      }
    });

    void incrementScore(int points) {
    score += points;
    scoreText.text = 'Score: $score'; // Update the score text component
  }


  }

  @override
  void update(double dt) {
    super.update(dt);
    final screenSize = size;

    // Update the spawn time
    spawnTime += dt;

    // Calculate the new spawn position
    // Using sinusoidal movement for smooth back and forth motion
    spawnPositionX = screenSize.x / 2 + (screenSize.x / 2 - 10) * math.sin(spawnTime);

    // Ensure the spawn position stays within the screen bounds
    spawnPositionX = spawnPositionX.clamp(10, screenSize.x - 10);

    // Update spawn indicator position
    spawnIndicator.position = Vector2(spawnPositionX, 90); // Adjusted lower position

    // Update ball count text position (top right corner)
  }
}
