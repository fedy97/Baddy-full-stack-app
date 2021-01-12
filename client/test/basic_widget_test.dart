import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:polimi_app/components/custom_button_role.dart';
import 'package:polimi_app/components/custom_surfix_icon.dart';
import 'package:polimi_app/components/default_button.dart';
import 'package:polimi_app/components/form_error.dart';
import 'package:polimi_app/components/no_account_text.dart';
import 'package:polimi_app/components/rating_stars.dart';
import 'package:polimi_app/components/search_box.dart';
import 'package:polimi_app/components/socal_card.dart';
import 'package:polimi_app/constants.dart';
import 'package:polimi_app/models/user/standardUser.dart';
import 'package:polimi_app/screens/complete_profile/components/complete_profile_form.dart';
import 'package:polimi_app/screens/home_page/components/user_card.dart';

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

  testWidgets('Search box test', (WidgetTester tester) async {
    //Matching parameters
    final String defaultHintText = 'Cerca per citta\'';

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

  testWidgets('Form error widget test', (WidgetTester tester) async {
    //Matching parameters
    final List<String> errors = ['error1', 'error2'];

    await tester.pumpWidget(buildTestableWidget(FormError(errors: errors)));

    expect(
        find.byType(Text),
        findsNWidgets(
            errors.length)); //find a text widget for each error message
    expect(
        find.byType(SvgPicture),
        findsNWidgets(
            errors.length)); //find an error icon widget for each error message

    for (final e in errors)
      expect(
          find.text(e), findsOneWidget); //find a text occurrence for each error
  });

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

  testWidgets('Complete profile form widget test', (WidgetTester tester) async {
    final fieldsNumber = 4;
    final buttonLabel = "Register";
    await tester
        .pumpWidget(buildTestableWidgetWithScaffold(CompleteProfileForm()));

    expect(
        find.byWidgetPredicate((widget) => widget is TextFormField,
            description: "Text form field"),
        findsNWidgets(
            fieldsNumber)); //expecting 4 form fields to enter first name, last name, phone number and city

    expect(
        find.byWidgetPredicate((widget) => widget is FormError,
            description: "Customizable form error widget"),
        findsOneWidget);

    expect(
        find.byWidgetPredicate(
            (widget) => widget is DefaultButton && widget.text == buttonLabel,
            description: "Default button with text Register"),
        findsOneWidget);
  });

  testWidgets('Complete profile form widget test', (WidgetTester tester) async {
    final fieldsNumber = 4;
    final buttonLabel = "Register";
    await tester
        .pumpWidget(buildTestableWidgetWithScaffold(CompleteProfileForm()));

    expect(
        find.byWidgetPredicate((widget) => widget is TextFormField,
            description: "Text form field"),
        findsNWidgets(
            fieldsNumber)); //expecting 4 form fields to enter first name, last name, phone number and city

    expect(
        find.byWidgetPredicate((widget) => widget is FormError,
            description: "Customizable form error widget"),
        findsOneWidget);

    expect(
        find.byWidgetPredicate(
            (widget) => widget is DefaultButton && widget.text == buttonLabel,
            description: "Default button with text Register"),
        findsOneWidget);
  });

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
                widget.data == "Nome: ${testUser.firstName.toUpperCase()}",
            description: "Text with user's name"), //should not cut the name
        findsOneWidget);

    expect(
        find.byWidgetPredicate(
            (widget) =>
                widget is Text &&
                widget.data == "Citta: ${testUser.city.toUpperCase()}",
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
                widget.data == "Nome: ${expectedDisplayedName.toUpperCase()}",
            description: "Text with user's name"), //should cut the name
        findsOneWidget);
  });
}

Widget buildTestableWidget(Widget widget) {
  return MaterialApp(home: widget);
}

Widget buildTestableWidgetWithScaffold(Widget widget) {
  return MaterialApp(home: Scaffold(body: widget));
}
