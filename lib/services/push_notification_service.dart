import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push_notifications_flutter_app/firebase_options.dart';

class PushNotificationService {
  // Obtener la instancia de Firebase Cloud Messaging
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;

  // Controladores de notificación
  // ? Podemos reaccionar de forma diferente a los mensajes de notificación, según el estado actual de la aplicación en el dispositivo
  static Future _onBackgroundMessageHandler(RemoteMessage message) async {
    print(
        'En segundo plano - _onBackgroundMessageHandler ${message.messageId}');
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    print('En uso - _onMessageHandler ${message.messageId}');
  }

  static Future _onMessageOpenedAppHandler(RemoteMessage message) async {
    print(
        'Aplicación cerrada - _onMessageOpenedAppHandler ${message.messageId}');
  }

  static Future initializeApp() async {
    // inicializar la aplicaciòn de Firebase en la aplicación
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    // Obtener el token asignado al dispositivo (este token es único y se asigna cuando la aplicación se instala en el dispositivo físico)
    token = await messaging.getToken();
    print('Token: $token');

    // Registrar controladores de notificación
    // * La aplicación está abierta pero en segundo plano (minimizada)
    FirebaseMessaging.onBackgroundMessage(_onBackgroundMessageHandler);
    // * La aplicación esta abierta,a la vista y en uso
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    // * La aplicación esta cerrada o no se esta ejecutando, o el dispositivo se encuentra bloqueado
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedAppHandler);
  }
}
