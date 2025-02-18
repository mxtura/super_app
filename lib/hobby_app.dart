import 'package:flutter/material.dart';

class HobbyApp extends StatelessWidget {
  const HobbyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const HobbyHomeScreen();
  }
}

// Главный экран
class HobbyHomeScreen extends StatelessWidget {
  const HobbyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Волк с Уолл-Стрит'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // Возвращаемся в каталог приложений
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/wolf_of_wall_street.png', width: 300), // Постер фильма
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GalleryScreen()),
                );
              },
              child: const Text('📷 Галерея'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QuotesScreen()),
                );
              },
              child: const Text('📝 Цитаты и факты'),
            ),
          ],
        ),
      ),
    );
  }
}

// Экран галереи
class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Галерея'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // Возвращаемся назад
        ),
      ),
      body: const Center(child: Text('Тут будут фото, видео, аудио')),
    );
  }
}

// Экран с цитатами и фактами
class QuotesScreen extends StatelessWidget {
  const QuotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Цитаты и факты'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // Возвращаемся назад
        ),
      ),
      body: const Center(child: Text('Интересные моменты из фильма')),
    );
  }
}
