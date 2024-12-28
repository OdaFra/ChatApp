import 'package:chatapp/services/socket_services.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/widgets/Btn_azul.dart';
import 'package:chatapp/widgets/Custom_input.dart';
import 'package:chatapp/helpers/mostrarAlerta.dart';
import 'package:provider/provider.dart';

import '../services/auth_services.dart';
import '../widgets/Label.dart';
import '../widgets/Logo.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

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
                  const Logo(titulo: 'Messenger'),
                  _Form(),
                  const Labels(
                    ruta: 'register',
                    titulo: '¿No tienes cuenta?',
                    subtitulo: 'Crea una ahora!',
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
              texto: 'Ingresar',
              onpressed: authService.autenticando
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      final loginOk = await authService.login(
                          emailCtrl.text.trim(), passCtrl.text.trim());
                      if (loginOk) {
                        socketService.connect();
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacementNamed(context, 'usuarios');
                      } else {
                        //Mostrar alerta
                        // ignore: use_build_context_synchronously
                        mostraAlerta(context, 'Login incorrecto',
                            'Revise sus credenciales nuevamente');
                      }
                    })
        ],
      ),
    );
  }
}
