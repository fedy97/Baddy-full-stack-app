import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:polimi_app/components/no_account_text.dart';

void main() {
  testWidgets('"No account" widget test', (WidgetTester tester) async {
    //Matching parameters
    final suggestionText = "Don’t have an account? ";
    final signUpText = "Sign Up";

    await tester.pumpWidget(buildTestableWidget(NoAccountText()));

    final suggestionTextFinder = find.text(suggestionText);

    expect(suggestionTextFinder, findsOneWidget);
    expect(
        find.byWidgetPredicate(
            (widget) =>
                widget is GestureDetector &&
                widget.child is Text &&
                (widget.child as Text).data == signUpText,
            description:
                "Gesture detector with parametrized child Text widget"),
        findsOneWidget);
  });
}

Widget buildTestableWidget(Widget widget) {
  return MaterialApp(home: widget);
}
