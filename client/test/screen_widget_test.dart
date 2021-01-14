import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:polimi_app/components/custom_button_role.dart';
import 'package:polimi_app/constants.dart';
import 'package:polimi_app/screens/choose_role_page/choose_role_page.dart';
import 'package:polimi_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:polimi_app/screens/complete_profile/components/complete_profile_form.dart';
import 'package:polimi_app/screens/home_page/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Chose role page widget test', (WidgetTester tester) async {
    final appBarBgColor = Colors.white;

    final baddyButtonTextColor = Colors.white;
    final badanteButtonText = "Badante";
    final badanteImagePath = "doctor.png";

    final clientButtonTextColor = kSecondaryColor;
    final clientButtonText = "Cliente";
    final clientImagePath = "user.png";

    await tester.pumpWidget(buildTestableWidget(ChooseRolePage()));

    expect(
        find.byWidgetPredicate(
            (widget) =>
                widget is AppBar && widget.backgroundColor == appBarBgColor,
            description: "AppBar with white bgColor"),
        findsOneWidget);

    expect(
        find.byWidgetPredicate(
            (widget) =>
                widget is CustomButtonRole &&
                (widget.descr == badanteButtonText &&
                    widget.image == badanteImagePath &&
                    widget.textColor == baddyButtonTextColor),
            description: "Baddy button with static text and bg image"),
        findsOneWidget);

    expect(
        find.byWidgetPredicate(
            (widget) =>
                widget is CustomButtonRole &&
                (widget.descr == clientButtonText &&
                    widget.image == clientImagePath &&
                    widget.textColor == clientButtonTextColor),
            description: "Client button with static text and bg image"),
        findsOneWidget);
  });

  testWidgets('Complete profile page widget test', (WidgetTester tester) async {
    final termsAndCondition =
        "By continuing your confirm that you agree \nwith our Term and Condition";
    await tester.pumpWidget(buildTestableWidget(CompleteProfileScreen()));

    expect(
        find.byWidgetPredicate(
            (widget) =>
                widget is AppBar &&
                (widget.title as Text).data == 'Complete Profile',
            description: "AppBar with static text"),
        findsOneWidget);

    expect(
        find.byWidgetPredicate((widget) => widget is CompleteProfileForm,
            description: "Custom form to edit user data"),
        findsOneWidget);

    expect(
        find.byWidgetPredicate(
            (widget) => widget is Text && widget.data == termsAndCondition,
            description: "Text widget with T&C"),
        //mandatory to show terms and conditions
        findsOneWidget);
  });

  testWidgets('Home page widget test', (WidgetTester tester) async {
    final pageTitle = "Benvenuto";
    final appBarBgColor = Colors.white;
    await tester.pumpWidget(buildTestableWidgetWithScaffold(HomePage()));

    expect(
        find.byWidgetPredicate(
            (widget) =>
                widget is AppBar &&
                (widget.backgroundColor == appBarBgColor &&
                    (widget.title as Text).data == pageTitle),
            description: "AppBar with white bgColor and static description"),
        findsOneWidget);
  });
}

Widget buildTestableWidget(Widget widget) {
  return MaterialApp(home: widget);
}

Widget buildTestableWidgetWithScaffold(Widget widget) {
  return ChangeNotifierProvider(
      child: MaterialApp(home: Scaffold(body: widget)));
}
