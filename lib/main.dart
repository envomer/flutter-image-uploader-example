import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(FarbWaehlerApp());

class FarbWaehlerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farbwähler App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FarbWaehlerHomePage(),
    );
  }
}

class FarbWaehlerHomePage extends StatefulWidget {
  @override
  _FarbWaehlerHomePageState createState() => _FarbWaehlerHomePageState();
}

class _FarbWaehlerHomePageState extends State<FarbWaehlerHomePage> {
  Color _currentColor = Colors.white;

  void _generateRandomColor() {
    final random = Random();
    setState(() {
      _currentColor = Color.fromRGBO(
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        1,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welche Farbe heute?')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              color: _currentColor,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generateRandomColor,
              child: Text('Generiere Farbe'),
            )
          ],
        ),
      ),
    );
  }
}
