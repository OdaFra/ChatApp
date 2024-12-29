import 'dart:convert';

import 'package:front_chat_app/models/usuarios.dart';

UsuariosResponse usuariosResponseFromJson(String str) =>
    UsuariosResponse.fromJson(json.decode(str));

String usuariosResponseToJson(UsuariosResponse data) =>
    json.encode(data.toJson());

class UsuariosResponse {
  UsuariosResponse({
    required this.ok,
    required this.usuarios,
  });

  bool ok;
  List<Usuario> usuarios;

  factory UsuariosResponse.fromJson(Map<String, dynamic> json) =>
      UsuariosResponse(
        ok: json["ok"],
        usuarios: List<Usuario>.from(
            json["usuarios"].map((x) => Usuario.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuarios": List<dynamic>.from(usuarios.map((x) => x.toJson())),
      };
}

// class Usuario {
//   Usuario({
//     this.online,
//     this.nombre,
//     this.email,
//     this.uid,
//   });

//   bool online;
//   String nombre;
//   String email;
//   String uid;

//   factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
//         online: json["online"],
//         nombre: json["nombre"],
//         email: json["email"],
//         uid: json["uid"],
//       );

//   Map<String, dynamic> toJson() => {
//         "online": online,
//         "nombre": nombre,
//         "email": email,
//         "uid": uid,
//       };

