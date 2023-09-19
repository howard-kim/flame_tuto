import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_tuto/player.dart';
import 'package:flutter/material.dart';

class Star extends RectangleComponent with HasGameRef, CollisionCallbacks {
  static const starSize = 64.0;

  Star(position)
      : super(
          position: position,
          size: Vector2.all(starSize),
          anchor: Anchor.bottomCenter,
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    paint.color = Colors.yellow;
    add(RectangleHitbox(size: Vector2.all(starSize)));
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y = position.y + 5;
    if (position.y - size.y > gameRef.size.y) {
      removeFromParent();
    }
  }
/*
  @override
  bool onComponentTypeCheck(PositionComponent other) {
    if (other is Star) {
      return false;
    } else {
      return super.onComponentTypeCheck(other);
    }
  }*/

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is Player) {
      removeFromParent();
    } else {
      super.onCollisionStart(intersectionPoints, other);
    }
  }
}
