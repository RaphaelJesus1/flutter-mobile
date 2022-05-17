import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:guess_the_colors_flutter/form.dart';

void main() {
  runApp(GuessTheColors());
  // WidgetsFlutterBinding.ensureInitialized();
}

class GuessTheColors extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GameForm()
    //     home: SplashScreen(
    //   seconds: 5,
    //   title: const Text(
    //     "Guess the colors",
    //     style: TextStyle(
    //         color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 30),
    //   ),
    //   navigateAfterSeconds: GameForm(),
    //   // image: ,
    //   // photoSize: ,
    //   backgroundColor: Colors.amber.shade100,
    // )
    );
  }
}
