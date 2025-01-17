import 'package:flutter/material.dart';
import 'package:front_chat_app/pages/chat_page.dart';
import 'package:front_chat_app/pages/loading_page.dart';
import 'package:front_chat_app/pages/register_page.dart';
import 'package:front_chat_app/pages/usuario_page.dart';

import '../pages/login_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'usuarios': (_) => const UsuariosPage(),
  'chat': (_) => const ChatPage(),
  'login': (_) => const LoginPage(),
  'register': (_) => const RegisterPage(),
  'loading': (_) => const LoadingPage(),
};
