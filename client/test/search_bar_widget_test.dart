import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:polimi_app/components/search_box.dart';

void main() {
  testWidgets('Search box test', (WidgetTester tester) async {
    //Matching parameters
    final String defaultHintText = 'Search by city';

    await tester.pumpWidget(buildTestableWidgetWithScaffold(SearchBox()));

    expect(
        find.byWidgetPredicate(
            (widget) =>
                widget is Container &&
                widget.child is TextField &&
                ((widget.child as TextField).decoration.hintText ==
                    defaultHintText) &&
                (widget.child as TextField).decoration.icon is SvgPicture,
            description:
                "TextField with parametrized text and static svg icon"),
        findsOneWidget);
  });
}

Widget buildTestableWidgetWithScaffold(Widget widget) {
  return MaterialApp(home: Scaffold(body: widget));
}
