import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plant_ui/constants.dart';
import 'package:plant_ui/presentation/create_page.dart';
import 'package:plant_ui/presentation/onboarding_screen.dart';

void main() {

  testWidgets('OnBoardingScreen UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(
        const MaterialApp(
            home: OnBoardingScreen()
        )
    );

    // Check if Skip button is displayed
    expect(find.byKey(const Key('Skip')), findsOneWidget);

    // Swipe to the next page (second CreatePage widget) with an adjusted offset
    await tester.drag(find.byType(PageView), const Offset(-600, 0));
    await tester.pumpAndSettle();


    // Check if the second page is displayed
    expect(find.text(Constants.titleTwo), findsOneWidget);
    expect(find.text(Constants.descriptionTwo),findsOneWidget);
    expect(find.text(Constants.titleOne),findsNothing);

    // Swipe to the next page (third CreatePage widget) with an adjusted offset
    await tester.drag(find.byType(PageView), const Offset(-600, 0));
    await tester.pumpAndSettle();

    // Check if the second page is displayed
    expect(find.text(Constants.titleThree), findsOneWidget);

  });

  testWidgets('CreatePage UI Test', (WidgetTester tester) async {
    // Create a test CreatePage widget
    const String testImage ="assets/images/plant-two.png";
    final String testTitle = Constants.titleTwo;
    final String testDescription = Constants.descriptionTwo;

    await tester.pumpWidget(MaterialApp(
      home: CreatePage(
        image: testImage,
        title: Constants.titleTwo,
        description: Constants.descriptionTwo
      ),
    ));

    // Check if the elements are correctly displayed
    expect(find.text(testTitle), findsOneWidget);
    expect(find.text(testDescription), findsOneWidget);
  });

  testWidgets("click on next button ", (WidgetTester tester) async {

    await tester.pumpWidget(
        const MaterialApp(
            home: OnBoardingScreen()
        )
    );

    // Check if forward  button is displayed
    expect(find.byKey(const Key('Next')), findsOneWidget);

    //first page is shown
    expect(find.text(Constants.titleOne), findsOneWidget);
    expect(find.text(Constants.descriptionOne),findsOneWidget);
    expect(find.text(Constants.titleTwo),findsNothing);

    //Now perform the click on button
    await tester.tap(find.byKey(const Key("Next")));
    // Wait for the UI to rebuild after the tap action
    await tester.pumpAndSettle();

    // Now check on click PageView load second page
    expect(find.text(Constants.titleTwo), findsOneWidget);
    expect(find.text(Constants.descriptionTwo),findsOneWidget);
    expect(find.text(Constants.titleOne),findsNothing);

  });
}