
import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:befluttermyfriend/global.dart';

class Enemy extends SpriteComponent {
  // DECLARACION DE VARIABLES
  final double initialx, initialy;
  final double speed;
  bool explode;

  double maxY;

  //CONSTRUCTOR
  Enemy(this.initialx, this.initialy, this.speed)
    : super.square(40, "pleb.png") {
      x = initialx;
      y = initialy;
      explode = false;
  }

  @override
  void update(double t) {
    y += pause ? 0 : speed * t;
  }

  @override
  bool destroy() {
    if (y == null) return false;

    /* No podemos acceder a la propiedad tamaño en este metodo,
     * entonces usamos la variable maxY
     */

    // Comprobar si ha pasado un enemigo
    bool reachToBottom = y >= maxY;

    // Comrobar si ha perdido
    if (reachToBottom) {
      gameOver = true;
    }

    return reachToBottom || gameOver || explode; // Falta saber si esta vivo
  }

  @override
  void resize(Size size) {
    this.maxY = size.height;
  }
}