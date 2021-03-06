import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class GameData {
  int r, g, b, a;
  int correct;
  List<String> options;

  GameData(this.r, this.g, this.b, this.a, this.correct, this.options);
  GameData.empty(
      {this.r = -1,
      this.g = -1,
      this.b = -1,
      this.a = -1,
      this.correct = -1,
      this.options = const []});
}

class GameForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GameFormState();
}

class _GameFormState extends State<GameForm> {
  GameData _data = GameData.empty();
  int? _selectedOption = -1;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getAndSetData();
  }

  void getAndSetData() async {
    setState(() {
      _isLoading = true;
    });
    Future<Response> promise = http.get(Uri.parse(
        "https://7c2bad50.us-south.apigw.appdomain.cloud/api/guessColors"));

    GameData result = await promise.then((response) {
      final data = jsonDecode(response.body);
      return GameData(data['r'], data['g'], data['b'], data['a'],
          data['correto'], new List<String>.from(data['opcoes']));
    });

    setState(() {
      _data = result;
      _isLoading = false;
    });
  }

  void resetGame() {
    getAndSetData();
  }

  Widget getOptions() {
    return Column(children: new List<Widget>.from(_data.options.map((option) {
      int index = _data.options.indexOf(option);
      return ListTile(
        title: Text(option),
        leading: Radio<int>(
            value: index,
            groupValue: _selectedOption,
            onChanged: (int? value) {
              setState(() {
                _selectedOption = value;
              });
            }),
      );
    })));
  }

  void checkResult() {
    String result = _selectedOption == _data.correct ? "Correct!" : "Incorrect";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Your Guess Is...'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[Text(result)],
            ),
          ),
          actions: <Widget>[
            TextButton(
                child: const Text('Get Next'),
                onPressed: () {
                  Navigator.of(context).pop();
                  resetGame();
                }),
          ],
        );
      },
    );
  }

  Widget renderForm() {
    return Column(children: <Widget>[
        Container(
            height: 150,
            color:
                Color.fromARGB(_data.a, _data.r, _data.g, _data.b) // fromARGB()
            ),
        Expanded(
            child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Center(
                child: Text("Try to guess the color:"),
              ),
              getOptions(),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: ElevatedButton(
                onPressed: checkResult,
                child: Text("Check your guess"),
              ))
            ],
          ),
        ))
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text("Guess the Colors"),
        centerTitle: true,
      ),
      body: _isLoading
        ? Center(child: new CircularProgressIndicator(),)
        : renderForm()
    ));
  }
}
