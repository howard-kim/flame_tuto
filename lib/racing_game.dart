import 'dart:math';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_tuto/player.dart';
import 'package:flame_tuto/star.dart';

class RacingGame extends FlameGame with TapCallbacks, HasCollisionDetection {
  late Player player;
  double nextSpawnSeconds = 0;

  @override
  Future<void> onLoad() async {
    player = Player(
      position: Vector2(size.x / 4, size.y - Player.playerSize),
    );
    add(player);
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    if (!event.handled) {
      final touchPoint = event.canvasPosition;
      if (touchPoint.x > size.x / 2) {
        player.position = Vector2(size.x * 3 / 4, size.y - Player.playerSize);
        print('Right');
      } else {
        player.position = Vector2(size.x / 4, size.y - Player.playerSize);
        print('Left');
      }
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    nextSpawnSeconds -= dt;
    if (nextSpawnSeconds < 0) {
      add(Star(Vector2(size.x * (Random().nextInt(10) > 5 ? 0.75 : 0.25), 0)));
      nextSpawnSeconds = Random().nextDouble();
    }
  }
}
