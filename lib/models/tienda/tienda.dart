// To parse this JSON data, do
//
//     final tienda = tiendaFromJson(jsonString);

import 'dart:convert';

Tienda tiendaFromJson(String str) => Tienda.fromJson(json.decode(str));

String tiendaToJson(Tienda data) => json.encode(data.toJson());

class Tienda {
  int? idEmpresa;
  String? nbEmpresa;
  String? txDireccion;
  String? txDescripcion;
  bool? boFinanciamiento;
  String? txImagen;

  Tienda({
    this.idEmpresa,
    this.nbEmpresa,
    this.txDireccion,
    this.txDescripcion,
    this.boFinanciamiento,
    this.txImagen,
  });

  factory Tienda.fromJson(Map<String, dynamic> json) => Tienda(
        idEmpresa: json["id_empresa"],
        nbEmpresa: json["nb_empresa"],
        txDireccion: json["tx_direccion"],
        txDescripcion: json["tx_descripcion"],
        boFinanciamiento: json["bo_financiamiento"],
        txImagen: json["tx_imagen"],
      );

  Map<String, dynamic> toJson() => {
        "id_empresa": idEmpresa,
        "nb_empresa": nbEmpresa,
        "tx_direccion": txDireccion,
        "tx_descripcion": txDescripcion,
        "bo_financiamiento": boFinanciamiento,
        "tx_imagen": txImagen,
      };
}
