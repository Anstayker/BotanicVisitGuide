import 'package:botanic_visit_guide/tmp/home_page.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(flex: 2, child: imagenDeBienvenida()),
        const SizedBox(height: 24),
        Flexible(
            flex: 1, child: tituloDeBienvenida('Bienvenido al guia de visita')),
        Flexible(flex: 1, child: tituloDeBienvenida('del Jardín Botánico')),
        const SizedBox(height: 24),
        textoDeBienvenida(),
        const SizedBox(height: 24),
        Flexible(flex: 1, child: botonDeContinuar(context)),
      ],
    )));
  }
}

Widget imagenDeBienvenida() {
  return Icon(Icons.forest, size: 250, color: Colors.green[600]);
}

Widget tituloDeBienvenida(String text) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 26,
    ),
  );
}

Widget textoDeBienvenida() {
  return const Text('Pulsa el botón para comenzar');
}

Widget botonDeContinuar(BuildContext context) {
  return SizedBox(
    width: 200,
    height: 40,
    child: ElevatedButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      },
      style:
          ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black)),
      child: const Text('Continuar'),
    ),
  );
}
