
import 'package:befluttermyfriend/game/bullet.dart';
import 'package:befluttermyfriend/game/enemy.dart';
import 'package:befluttermyfriend/game/game.dart';
import 'package:befluttermyfriend/global.dart';
import 'package:flame/components/component.dart';
import 'package:flame/flame.dart';
import 'package:test_api/test_api.dart';

void main() async {
  //

  // Flame.images.loadAll(['dragon.png', 'gun.png']);
  /*group("Game class test", () {
    // No se por que no funciona al llamar el metodo createEnemies de Game
    test("Creating enemies, correct way", () {
      // Expected
      int maxExpected = 6;
      int minExpected = 1;

      // Given
      int maxEnemies = 6;

      // When
      Game game = Game();
      game.createEnemies(maxEnemies);
      game.update(4.0);

      // Then
      expect(game.enemies <= maxExpected, equals(true));
      expect(game.enemies >= minExpected, equals(true));
    });

    test("Creating enemies, result can be 0", () {
      // Expected
      int expected = 1;

      // Given
      int maxEnemies = 0;

      // When
      Game game = Game();
      game.createEnemies(maxEnemies);

      // Then
      expect(game.enemies == expected, equals(true));
    });
  });*/


  group('Enemy test', () {
    test('test get/set x/y', () {
      double xPosition = 50;
      double yPosition = 10;
      PositionComponent enemy = new Enemy(xPosition, yPosition, 1);

      expect(enemy.toPosition().x, xPosition);
      expect(enemy.toPosition().y, yPosition);
    });

    test('test get/set widt/height or size', () {
      // Peta por un problema con la imagen
      double xPosition = 50;
      double yPosition = 10;
      PositionComponent enemy = new Enemy(xPosition, yPosition, 1);

      expect(enemy.toSize().x, kEnemySize);
      expect(enemy.toSize().y, kEnemySize);
    });

    test('test get/set rect', () {
      double xPosition = 50;
      double yPosition = 10;
      PositionComponent enemy = new Enemy(xPosition, yPosition, 1);

      expect(enemy.toRect().topLeft.dx, xPosition);
      expect(enemy.toRect().topLeft.dy, yPosition);
      expect(enemy.toRect().width, kEnemySize);
      expect(enemy.toRect().height, kEnemySize);
    });
  });

  group('Bullet test', () {
    List<Enemy> enemies = [];

    test('test get/set x/y', () {
      double xPosition = 50;
      double yPosition = 10;
      PositionComponent bullet = new Bullet(xPosition, yPosition, enemies);

      expect(bullet.toPosition().x, xPosition);
      expect(bullet.toPosition().y, yPosition);
    });

    test('test get/set widt/height or size', () {
      // Peta por un problema con la imagen
      double xPosition = 50;
      double yPosition = 10;
      //PositionComponent bullet;
      PositionComponent bullet = new Bullet(xPosition, yPosition, enemies);

      /*try {
        bullet = new Bullet(xPosition, yPosition, enemies);
      } catch (e) {
        print("ERROR: \n\n");
        print(e.toString());
      }*/

      expect(bullet?.toSize()?.x, kBulletWidth);
      expect(bullet?.toSize()?.y, kBulletHeight);
    });

    test('test get/set rect', () {
      double xPosition = 50;
      double yPosition = 10;
      PositionComponent bullet = new Bullet(xPosition, yPosition, enemies);

      expect(bullet.toRect().topLeft.dx, xPosition);
      expect(bullet.toRect().topLeft.dy, yPosition);
      expect(bullet.toRect().width, kBulletWidth);
      expect(bullet.toRect().height, kBulletHeight);
    });
  });
}
