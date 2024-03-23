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

class PushNotificationApp extends StatefulWidget {
  const PushNotificationApp({super.key});

  @override
  State<PushNotificationApp> createState() => _PushNotificationAppState();
}

class _PushNotificationAppState extends State<PushNotificationApp> {
  @override
  void initState() {
    // Suscribirse o escuchar la emisión de eventos que se transmiten en el controlador de flujo messageStream al momento que se inicialice mi aplicación
    // ! La regla de las suscripciones establece que debe existir una cancelación cuando la aplicación termine, sin embargo, las notificaciones push deberían seguir llegando aunque la aplicación este terminada. Por ello no se cancela la suscripción al momento de destruir el app
    PushNotificationService.messageStream.listen((message) {
      // Dependiendo el código aquí declarado, nos permitirá reaccionar de forma diferente cuando se recibe una notificación
      print('PushNotificationApp: $message');
    });

    super.initState();
  }

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
