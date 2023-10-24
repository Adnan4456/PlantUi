import 'package:flutter/material.dart';
import 'package:plant_ui/presentation/onboarding_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Onboarding Screen',
      home: OnBoardingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}