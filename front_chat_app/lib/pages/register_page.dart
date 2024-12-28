import 'package:flutter/material.dart';

import 'package:chatapp/services/auth_services.dart';
import 'package:chatapp/helpers/mostrarAlerta.dart';
import 'package:chatapp/widgets/Btn_azul.dart';
import 'package:chatapp/widgets/Custom_input.dart';
import 'package:provider/provider.dart';

import '../services/socket_services.dart';
import '../widgets/Label.dart';
import '../widgets/Logo.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Logo(titulo: 'Registro'),
                  _Form(),
                  const Labels(
                    ruta: 'login',
                    titulo: '¿Ya tienes cuenta?',
                    subtitulo: 'Ingresa ahora!',
                  ),
                  const Text(
                    'Terminos y condiciones de uso',
                    style: TextStyle(fontWeight: FontWeight.w200),
                  ),
                  const SizedBox(height: 0),
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInputWidget(
            icon: Icons.perm_identity,
            placeholder: 'Nombre',
            keyboardType: TextInputType.text,
            textController: nameCtrl,
          ),
          CustomInputWidget(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInputWidget(
            icon: Icons.lock_clock_outlined,
            placeholder: 'Contraseña',
            isPassword: true,
            // keyboardType: TextInputType.emailAddress,
            textController: passCtrl,
          ),
          BotonAzul(
              texto: 'Crear cuenta',
              onpressed: authService.autenticando
                  ? null
                  : () async {
                      final registroOk = await authService.register(
                          nameCtrl.text.trim(),
                          emailCtrl.text.trim(),
                          passCtrl.text.trim());

                      if (registroOk == true) {
                        socketService.connect();
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacementNamed(context, 'usuarios');
                      } else {
                        // ignore: use_build_context_synchronously
                        mostraAlerta(
                            context, 'Registro incorrecto', registroOk);
                      }
                    })
        ],
      ),
    );
  }
}
