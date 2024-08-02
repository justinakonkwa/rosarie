import 'package:flutter/material.dart';

class MeditationScreen extends StatelessWidget {
  const MeditationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF5F5DC),
              Color(0xFFDEB887),
              Color(0xFFD2B48C),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.bottomLeft,
            stops: [0.0, 3.9, 1.0],
          ),
          image: DecorationImage(
            image: AssetImage('assets/images/font.png'),
          ),
        ),
        child: Center(
          child: Text('meditation screen'),
        ),
      ),
    );
  }
}
