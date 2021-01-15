import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:polimi_app/components/default_button.dart';
import 'package:polimi_app/components/form_error.dart';
import 'package:polimi_app/screens/complete_profile/components/complete_profile_form.dart';

void main() {
  testWidgets('Complete profile form widget test', (WidgetTester tester) async {
    final fieldsNumber = 4;
    final fieldTitles = ["City", "Phone Number", "Last Name", "First Name"];
    final buttonLabel = "Register";
    await tester
        .pumpWidget(buildTestableWidgetWithScaffold(CompleteProfileForm()));

    expect(
        find.byWidgetPredicate((widget) => widget is TextFormField,
            description: "Text form field"),
        findsNWidgets(
            fieldsNumber)); //expecting 4 form fields to enter first name, last name, phone number and city

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
