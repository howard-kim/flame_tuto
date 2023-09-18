import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  print('load the game widgets');
  runApp(GameWidget(game: MyGame()));
}

class MyGame extends FlameGame {
  SpriteComponent man = SpriteComponent();
  SpriteComponent girl = SpriteComponent();
  SpriteComponent background = SpriteComponent();
  SpriteComponent background2 = SpriteComponent();
  DialogButton dialogButton = DialogButton();
  Vector2 buttonSize = Vector2(50.0, 50.0);

  final double characterSize = 200.0;
  bool turnAway = false;
  int dialogLevel = 0;
  int sceneLevel = 1;

  TextPaint dialogTextPaint = TextPaint(
      style: const TextStyle(fontSize: 36), textDirection: TextDirection.ltr);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final screenWidth = size[0];
    final screenHeight = size[1];
    final textBoxHeight = 100;

    (background2
      ..sprite = await loadSprite('background2.png')
      ..size = size);
    //load background
    add(background
      ..sprite = await loadSprite('background.jpg')
      ..size = Vector2(size[0], size[1] - 100));

    //load girl
    girl
      ..sprite = await loadSprite('girl.png')
      ..size = Vector2(characterSize, characterSize)
      ..y = screenHeight - characterSize - textBoxHeight
      // ..x = characterSize
      ..anchor = Anchor.topCenter;
    add(girl);
    // load man
    man
      ..sprite = await loadSprite('man.png')
      ..size = Vector2(characterSize, characterSize)
      ..y = screenHeight - characterSize - textBoxHeight
      ..x = screenWidth - characterSize
      ..anchor = Anchor.topCenter
      ..flipHorizontally();
    add(man);

    dialogButton
      ..sprite = await loadSprite('next_button.png')
      ..size = buttonSize
      ..position =
          Vector2(size[0] - buttonSize[0] - 10, size[1] - buttonSize[1] - 10);
    add(dialogButton);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (girl.x < size[0] / 2 - 100) {
      girl.x += 50 * dt;
      if (girl.x > 50 && dialogLevel == 0) {
        dialogLevel = 1;
      }
      if (girl.x > 150 && dialogLevel == 1) {
        dialogLevel = 2;
      }
    } else if (turnAway == false && sceneLevel == 1) {
      print('turnAway');
      man.flipHorizontally();
      turnAway = true;
      if (dialogLevel == 2) {
        dialogLevel = 3;
      }
    }
    if (man.x > size[0] / 2 - 50) {
      man.x -= 50 * dt;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    switch (dialogLevel) {
      case 1:
        dialogTextPaint.render(
            canvas,
            'Keiko: Ken, Don\'t'
            ' go... You\'ll die',
            Vector2(10, size[1] - 100.0));
        break;
      case 2:
        dialogTextPaint.render(canvas, 'Ken: I must fight for out village.',
            Vector2(10, size[1] - 100.0));
        break;
      case 3:
        dialogTextPaint.render(canvas, 'Keiko: What about the baby?',
            Vector2(10, size[1] - 100.0));
        add(dialogButton);
        break;
    }
    switch (dialogButton.scene2Level) {
      case 1:
        sceneLevel = 2;
        canvas.drawRect(Rect.fromLTWH(0, size[1] - 100, size[0] - 60, 100),
            Paint()..color = Colors.black);
        dialogTextPaint.render(canvas, 'Keiko: Child? I did not know',
            Vector2(10, size[1] - 100.0));
        print('rendered');
        if (turnAway) {
          man.flipHorizontally();
          turnAway = false;
        }
        break;
    }
  }
}

class DialogButton extends SpriteComponent with TapCallbacks {
  int scene2Level = 0;
  @override
  bool onTapDown(TapDownEvent event) {
    try {
      print('move to next scree');
      scene2Level = 1;

      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
