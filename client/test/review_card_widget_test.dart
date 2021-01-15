import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:polimi_app/components/rating_stars.dart';
import 'package:polimi_app/models/review.dart';
import 'package:polimi_app/models/user/standardUser.dart';
import 'package:polimi_app/screens/profile/components/review_card.dart';

void main() {
  testWidgets('Review card widget test', (WidgetTester tester) async {
    final index = 0;
    final reviewerUsername = "reviewerUsername";

    final reviewedUser = StandardUser(
        birth: new DateTime.now(),
        gender: "M",
        username: "testUser",
        firstName: "firstName",
        lastName: "lastName",
        phone: "phone",
        city: "city",
        role: "role",
        ratingsQuantity: 3,
        ratingsAverage: 3.0);

    await tester.pumpWidget(buildTestableWidgetWithScaffold(ReviewCard(
      itemIndex: index,
      review: Review(
          createdAt: DateTime.now(),
          userReviewed: reviewedUser,
          userReviewer: StandardUser(username: reviewerUsername),
          rating: 3.5),
    )));

    expect(
        find.byWidgetPredicate(
            (widget) =>
                widget is Text && widget.data == "Username: $reviewerUsername",
            description: "Text with reviewer username"),
        findsOneWidget);

    expect(
        find.byWidgetPredicate(
            (widget) =>
                widget is Row &&
                ((widget.children.elementAt(0) is Text) &&
                    (widget.children.elementAt(0) as Text).data == "Vote:" &&
                    (widget.children.elementAt(2) as IconTheme).child
                        is RatingStars),
            //Rating stars behavior already tested, just need to check if place correctly
            description: "Row with Vote: 'RatingStars'"),
        findsOneWidget);

    expect(
        find.byWidgetPredicate(
            (widget) =>
                widget is Row &&
                ((widget.children.elementAt(0) is Text) &&
                    (widget.children.elementAt(0) as Text).data == "Review:" &&
                    (widget.children.elementAt(2) is GestureDetector)),
            description: "Row with Vote: 'RatingStars'"),
        findsOneWidget);
  });
}

Widget buildTestableWidgetWithScaffold(Widget widget) {
  return MaterialApp(home: Scaffold(body: widget));
}
