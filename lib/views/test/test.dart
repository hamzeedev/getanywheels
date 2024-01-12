import 'package:flutter/material.dart';
import 'package:getanywheels/consts/paths.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: whiteColor,
      body: Center(
        child: Text("This Is Test Screen"),
      ),
    );
  }
}