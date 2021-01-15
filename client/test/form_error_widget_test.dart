import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:polimi_app/components/form_error.dart';

void main() {
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
}

Widget buildTestableWidget(Widget widget) {
  return MaterialApp(home: widget);
}
