import 'package:flutter/material.dart';
import 'package:push_notifications_flutter_app/screens/home_screen.dart';
import 'package:push_notifications_flutter_app/screens/message_screen.dart';

void main() => runApp(const PushNotificationApp());

class PushNotificationApp extends StatelessWidget {
  const PushNotificationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Push Notification App',
      initialRoute: 'home',
      routes: {
        'home': (_) => const HomeScreen(),
        'message': (_) => const MessageScreen()
      },
    );
  }
}
