
import 'dart:math';
import 'package:flame/components/component.dart';
import 'package:befluttermyfriend/game/enemy.dart';
import 'package:befluttermyfriend/game/explosion.dart';
import 'package:befluttermyfriend/global.dart';
import 'package:befluttermyfriend/game/game.dart';

Random random = Random();

class Bullet extends SpriteComponent {
  // DECLARACION DE VARIABLES
  // Propiedades de los mochis (balas)
  final double initialX, initialY;
  List<Enemy> enemyList;
  bool explode;

  //CONSTRUCTOR
  Bullet(this.initialX, this.initialY, this.enemyList)
    : super.rectangle(kBulletWidth, kBulletHeight, mochiAssets[random.nextInt(mochiAssets.length)]) {
      x = initialX;
      y = initialY;
    }

  @override
  void update(double t) {
    // Contemplar la posibilidad de pause
    // Desplacamiento de las balas
    y -= pause ? 0 : kBulletSpeed * t;

    //Comprobar si hay colision
    if (!gameOver) collideControl();
  }

  @override
  bool destroy() {
    if (y == null) return false;

    /* No podemos acceder a la propiedad tamaño en este metodo,
     * entonces usamos la variable maxY
     */
    bool reachToTop = y <= 0;

    return reachToTop || gameOver || explode; // Falta saber si la bala se ha destruido
  }

  void collideControl() {
    if (enemyList.isNotEmpty) {
      enemyList.forEach((enemy) {
        bool collide = enemy.toRect().contains(this.toRect().topRight) ||
            enemy.toRect().contains(this.toRect().topCenter) ||
            enemy.toRect().contains(this.toRect().topLeft);
        if (collide) {
          score += 1;
          enemy.explode = true;
          this.explode = true;
          enemyList.remove(enemy);
          // Nueva explosion
        }
      });
    }
  }
}
