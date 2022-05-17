import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class GameData {
  int r, g, b, a;
  bool correct;
  List<String> options;

  GameData(this.r, this.g, this.b, this.a, this.correct, this.options);
}

class GameForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GameFormState();
}

class _GameFormState extends State<GameForm> {
  late GameData _data;

  @override
  void initState() {
    super.initState();
    getAndSetData();
  }

  void getAndSetData() async {
    Future<Response> promise = http.get(Uri.parse(
        "https://7c2bad50.us-south.apigw.appdomain.cloud/api/guessColors"));

    GameData result = await promise.then((response) {
      final data = jsonDecode(response.body);
      return GameData(
          data['r'], data['g'], data['b'], data['a'], data['correct'], data['options']);
    });

    setState(() {
      _data = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text("Guess the Colors"),
        centerTitle: true,
      ),
      body: // statefull component
      Column(children: <Widget>[
        Container(height: 150, color: Colors.amber // fromARGB()
            ),
        Expanded(
            child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Center(
                child: Text("Try to guess the color:"),
              ),
              // RadioGroup()
              SizedBox(
                height: 20,
              ),
              Center(
                  child: ElevatedButton(
                onPressed: () => print(_data),
                child: Text("Check your guess"),
              ))
            ],
          ),
        ))
      ]),
    ));
  }
}
