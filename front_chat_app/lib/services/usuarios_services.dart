import 'package:front_chat_app/global/environment.dart';
import 'package:front_chat_app/services/auth_services.dart';
import 'package:http/http.dart' as http;
import 'package:front_chat_app/models/usuarios_response.dart';

import '../models/usuarios.dart';

class UsuariosService {
  Future<List<Usuario>> getUsuarios() async {
    try {
      final resp = await http.get(Uri.parse('${Environment.apiUrl}/usuarios'),
          headers: {
            'Content-Type': 'application/json',
            'x-token': await AuthService.getToken()
          });

      final usuariosResponse = usuariosResponseFromJson(resp.body);
      return usuariosResponse.usuarios;
    } catch (e) {
      return [];
    }
  }
}
