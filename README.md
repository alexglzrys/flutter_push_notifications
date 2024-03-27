- https://firebase.google.com/docs/flutter/setup?platform=ios&hl=es
- https://firebase.google.com/docs/cloud-messaging/flutter/client?hl=es
- https://firebase.flutter.dev/docs/messaging/overview

## Agregar Firebase a un proyecto de Flutter

- Iniciar sessión en la consola de Firebase
- Seleccionar o crear un nuevo proyecto
- Instalar Firebase CLI de forma global en el sistema
```
npm install -g firebase-tools
```
- Iniciar sessión en Firebase con la cuenta de Google asociada al proyecto
```
firebase login
```
- Instalar FluterFire CLI de forma global en el sistema
```
dart pub global activate flutterfire_cli
```
- Ir al directorio principal del proyecto Flutter y ejecutar el siguiente comando, colocando el ID del proyecto asociado a la aplicación
```
flutterfire configure --project=ID_DEL_PROYECTO
```
- Instalar el plugin de Firebase Core en Flutter
```
flutter pub add firebase_core
```
- Por cada librería de Firebase instalada en el proyecto, es necesario ejecutar la respectiva configuración para que FlutterFire agregue automáticamente los complementos de Gradle necesarios a la aplicación. 
```
flutterfire configure
```
- Instalar el resto de librerías para conectarse a los diferentes módulos o servicios de Firebase (Autenticación, Base de Datos, Push Notifications)
```
flutter pub add PLUGIN_NAME
flutterfire configure
```
- Abrir el proyecto Flutter para inicializar Firebase y agregar sus respectivos complementos **Generalmente esto se hace a nivel del archivo main.dart**
```
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// ...

await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
```


## Enviar Mensajes mediante un cliente REST

- Ir a https://developers.google.com/oauthplayground
- Seleccionar Firebase Cloud Messaging API v1
- Dar permisos a la cuenta de Google
- Intercambiar codigo de autorización para generar el token
- Usar el Access Token para enviarlo en la petición POST como un *Authorization Bearer Token*
- Apuntar al siguiente endpoint: POST - **https://fcm.googleapis.com/v1/projects/ID_DEL_PROYECTO_FIREBASE/messages:send**
- Implementar el cuerpo de la notificación, la data adjunta, así como los tokens únicos de cada dispositivo a los que se dirigirá el mensaje
```
{
    "message": {
        "token":"dYkAmLbkSS-gPHynV3j8D9:APA91bF3JYnnaLZJV74lm7KwTFpZ5mD8M7K7ZUZ_xtIlsRWQ_IxQ2o-lvAuR9o-DUiM1Iq8D5kxBp5bRD73PAr-dfQF16Pg0buFuFyBrCaxPNk0whbOxA_vseO7C0Iwn3Y6LVKr3tSR3",
        "notification": {
            "title": "Postman V3",
            "body": "Tienes un mensaje enviado desde un cliente REST Postman"
        },
        "data": {
            "prouduct": "Limón con mandarina",
            "id": "451511"
        }
    }
}
```
