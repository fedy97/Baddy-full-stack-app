import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:polimi_app/components/custom_surfix_icon.dart';

void main() {
  testWidgets('Custom surfix icon widget test', (WidgetTester tester) async {
    final imagePath = "assets/icons/User.svg";

    await tester
        .pumpWidget(buildTestableWidget(CustomSurffixIcon(svgIcon: imagePath)));

    expect(
        find.byWidgetPredicate(
            (widget) => widget is Padding && widget.child is SvgPicture,
            description: "Padding with SvgPicture"),
        findsOneWidget);
  });
}

Widget buildTestableWidget(Widget widget) {
  return MaterialApp(home: widget);
}
