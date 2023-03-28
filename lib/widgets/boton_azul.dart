import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {

  final void Function() onPressed;
  final String text;
  
  const BotonAzul({
    super.key, required this.onPressed, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: raisedButtonStyle,
      onPressed: onPressed, 
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 17)),
        ),
      )
    );
  }

    get raisedButtonStyle => ElevatedButton.styleFrom(
    elevation: 2,
    backgroundColor: Colors.blue,
    shape: const StadiumBorder()
  );
}