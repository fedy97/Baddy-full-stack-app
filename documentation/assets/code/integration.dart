import 'dart:core';
import 'dart:math';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';


///to run self driven tests, first open your emulator or connect device,
///then open terminal, navigate to ~/dima/client directory and run:
///-->" flutter drive --target=test_driver/app.dart "<--

void main() {
  group("Baddy self-driven tests", () {
    String user;
    const chars = "abcdefghijklmnopqrstuvwxyz0123456789";
    final continue_splash = find.byValueKey("continue_splash");
    final login_button = find.byValueKey("login_button");
    final name_login = find.byValueKey("name_login");
    final password_login = find.byValueKey("password_login");
    final goto_signup = find.byValueKey("goto_signup");
    final customer_role_button = find.byValueKey("customer_role_button");
    final signup_button = find.byValueKey("signup_button");
    final name_textfield = find.byValueKey("name_textfield");
    final email_textfield = find.byValueKey("email_textfield");
    final password_textfield = find.byValueKey("password_textfield");
    final confirm_psw_textfield = find.byValueKey("confirm_psw_textfield");
    final success_button = find.byValueKey("success_button");
    final homepage = find.byValueKey("homepage");
    final search_box = find.byValueKey("search_box");
    ...

    FlutterDriver driver;
      setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    ...

    test("test continue button splash screen", () async {
      await driver.runUnsynchronized(() async {
        await driver.tap(continue_splash);
        await Future.delayed(Duration(seconds: 2));
      });
    });

    ...

    test("find caregiver by city", () async {
      await driver.runUnsynchronized(() async {
        await driver.waitFor(homepage);
        await Future.delayed(Duration(seconds: 1));
        await driver.tap(search_box);
        await Future.delayed(Duration(seconds: 1));
        await driver.enterText("milano");
        await Future.delayed(Duration(seconds: 1));
        await driver.tap(user_card);
        await Future.delayed(Duration(seconds: 1));
      });
    });

    ...
  });
}
