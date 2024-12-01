import 'dart:convert';

import 'package:confiao/models/index.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String? name;
  String? username;
  String? email;
  String? avatar;
  bool? active;
  String? descripcion;
  TxAtributo? txAtributo;
  dynamic createdAt;
  String? stVerificado;

  User({
    this.name,
    this.username,
    this.email,
    this.avatar,
    this.active,
    this.descripcion,
    this.txAtributo,
    this.createdAt,
    this.stVerificado,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        username: json["username"],
        email: json["email"],
        avatar: json["avatar"],
        active: json["active"],
        descripcion: json["descripcion"],
        txAtributo: json["tx_atributo"] == null
            ? null
            : TxAtributo.fromJson(json["tx_atributo"]),
        createdAt: json["created_at"],
        stVerificado: json["st_verificado"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "username": username,
        "email": email,
        "avatar": avatar,
        "active": active,
        "descripcion": descripcion,
        "tx_atributo": txAtributo?.toJson(),
        "created_at": createdAt,
        "st_verificado": stVerificado,
      };
}
