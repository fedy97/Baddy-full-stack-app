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
    final user_card = find.descendant(
      of: homepage,
      matching: find.byType("UserCard"),
      firstMatchOnly: true,
    );
    final star = find.byValueKey("star");
    final send_review = find.byValueKey("send_review");
    final write_review = find.byValueKey("write_review");
    final success_snack = find.byValueKey("success_snack");
    final back = find.byTooltip('Back');

    FlutterDriver driver;
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    String randomString(int strlen) {
      Random rnd = new Random(new DateTime.now().millisecondsSinceEpoch);
      String result = "";
      for (var i = 0; i < strlen; i++) {
        result += chars[rnd.nextInt(chars.length)];
      }
      return result;
    }

    test("test continue button splash screen", () async {
      await driver.runUnsynchronized(() async {
        await driver.tap(continue_splash);
        await Future.delayed(Duration(seconds: 2));
      });
    });

    // test("test login failure 1", () async {
    //   await driver.runUnsynchronized(() async {
    //     await driver.tap(login_button);
    //     await Future.delayed(Duration(seconds: 2));
    //   });
    // });

    //test("successful login as a user", () async {
    //  await driver.runUnsynchronized(() async {
    //    await driver.tap(name_login);
    //    await Future.delayed(Duration(seconds: 1));
    //    await driver.enterText("test22");
    //    await Future.delayed(Duration(seconds: 1));
    //    await driver.tap(password_login);
    //    await Future.delayed(Duration(seconds: 1));
    //    await driver.enterText("ffffff");
    //    await Future.delayed(Duration(seconds: 1));
    //    await driver.tap(login_button);
    //    await Future.delayed(Duration(seconds: 1));
    //  });
    //});

    test("test sign up", () async {
      await driver.runUnsynchronized(() async {
        user = randomString(6);
        await driver.tap(goto_signup);
        await Future.delayed(Duration(seconds: 1));
        await driver.tap(customer_role_button);
        await Future.delayed(Duration(seconds: 1));
        await driver.tap(signup_button);
        await Future.delayed(Duration(seconds: 1));
        await driver.tap(name_textfield);
        await Future.delayed(Duration(seconds: 1));
        await driver.enterText(user);
        await Future.delayed(Duration(seconds: 1));
        await driver.tap(email_textfield);
        await Future.delayed(Duration(seconds: 1));
        await driver.enterText("0" + randomString(10) + "@testmail.com");
        await Future.delayed(Duration(seconds: 1));
        await driver.tap(password_textfield);
        await Future.delayed(Duration(seconds: 1));
        await driver.enterText("ffffff");
        await Future.delayed(Duration(seconds: 1));
        await driver.tap(confirm_psw_textfield);
        await Future.delayed(Duration(seconds: 1));
        await driver.enterText("ffffff");
        await Future.delayed(Duration(seconds: 1));
        await driver.tap(signup_button);
        await Future.delayed(Duration(seconds: 1));
        await driver.tap(success_button);
        await driver.waitFor(homepage);
        await Future.delayed(Duration(seconds: 1));
      });
    });

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

    test("write a review to a caregiver", () async {
      await driver.runUnsynchronized(() async {
        await driver.tap(star);
        await Future.delayed(Duration(seconds: 1));
        await driver.tap(write_review);
        await Future.delayed(Duration(seconds: 1));
        await driver.enterText("this is a automatic test review");
        await Future.delayed(Duration(seconds: 1));
        await driver.tap(send_review);
        await driver.waitFor(success_snack);
        await Future.delayed(Duration(seconds: 1));
      });
    });
  });
}
