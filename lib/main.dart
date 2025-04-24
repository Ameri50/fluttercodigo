import 'package:app_clase/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  // ignore: unnecessary_new
  runApp(new MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen()
    );
  }
}