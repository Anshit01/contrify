import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingHandler {
  static void initalize() async {
    await FirebaseMessaging.instance.subscribeToTopic('general');

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    // await Firebase.initializeApp();

    print("Handling a background message: ${message.messageId}");
  }
}
