import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push_notifications_flutter_app/firebase_options.dart';

class PushNotificationService {
  // Obtener la instancia de Firebase Cloud Messaging
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;

  static Future initializeApp() async {
    // inicializar la aplicaciòn de Firebase en la aplicación
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    // Obtener el token asignado al dispositivo (este token es único y se asigna cuando la aplicación se instala en el dispositivo físico)
    token = await messaging.getToken();
    print('Token: $token');
  }
}
