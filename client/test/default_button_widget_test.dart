import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:polimi_app/components/default_button.dart';

void main() {
  //test Default button behaviour
  testWidgets('Default button widget test', (WidgetTester tester) async {
    //Matching parameters
    final buttonText = 'buttonText';
    final textColor = Colors.yellow;
    final backgroundColor = Colors.black;

    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(buildTestableWidget(DefaultButton(
        text: buttonText, textColor: textColor, bgColor: backgroundColor)));

    expect(
        find.byWidgetPredicate(
            (widget) =>
                widget is Text &&
                widget.data == buttonText &&
                widget.style.color == textColor,
            description: "Text widget with parametrized text and color"),
        findsOneWidget); //exactly one text widget with the text and the specified color
    expect(
        find.byWidgetPredicate(
            (widget) =>
                widget is ArgonButton && widget.color == backgroundColor,
            description: "Argon button match with parametrized bg color"),
        findsOneWidget);
  });
}

Widget buildTestableWidget(Widget widget) {
  return MaterialApp(home: widget);
}
