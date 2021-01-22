import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:polimi_app/components/rating_stars.dart';
import 'package:polimi_app/models/user/standardUser.dart';
import 'package:polimi_app/screens/home_page/components/user_card.dart';

void main() {
  testWidgets('User card widget test', (WidgetTester tester) async {
    final index = 0;
    final testUser = StandardUser(
        birth: new DateTime.now(),
        gender: "M",
        username: "testUser",
        firstName: "firstName",
        lastName: "lastName",
        phone: "phone",
        city: "city",
        role: "role",
        ratingsQuantity: 3,
        ratingsAverage: 3.0,
        photo: null,
        jwt: "jwt",
        available: true,
        nationality: "nationality");

    await tester.pumpWidget(buildTestableWidgetWithScaffold(
        UserCard(itemIndex: index, user: testUser)));

    expect(
        find.byWidgetPredicate(
            (widget) => widget is Hero && widget.tag == testUser.username,
            description: "Hero with username tag"),
        findsOneWidget);

    expect(
        find.byWidgetPredicate(
            (widget) =>
                widget is Text &&
                widget.data == "Name: ${testUser.firstName.toUpperCase()}",
            description: "Text with user's name"), //should not cut the name
        findsOneWidget);

    expect(
        find.byWidgetPredicate(
            (widget) =>
                widget is Text &&
                widget.data == "City: ${testUser.city.toUpperCase()}",
            description: "Text with user's city"), //should not cut the name
        findsOneWidget);

    expect(
        find.byWidgetPredicate((widget) => widget is RatingStars,
            description: "Rating starts widget"),
        findsOneWidget); //already test, just need to be present

    //test the case with a very long first name
    testUser.firstName = "veryLongFirstName";
    final expectedDisplayedName = "veryLongF";

    await tester.pumpWidget(buildTestableWidgetWithScaffold(
        UserCard(itemIndex: index, user: testUser)));

    expect(
        find.byWidgetPredicate(
            (widget) =>
                widget is Text &&
                widget.data == "Name: ${expectedDisplayedName.toUpperCase()}",
            description: "Text with user's name"), //should cut the name
        findsOneWidget);
  });
}

Widget buildTestableWidgetWithScaffold(Widget widget) {
  return MaterialApp(home: Scaffold(body: widget));
}
