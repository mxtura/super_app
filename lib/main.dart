import 'package:flutter/material.dart';
import 'game_screen.dart'; // Экран игры
import 'hobby_app.dart';  // Приложение "Мое хобби"
import 'photo_app.dart';  // Новое приложение "Фото и Пятачок"

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Каталог приложений',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AppCatalog(),
    );
  }
}

// Главное меню - Каталог всех приложений
class AppCatalog extends StatelessWidget {
  const AppCatalog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Каталог приложений')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GameScreen()),
                );
              },
              child: const Text('🎮 Играть в "Летающего Котика"'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HobbyApp()),
                );
              },
              child: const Text('🎬 Открыть "Мое хобби"'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PhotoApp()),
                );
              },
              child: const Text('📸 Фото и Пятачок'),
            ),
          ],
        ),
      ),
    );
  }
}
