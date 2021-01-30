...
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
...

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

...