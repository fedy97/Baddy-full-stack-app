import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:polimi_app/components/default_button.dart';
import 'package:polimi_app/components/form_error.dart';
import 'package:polimi_app/screens/update_profile/update_profile_page.dart';

void main() {
  testWidgets('Update profile widget test', (WidgetTester tester) async {
    final fieldTitles = ["Nome", "Cognome", "Phone", "City", "Nationality"];
    final buttonLabel = "Aggiorna";
    await tester.pumpWidget(buildTestableWidget(UpdateProfile()));

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

Widget buildTestableWidget(Widget widget) {
  return MaterialApp(home: widget);
}
