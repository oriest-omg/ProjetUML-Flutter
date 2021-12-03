import 'package:flutter/material.dart';
import 'widgets/home_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Projet UML',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Connexion(),
    );
  }
}

