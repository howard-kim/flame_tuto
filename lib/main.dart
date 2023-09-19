import 'package:flame/game.dart';
import 'package:flame_tuto/racing_game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const FlameTuto());
}

class FlameTuto extends StatelessWidget {
  const FlameTuto({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flame Tutorial',
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        body: GameWidget(
          game: RacingGame(),
        ),
      ),
    );
  }
}
