import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Recuperar los argumentos enviados a la ruta asociada con esta pantalla
    // Los argumentos siempre serán un Object, por tanto, los parseamos a un String (en caso de que se pueda)
    final String message =
        ModalRoute.of(context)!.settings.arguments as String? ??
            'Sin contenido';
    return Scaffold(
        appBar: AppBar(title: const Text('Message Screen')),
        body: Center(child: Text(message)));
  }
}
