import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:polimi_app/components/custom_button_role.dart';
import 'package:polimi_app/constants.dart';

void main() {
  testWidgets('Custom button widget test', (WidgetTester tester) async {
    //Matching parameters
    final buttonDescr = 'buttonDescr';
    final imagePath = 'doctor.png';
    final linearGradient = kPrimaryGradientColor;
    final color = Colors.yellow;

    await tester.pumpWidget(buildTestableWidget(CustomButtonRole(
      descr: buttonDescr,
      image: imagePath,
      linearGradient: linearGradient,
      textColor: color,
    )));

    expect(
        find.byWidgetPredicate(
            (widget) =>
                widget is Text &&
                widget.data == buttonDescr &&
                widget.style.color == color,
            description: "Text widget with parametrized text and color"),
        findsOneWidget); //exactly one button with the text and the specified color

    expect(
        find.byWidgetPredicate((widget) =>
            widget is Stack &&
            ((widget.children.elementAt(0) as Container).decoration
                        as BoxDecoration)
                    .gradient ==
                linearGradient),
        //BoxDecoration
        findsOneWidget); //exactly one button with the text and the specified color
    expect(
        find.byType(Image), findsOneWidget); //The button should have one image
  });
}

Widget buildTestableWidget(Widget widget) {
  return MaterialApp(home: widget);
}
