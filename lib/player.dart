import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_tuto/star.dart';

import 'package:flutter/material.dart';

class Player extends RectangleComponent with TapCallbacks, CollisionCallbacks {
  static const playerSize = 96.0;
  int totalCount = 0;
  late TextComponent textComponent;

  Player({required position})
      : super(
          position: position,
          size: Vector2.all(playerSize),
          anchor: Anchor.topCenter,
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    paint.color = Colors.blue;
    add(RectangleHitbox(size: Vector2.all(playerSize)));

    textComponent = TextComponent(
      text: '$totalCount',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 40, color: Colors.white),
      ),
      anchor: Anchor.center,
      position: Vector2(playerSize / 2, playerSize / 2),
    );
    add(textComponent);
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is Star) {
      textComponent.text = '${++totalCount}';
      print('$totalCount');
    } else {
      super.onCollisionStart(intersectionPoints, other);
    }
  }
}

  /*
  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    print('Called onTapUp');
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    super.onTapCancel(event);
    print('onTapCancel');
    //사용자가 영역 밖으로 손가락 옮긴 경우 탭 취소!
  }
  */
