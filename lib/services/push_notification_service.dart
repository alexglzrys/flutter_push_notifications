import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push_notifications_flutter_app/firebase_options.dart';

class PushNotificationService {
  // Obtener la instancia de Firebase Cloud Messaging
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  // Crear un contriolador de flujo que emite datos de tipo String
  // ? Quienes se suscriba a este flujo de información, puede recibir eventos (datos) de forma simultanea y reaccionar de forma diferente ante este suceso
  // Se establece la base para la creación de un flujo de eventos que puede transmitir datos de tipo String a múltiples partes de la aplicación, permitiendo así la comunicación asíncrona entre componentes
  static StreamController<String> _messageStream = StreamController.broadcast();

  // Getters
  // Definir un getter estático para tener acceso al flujo de datos que gestiona el controlador de flujo
  static Stream<String> get messageStream => _messageStream.stream;

  // Controladores de notificación
  // ? Podemos reaccionar de forma diferente a los mensajes de notificación, según el estado actual de la aplicación en el dispositivo
  static Future _onBackgroundMessageHandler(RemoteMessage message) async {
    print(
        'En segundo plano - _onBackgroundMessageHandler ${message.messageId}');
    // Cada notificación puede contener una sería de datos adicionales mejor conocido como carga útil
    print(message.data);
    // Enviar un nuevo evento al controlador de flujo, agregando el texto que viene adjunto en la notificación de Firebase Cloud Messaging
    // ? Cualquier parte del código que este escuchando a messageStream, recibirá el mensaje cuando sea enviado. Esta es una forma de enviar datos a través de un flujo de eventos asíncrono en Flutter
    _messageStream
        .add(message.notification!.body ?? 'Sin texto en la notificación');
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    print('En uso - _onMessageHandler ${message.messageId}');
    print(message.data);
    _messageStream
        .add(message.notification!.body ?? 'Sin texto en la notificación');
  }

  static Future _onMessageOpenedAppHandler(RemoteMessage message) async {
    print(
        'Aplicación cerrada - _onMessageOpenedAppHandler ${message.messageId}');
    print(message.data);
    _messageStream
        .add(message.notification!.body ?? 'Sin texto en la notificación');
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
