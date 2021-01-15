import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:polimi_app/components/rating_stars.dart';

void main() {
  testWidgets('Rating stars widget test', (WidgetTester tester) async {
    //Matching parameters
    final threeStars = 3.0;
    final threeStarsAndEpsilon = 3.1;
    final threeAndHalfStars = 3.5;

    //Test three stars rendering
    await tester.pumpWidget(buildTestableWidget(RatingStars(rate: threeStars)));
    expect(
        find.byWidgetPredicate(
            (widget) =>
                widget is Row &&
                widget.children is List<Widget> &&
                ((widget.children.elementAt(0) as Icon).icon == Icons.star &&
                    (widget.children.elementAt(1) as Icon).icon == Icons.star &&
                    (widget.children.elementAt(2) as Icon).icon == Icons.star &&
                    (widget.children.elementAt(3) as Icon).icon ==
                        Icons.star_border &&
                    (widget.children.elementAt(4) as Icon).icon ==
                        Icons.star_border),
            description:
                "List of icons with three full stars and two empty stars"),
        findsOneWidget);

    //Test three stars with few decimal approximation
    await tester.pumpWidget(
        buildTestableWidget(RatingStars(rate: threeStarsAndEpsilon)));
    expect(
        find.byWidgetPredicate(
            (widget) =>
                widget is Row &&
                widget.children is List<Widget> &&
                ((widget.children.elementAt(0) as Icon).icon == Icons.star &&
                    (widget.children.elementAt(1) as Icon).icon == Icons.star &&
                    (widget.children.elementAt(2) as Icon).icon == Icons.star &&
                    (widget.children.elementAt(3) as Icon).icon ==
                        Icons.star_border &&
                    (widget.children.elementAt(4) as Icon).icon ==
                        Icons.star_border),
            description:
                "List of icons with three full stars and two empty stars"),
        findsOneWidget);

    //Test three and half stars rendering
    await tester
        .pumpWidget(buildTestableWidget(RatingStars(rate: threeAndHalfStars)));
    expect(
        find.byWidgetPredicate(
            (widget) =>
                widget is Row &&
                widget.children is List<Widget> &&
                ((widget.children.elementAt(0) as Icon).icon == Icons.star &&
                    (widget.children.elementAt(1) as Icon).icon == Icons.star &&
                    (widget.children.elementAt(2) as Icon).icon == Icons.star &&
                    (widget.children.elementAt(3) as Icon).icon ==
                        Icons.star_half_outlined &&
                    (widget.children.elementAt(4) as Icon).icon ==
                        Icons.star_border),
            description:
                "List of icons with three full stars, one half start and one empty stars"),
        findsOneWidget);
  });
}

Widget buildTestableWidget(Widget widget) {
  return MaterialApp(home: widget);
}
