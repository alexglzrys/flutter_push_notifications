import 'package:flutter/material.dart';
import 'package:push_notifications_flutter_app/screens/home_screen.dart';
import 'package:push_notifications_flutter_app/screens/message_screen.dart';
import 'package:push_notifications_flutter_app/services/push_notification_service.dart';

void main() async {
  // Asegurarse de que Flutter haya inicializado completamente sus widgets ates de ejecutar cualquier otra parte de código en la aplicación
  WidgetsFlutterBinding.ensureInitialized();
  // Inicializar Firebase en la aplicación
  await PushNotificationService.initializeApp();
  // Inicializar la aplicación Flutter
  runApp(const PushNotificationApp());
}

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
