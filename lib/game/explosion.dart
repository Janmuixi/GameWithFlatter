import 'package:flame/animation.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/sprite.dart';
import 'package:befluttermyfriend/global.dart';

class Explosion extends AnimationComponent {
  static const TIME = 0.8;

  // CONSTRUCTOR
  // Creamos una animacion de un solo frame para la empezar la colision
  Explosion(double positionX, double positionY)
      : super.sequenced(kEnemySize, kEnemySize, 'explosion/2.png', 1, textureWidth: 31.0, textureHeight: 31.0) {
    this.x = positionX;
    this.y = positionY;

    List<int> frameSequence = [ 3, 4, 5, 6, 7, 8, 9];

    // Animamos la colision con el resto de sprites
    List<Frame> frames = frameSequence.map((i) =>
      Frame(Sprite('explosion/${i}.png'), TIME / 8)).toList();
    this.animation.frames += frames;

    // Cambimos la duracion del sprite inicial
    this.animation.frames[0].stepTime = TIME / 8;
  }

  // Al terminar la animacion destruye la animacion
  bool destroy() {
    return this.animation.isLastFrame;
  }
}