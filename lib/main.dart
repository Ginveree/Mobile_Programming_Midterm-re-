import 'dart:async';

import 'package:flutter/material.dart';
import 'menu.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rent a Room',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 7),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (content) => const HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Rent A Room",
              style: TextStyle(
                fontSize: 30.0,
                fontFamily: 'Indies',
                fontStyle: FontStyle.italic,
              )),
          Image.asset('assets/images/room.gif', scale: 4),
        ],
      )),
    );
  }
}
