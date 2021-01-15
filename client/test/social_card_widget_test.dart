import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:polimi_app/components/social_card.dart';

void main() {
  testWidgets('Social card test', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidgetWithScaffold(SocialCard(
      icon: "assets/icons/google-icon.svg",
      press: () {},
    )));

    await tester.pumpAndSettle();
    expect(
        find.byWidgetPredicate(
            (widget) =>
                widget is GestureDetector &&
                (widget.child is Container &&
                    (widget.child as Container).child is SvgPicture),
            description: "GestureDetector with SvgPicture as descendant"),
        findsOneWidget);
  });
}

Widget buildTestableWidgetWithScaffold(Widget widget) {
  return MaterialApp(home: Scaffold(body: widget));
}
