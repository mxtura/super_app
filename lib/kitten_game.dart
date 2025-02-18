import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';

class KittenGame extends FlameGame with HasCollisionDetection, TapDetector {
  late Kitten kitten;
  late SpriteComponent background;

  @override
  Future<void> onLoad() async {
    await Flame.device.fullScreen();

    // Загружаем фон
    background =
        SpriteComponent()
          ..sprite = await loadSprite('background.png')
          ..size = size;

    // Добавляем фон перед котиком
    add(background);

    // Добавляем котика
    kitten = Kitten();
    add(kitten);
  }

  @override
  void onTapDown(TapDownInfo info) {
    final touchPosition = info.eventPosition.global;

    kitten.moveTo(touchPosition);
  }
}

class Kitten extends SpriteComponent with HasGameRef<KittenGame> {
  double speed = 300.0; // Скорость движения
  late Vector2 velocity;

  Kitten() : super(size: Vector2.all(80)); // Размер котика

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(
      'cat-acrobat-icon.png',
    ); // Загружаем изображение котика
    position = gameRef.size / 2; // Стартовая позиция - центр экрана
    velocity = Vector2.zero();
  }

  void moveTo(Vector2 target) {
    velocity = (target - position).normalized() * speed;
  }

  @override
  void update(double dt) {
    position += velocity * dt;

    // Проверяем столкновения со стенами
    final screenSize = gameRef.size;
    if (position.x <= 0 || position.x + size.x >= screenSize.x) {
      velocity.x = -velocity.x;
      speed += 100;
      playMeow();
    }
    if (position.y <= 0 || position.y + size.y >= screenSize.y) {
      velocity.y = -velocity.y;
      speed += 100;
      playMeow();
    }
  }

  void playMeow() {
    FlameAudio.play('cat-meow.mp3'); // Проигрываем звук мяу
  }
}
