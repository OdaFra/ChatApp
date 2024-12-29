import 'package:flutter/material.dart';
import 'package:front_chat_app/models/mensajes_response.dart';
import 'package:http/http.dart' as http;
import '../global/environment.dart';
import '../models/usuarios.dart';
import 'auth_services.dart';

class ChatService with ChangeNotifier {
  late Usuario usuarioPara;

  Future<List<Mensaje>> getChat(String usuarioID) async {
    final resp = await http
        .get(Uri.parse('${Environment.apiUrl}/mensajes/$usuarioID'), headers: {
      'Content-Type': 'application/json',
      'x-token': await AuthService.getToken()
    });

    final mensajesResp = mensajeResponseFromJson(resp.body);

    return mensajesResp.mensajes;
  }
}
