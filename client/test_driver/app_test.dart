import 'dart:core';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

//import 'package:flutter_test/flutter_test.dart';
void main() {
  group("Baddy self-driven tests", () {
    final continue_splash = find.byValueKey("continue_splash");

    FlutterDriver driver;
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test("test continue botton splash screen", () async {
      await driver.runUnsynchronized(() async {
        await driver.tap(continue_splash);
        await Future.delayed(Duration(seconds: 2));
      });
    });



  });
}
