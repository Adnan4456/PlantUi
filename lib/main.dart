import 'package:flutter/material.dart';
import 'package:plant_ui/presentation/onboarding_screen.dart';
import 'package:plant_ui/presentation/pages/detail/detail_page.dart';

import 'package:plant_ui/presentation/pages/home/home_page.dart';
import 'package:plant_ui/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Onboarding Screen',
      initialRoute: '/',
      routes: {
        '/': (context) => const OnBoardingScreen(),
        NavigationRoutes.detail: (context) => DetailPage(),

      },
      // home: OnBoardingScreen(),

      // initialRoute: NavigatorRoutes.home,

      debugShowCheckedModeBanner: false,
    );
  }
}