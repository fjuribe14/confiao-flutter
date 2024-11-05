import 'dart:convert';

Sucursal sucursalFromJson(String str) => Sucursal.fromJson(json.decode(str));

String sucursalToJson(Sucursal data) => json.encode(data.toJson());

class Sucursal {
  int? idSucursal;
  String? coSucursal;
  String? nbSucursal;
  String? txDescripcion;
  String? txDireccionSucursal;
  String? txTelefonoSucursal;
  String? txCorreoSucursal;
  int? idEmpresa;

  Sucursal({
    this.idSucursal,
    this.coSucursal,
    this.nbSucursal,
    this.txDescripcion,
    this.txDireccionSucursal,
    this.txTelefonoSucursal,
    this.txCorreoSucursal,
    this.idEmpresa,
  });

  factory Sucursal.fromJson(Map<String, dynamic> json) => Sucursal(
        idSucursal: json["id_sucursal"],
        coSucursal: json["co_sucursal"],
        nbSucursal: json["nb_sucursal"],
        txDescripcion: json["tx_descripcion"],
        txDireccionSucursal: json["tx_direccion_sucursal"],
        txTelefonoSucursal: json["tx_telefono_sucursal"],
        txCorreoSucursal: json["tx_correo_sucursal"],
        idEmpresa: json["id_empresa"],
      );

  Map<String, dynamic> toJson() => {
        "id_sucursal": idSucursal,
        "co_sucursal": coSucursal,
        "nb_sucursal": nbSucursal,
        "tx_descripcion": txDescripcion,
        "tx_direccion_sucursal": txDireccionSucursal,
        "tx_telefono_sucursal": txTelefonoSucursal,
        "tx_correo_sucursal": txCorreoSucursal,
        "id_empresa": idEmpresa,
      };
}
