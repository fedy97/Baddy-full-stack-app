import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:polimi_app/components/default_button.dart';
import 'package:polimi_app/components/form_error.dart';
import 'package:polimi_app/screens/profile/components/write_review.dart';

void main() {
  testWidgets('Write review widget test', (WidgetTester tester) async {
    final buttonLabel = "Invia";

    await tester.pumpWidget(buildTestableWidget(WriteReviewWidget()));

    expect(
        find.byWidgetPredicate((widget) => widget is RatingBar,
            description: "Rating bar with static content"),
        findsOneWidget);

    expect(
        find.byWidgetPredicate((widget) => widget is FormError, //already tested
            description: "Customizable form error widget"),
        findsOneWidget);

    expect(
        find.byWidgetPredicate(
            (widget) =>
                widget is DefaultButton &&
                (widget.text == buttonLabel && widget.press != null),
            description: "Customizable form error widget"),
        findsOneWidget);
  });
}

Widget buildTestableWidget(Widget widget) {
  return MaterialApp(home: widget);
}
