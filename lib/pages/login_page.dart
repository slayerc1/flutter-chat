import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat/services/services.dart';
import 'package:chat/helpers/helpers.dart';
import 'package:chat/widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Logo(titulo: 'Messenger'),
                  _Form(),
                  Labels(
                      ruta: 'register',
                      pregunta: '¿No tienes cuenta?',
                      enlace: 'Crea una ahora!'),
                  Text('Términos y condiciones de uso',
                      style: TextStyle(fontWeight: FontWeight.w200))
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  const _Form();

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            textController: passCtrl,
            isPassword: true,
          ),
          BotonAzul(
              text: 'Ingrese',
              onPressed: authService.autenticando 
                ? null
                : () async {
                  FocusScope.of(context).unfocus();
                  final loginOk = await authService.login(emailCtrl.text.trim(), passCtrl.text.trim());

                  if (loginOk) {
                    // TODO: Conectar a nuestro socket server
                    if (context.mounted) Navigator.pushReplacementNamed(context, 'usuarios');
                  } else {
                    if (context.mounted) mostrarAlerta(context, 'Login incorrecto', 'Revise sus credenciales nuevamente');
                  }
                }
          )
        ],
      ),
    );
  }
}
