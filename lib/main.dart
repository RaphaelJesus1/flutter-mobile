import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:guess_the_colors_flutter/form.dart';

void main() {
  runApp(GuessTheColors());
}

class GuessTheColors extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(
        seconds: 5,
        title: const Text(
          "Guess the colors",
          style: TextStyle(
            color: Colors.indigo,
            fontWeight: FontWeight.bold,
            fontSize: 30
          ),
        ),
        navigateAfterSeconds: GameForm(),
        image: const Image(image: AssetImage('assets/logo.png')),
        photoSize: 100,
        backgroundColor: Colors.white,
      )
    );
  }
}
