import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: SizedBox(child: Text("Accueil"),)),
      body: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(child: Text('Image Etudiant'),),
            SizedBox(
              child: Column(
                children: [
                  Text('nom :'),
                  Text('prénom :'),
                ],
              ),
            ),
          ],
        )
      ),

    );
  }
}
