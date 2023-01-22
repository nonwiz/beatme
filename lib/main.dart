import 'package:beatme/screens/bmi.dart';
import 'package:beatme/screens/intro.dart';
import 'package:beatme/screens/training.dart';
import 'package:beatme/screens/weather.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BeatmeApp());
}

class BeatmeApp extends StatelessWidget {
  const BeatmeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      routes: {
        '/': (context) => IntroScreen(),
        '/bmi': (context) => BmiScreen(),
        '/training': (context) => TrainingScreen(),
        '/weather': (context) => WeatherScreen()
      },
      initialRoute: '/',
    );
  }
}
