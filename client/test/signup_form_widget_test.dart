import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:polimi_app/components/default_button.dart';
import 'package:polimi_app/components/form_error.dart';
import 'package:polimi_app/screens/sign_in/sign_up/components/sign_up_form.dart';

void main() {
  testWidgets('Sign up form widget test', (WidgetTester tester) async {
    final fieldsNumber = 4;
    final fieldTitles = ["Username", "Mail", "Password", "Confirm Password"];
    final buttonLabel = "Continue";
    await tester.pumpWidget(buildTestableWidgetWithScaffold(SignUpForm()));

    expect(
        find.byWidgetPredicate((widget) => widget is TextFormField,
            description: "Text form field"),
        findsNWidgets(
            fieldsNumber)); //expecting 4 form fields to enter name, email, password and confirm password

    fieldTitles.forEach((el) {
      expect(find.text(el), findsOneWidget);
    });

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
}

Widget buildTestableWidgetWithScaffold(Widget widget) {
  return MaterialApp(home: Scaffold(body: widget));
}
