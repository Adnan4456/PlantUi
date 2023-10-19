// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plant_ui/presentation/onboarding_screen.dart';

void main() {

  testWidgets('OnBoardingScreen Test', (WidgetTester tester) async {
    // Build your app and wrap the OnBoardingScreen with a MaterialApp.
    await tester.pumpWidget(
      const MaterialApp(
        home: OnBoardingScreen(),
      ),
    );

    // Wait for widgets to load.
    await tester.pumpAndSettle();

    // // Test Skip button.
    // expect(find.text('Skip'), findsOneWidget);
    // await tester.tap(find.text('Skip'));
    // await tester.pumpAndSettle();
    //
    // // Check if the app navigates to the LoginScreen.
    // expect(find.byType(LoginScreen), findsOneWidget);

    // You can add more test cases here to interact with the PageView and other UI elements.
  });

}
