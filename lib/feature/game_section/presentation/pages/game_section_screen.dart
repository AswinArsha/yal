import 'package:flutter/material.dart';

class GameSectionScreen extends StatelessWidget {
  const GameSectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bg/game_bg.png'))),
      ),
    );
  }
}
