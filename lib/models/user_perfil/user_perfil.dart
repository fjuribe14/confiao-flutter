import 'dart:convert';

import 'package:confiao/models/index.dart';

UserPerfil userPerfilFromJson(String str) =>
    UserPerfil.fromJson(json.decode(str));

String userPerfilToJson(UserPerfil data) => json.encode(data.toJson());

class UserPerfil {
  String? name;
  String? username;
  String? email;
  String? avatar;
  bool? active;
  TxAtributo? txAtributo;
  DateTime? createdAt;
  String? stVerificado;
  DateTime? feUltimoAcceso;
  String? id;
  String? keepSessionAlive;
  List<int>? roles;

  UserPerfil({
    this.name,
    this.username,
    this.email,
    this.avatar,
    this.active,
    this.txAtributo,
    this.createdAt,
    this.stVerificado,
    this.feUltimoAcceso,
    this.id,
    this.keepSessionAlive,
    this.roles,
  });

  factory UserPerfil.fromJson(Map<String, dynamic> json) => UserPerfil(
        name: json["name"],
        username: json["username"],
        email: json["email"],
        avatar: json["avatar"],
        active: json["active"],
        txAtributo: json["tx_atributo"] == null
            ? null
            : TxAtributo.fromJson(json["tx_atributo"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        stVerificado: json["st_verificado"],
        feUltimoAcceso: json["fe_ultimo_acceso"] == null
            ? null
            : DateTime.parse(json["fe_ultimo_acceso"]),
        id: json["id"],
        keepSessionAlive: json["keep_session_alive"],
        roles: json["roles"] == null
            ? []
            : List<int>.from(json["roles"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "username": username,
        "email": email,
        "avatar": avatar,
        "active": active,
        "tx_atributo": txAtributo?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "st_verificado": stVerificado,
        "fe_ultimo_acceso": feUltimoAcceso?.toIso8601String(),
        "id": id,
        "keep_session_alive": keepSessionAlive,
        "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x)),
      };
}
