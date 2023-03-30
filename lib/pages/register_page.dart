import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat/widgets/widgets.dart';
import 'package:chat/services/services.dart';
import 'package:chat/helpers/helpers.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
                  Logo(titulo: 'Registro'),
                  _Form(),
                  Labels(ruta: 'login', pregunta: '¿Ya tienes cuenta?', enlace: 'Ingresa ahora!'),
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
  final nombreCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.perm_identity,
            placeholder: 'Nombre',
            textController: nombreCtrl,
          ),
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
              text: 'Crear cuenta',
              onPressed: authService.autenticando 
                ? null
                : () async {
                  FocusScope.of(context).unfocus();
                  final registerOk = await authService.register(nombreCtrl.text.trim(), emailCtrl.text.trim(), passCtrl.text.trim());

                  if (registerOk == true) {
                    socketService.connect();
                    if (context.mounted) Navigator.pushReplacementNamed(context, 'usuarios');
                  } else {
                    if (context.mounted) mostrarAlerta(context, 'Registro incorrecto', registerOk);
                  }
                }
          )
        ],
      ),
    );
  }
}
