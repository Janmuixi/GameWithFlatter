
import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:befluttermyfriend/game/bullet.dart';
import 'package:befluttermyfriend/game/enemy.dart';
import 'package:befluttermyfriend/global.dart';

Game game;
class Game extends BaseGame {
  // DECLARACION DE VARIABES

  /* Botones, Sprites de botones,
   * Enemigos, Velocidad, Respawn
   */
  List<Enemy> _enemyList;
  double _enemySpeed;
  double _timer;
  double _creationTime;

  SpriteComponent _gameOverButton;
  SpriteComponent _pauseButton;

  // FUENTES
  TextConfig scoreText = TextConfig(fontSize: 13.0,
      fontFamily: "Goodlight", color: Colors.pink[200]);

  TextConfig titleText = TextConfig(fontSize: 20.0,
      fontFamily: "Roundish Toons", color: Colors.pink[200]);

  // CONSTRUCTOR JUEGO
  Game() {
    _start();
  }

  void _start() async {
    // Añadir musica

    Size size = await Flame.util.initialDimensions();

    // Hacer Boton de Pause
    _pauseButton = SpriteComponent.square(kPauseButtonSize, "pause-button.png");
    // Posicion del boton en pantalla (X, Y)
    _pauseButton.x = size.width - (kPauseButtonSize / 2);
    _pauseButton.y = 30;
    // Inicializar partida
    gameOver = false;
    pause = false;
    _enemyList = <Enemy>[];
    _enemySpeed = kEnemyInitialSpeed;
    _gameOverButton = null;
    _creationTime = kInitialCreationTime;
    _timer = _creationTime - 1;
    score = 0;

    add(_pauseButton);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    /* Configurar texto Puntuaciones
     * Puntuacion maxima y puntuacion actual
     */
    scoreText.render(canvas, "Highest score: " + highScore.toString(), Position(5, 30));
    scoreText.render(canvas, "Score: " + score.toString(), Position(5, 30));
    if (gameOver) {
      // Configurar texto Game Over
      titleText.render(canvas, "Game Over", Position(size.width / 6, size.height / 3));
    }

    if (pause) {
      titleText.render(canvas, "Pause", Position(size.width / 3.3, size.height / 3));
    }
  }

  @override
  void update(double t) {
    // Si pausamos el juego se deja de aumentar el timer
    _timer += pause ? 0 : t;

    /* Si no se ha acabado la partida y ha transcurrido el tiempo establecido (creationTime),
     * reiniciamos el temporizador (timer), reducidmos el tiempo de creacion de enemigos,
     * aumentamos la velocidad y generamos los enemigos
     */
    if (_timer >= _creationTime && !gameOver) {
      _timer = 0.0;
      _creationTime -= _creationTime <= 1 ? 0 : 0.02; // Si el tiempo de creacion es <1 dejamos de reducirlo
      _enemySpeed += 5;

      // CREAR ENEMIGOS
      // Calcular la posicion inicial de forma random
      double startPosition = random.nextInt(
          (size.width - kEnemySize * 4).round()
      ) + 0.0; // Se suma 0.0 para transformar en double

      // Inicializar enemigo y añadirlo a los componentes
      Enemy enemy = Enemy(startPosition, 0, _enemySpeed);
      // Lista de enemigos
      add(enemy);

    }

    /*

     */
    if (gameOver && _gameOverButton == null) {
      // Hacer Boton de Game Over (reiniciar partida)
      _gameOverButton = SpriteComponent.square(kRestartGameButtonSize, "restart-button.png");
      _gameOverButton.x = (size.width - 2) - (kRestartGameButtonSize / 2);
      _gameOverButton.y = (size.height - 2) - (kRestartGameButtonSize / 2);
      // Comprobar puntuacion (¿Hay un nuevo record?)
      if (score > highScore) highScore = score;
      /* Se añade el boton Game Over (reiniciar) a los componentes
       * y quitamos el boton de pause
       */

      add(_gameOverButton);
      components.remove(_pauseButton);
    }

    super.update(t);
  }

  void handleTapDown(Offset position) {
    /* Si lse toca la pantalla, obtenemos las coordenadas de pulsacion para
     * establecer las acciones de cada boton/elemento en pantalla
     */
    if (!gameOver) {
      if (!pause) { // Si la partida esta en marcha
        if (_pauseButton.toRect().contains(position)) {
          pause = true;
          /* Si queremos sustituir el sprite de pause por el de play
           * una vez pulsado, lo hariamos aqui
           */
        } else {
          // Generar un mochi donde el usuario a pulsado
          Bullet bullet = new Bullet(position.dx, position.dy, _enemyList);
          add(bullet);
        }

      } else { // Si hacemos Pause
        if (_pauseButton.toRect().contains(position)) {
          pause = false;
          /* Si queremos sustituir el sprite de play por el de pause
           * una vez pulsado, lo hariamos aqui
           */
        }
      }

    } else { // Si hacemos Game Over
      if (_gameOverButton.toRect().contains(position)) {
        // Eliminamos de los componentes (pantalla) el boton de Game Over
        components.remove(_gameOverButton);
        // Reiniciar la partida
      }
    }
  }

  void restart() {
    /* Añadir inicializacion del juego (Configurar variables
     * por defecto, tiempo, enemigos, velocidad)
     */
  }


  // FUNCIÓN PARA CREAR UN RANDOM EN UN RANGO DE VALORES
  int _randomRange(int min, int max) {
    return random.nextInt(max - min) + min;
  }
}
