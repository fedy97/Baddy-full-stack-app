import 'package:flutter/material.dart';

import 'auth_manager.dart';
import 'routes.dart';
import 'theme.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Baddy',
      theme: theme(),
      // home: SplashScreen(),
      // We use routeName so that we dont need to remember the name
      initialRoute: AuthManager.routeName,
      routes: routes,
    );
  }
}
