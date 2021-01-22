import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:polimi_app/models/model.dart';
import 'package:provider/provider.dart';

import 'auth_manager.dart';
import 'routes.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.notification.body}');

    showOverlayNotification((context) {
      return Card(
        color: Colors.deepPurple,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: SafeArea(
          child: ListTile(
            title: Text(message.notification.title,
                style: TextStyle(
                  color: Colors.white,
                )),
            subtitle: Text(message.notification.body,
                style: TextStyle(
                  color: Colors.white,
                )),
            trailing: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  OverlaySupportEntry.of(context).dismiss();
                }),
          ),
        ),
      );
    }, duration: Duration(milliseconds: 4000));
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
        child: ChangeNotifierProvider(
            create: (_) => Model(),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Baddy',
              theme: theme(),
              // home: SplashScreen(),
              // We use routeName so that we dont need to remember the name
              initialRoute: AuthManager.routeName,
              routes: routes,
            )));
  }
}
