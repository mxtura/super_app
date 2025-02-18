import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'kitten_game.dart'; // Подключаем саму игру

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Летающий котик'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // Кнопка "Назад"
        ),
      ),
      body: GameWidget(game: KittenGame()), // Запускаем игру
    );
  }
}
