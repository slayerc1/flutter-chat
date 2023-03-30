import 'package:flutter/material.dart';

class Labels extends StatelessWidget {

  final String ruta;
  final String pregunta;
  final String enlace;

  const Labels({super.key, required this.ruta, required this.pregunta, required this.enlace});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(pregunta, style: const TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300)),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, ruta);
          },
          child: Text(enlace, style: TextStyle(color: Colors.blue[600], fontSize: 18, fontWeight: FontWeight.bold))
        )
      ],
    );
  }
}