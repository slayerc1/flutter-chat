// To parse this JSON data, do
//
//     final usuariosResponse = usuariosResponseFromJson(jsonString);

import 'dart:convert';

import 'package:chat/models/models.dart';

class UsuariosResponse {
    UsuariosResponse({
        required this.ok,
        required this.usuarios,
    });

    bool ok;
    List<Usuario> usuarios;

    factory UsuariosResponse.fromRawJson(String str) => UsuariosResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UsuariosResponse.fromJson(Map<String, dynamic> json) => UsuariosResponse(
        ok: json["ok"],
        usuarios: List<Usuario>.from(json["usuarios"].map((x) => Usuario.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuarios": List<dynamic>.from(usuarios.map((x) => x.toJson())),
    };
}


