
import 'package:audioplayers/audioplayers.dart';
import 'package:befluttermyfriend/global.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:befluttermyfriend/game/game.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future main() async {
  Flame.images.loadAll(["pleb.png", "pause-button.png", "restart-button.png"] + mochiAssets); // Añadir las imagenes
  runApp(
    MaterialApp(
      home: GameWrapper()
    )
  );
}


class GameWrapper extends StatelessWidget {

  GameWrapper() {
    // INICIALIZAR JUEGO
    game = Game();

    // Crear un GestureTapRecognizer
    Flame.util.addGestureRecognizer(TapGestureRecognizer()
      ..onTapDown = (TapDownDetails details) => game.handleTapDown(details.globalPosition));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(kImgPath + "background.jpg"),
              fit: BoxFit.cover
          )
        ),
        child: game.widget,
      ),
    );
  }
}
