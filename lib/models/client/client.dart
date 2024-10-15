import 'dart:convert';

Client clientFromJson(String str) => Client.fromJson(json.decode(str));

String clientToJson(Client data) => json.encode(data.toJson());

class Client {
  int? id;
  String name;
  final String username;
  final String email;
  final String avatar;
  final bool? active;
  final dynamic descripcion;
  final TxAtributo? txAtributo;
  final DateTime? createdAt;
  bool stVerificado;
  final String? feUltimoAcceso;

  Client({
    this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.avatar,
    required this.active,
    this.descripcion,
    this.txAtributo,
    this.createdAt,
    required this.stVerificado,
    this.feUltimoAcceso,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
      id: json["id"],
      name: json["name"],
      username: json["username"],
      email: json["email"],
      avatar: json["avatar"],
      active: json["active"],
      descripcion: json["descripcion"],
      txAtributo: [null, ''].contains(json["tx_atributo"])
          ? null
          : TxAtributo.fromJson(json["tx_atributo"]),
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      stVerificado: json["st_verificado"] == 'VERIFICADO',
      feUltimoAcceso: json['fe_ultimo_acceso']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "avatar": avatar,
        "active": active,
        "descripcion": descripcion,
        "tx_atributo": txAtributo?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "st_verificado": stVerificado,
        'fe_ultimo_acceso': feUltimoAcceso,
      };
}

class TxAtributo {
  String? redirectTo,
      txNombre,
      txApellido,
      email,
      txTelefono,
      feNacimiento,
      coIdentificacion,
      schemeId,
      txGenero,
      txPais,
      txEstado,
      txMunicipio,
      txParroquia,
      txCalle,
      txDireccion;
  bool? boPep;
  final dynamic idCliente;
  int? idEmpresa, idSucursal;

  TxAtributo({
    this.redirectTo,
    this.txNombre,
    this.txApellido,
    this.email,
    this.txTelefono,
    this.feNacimiento,
    this.idCliente,
    this.coIdentificacion,
    this.schemeId,
    this.txGenero,
    this.txPais,
    this.txEstado,
    this.txMunicipio,
    this.txParroquia,
    this.txCalle,
    this.txDireccion,
    this.boPep,
    this.idSucursal,
    this.idEmpresa,
  });

  factory TxAtributo.fromJson(Map<String, dynamic> json) => TxAtributo(
        redirectTo: json["redirect_to"],
        txNombre: json["tx_nombre"],
        txApellido: json["tx_apellido"],
        email: json["email"],
        txTelefono: json["tx_telefono"],
        feNacimiento: json["fe_nacimiento"],
        idCliente: json["id_cliente"],
        coIdentificacion: json["co_identificacion"],
        schemeId: json["scheme_id"],
        boPep: json["bo_pep"],
        txGenero: json["tx_genero"],
        txPais: json["tx_pais"],
        txEstado: json["tx_estado"],
        txMunicipio: json["tx_municipio"],
        txParroquia: json["tx_parroquia"],
        txCalle: json["tx_calle"],
        txDireccion: json["tx_direccion"],
        idEmpresa: json["id_empresa"],
        idSucursal: json["id_sucursal"],
      );

  Map<String, dynamic> toJson() => {
        "redirect_to": redirectTo,
        "tx_nombre": txNombre,
        "tx_apellido": txApellido,
        "email": email,
        "tx_telefono": txTelefono,
        "fe_nacimiento": feNacimiento,
        "id_cliente": idCliente,
        "co_identificacion": coIdentificacion,
        "scheme_id": schemeId,
        "tx_genero": txGenero,
        "bo_pep": boPep,
        "tx_pais": txPais,
        "tx_estado": txEstado,
        "tx_municipio": txMunicipio,
        "tx_parroquia": txParroquia,
        "tx_calle": txCalle,
        "tx_direccion": txDireccion,
        "id_sucursal": idSucursal,
        "id_empresa": idEmpresa,
      };
}
