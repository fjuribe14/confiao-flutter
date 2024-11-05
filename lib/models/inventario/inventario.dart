import 'dart:convert';

import 'package:confiao/models/index.dart';

Inventario inventarioFromJson(String str) =>
    Inventario.fromJson(json.decode(str));

String inventarioToJson(Inventario data) => json.encode(data.toJson());

class Inventario {
  int? idInventario;
  int? idSucursal;
  int? idProducto;
  int? nuCantidad;
  String? moMonto;
  int? idEmpresa;
  Sucursal? sucursal;
  Producto? producto;
  int caSelected;
  double moMontoSelected;

  Inventario({
    this.idInventario,
    this.idSucursal,
    this.idProducto,
    this.nuCantidad,
    this.moMonto,
    this.idEmpresa,
    this.sucursal,
    this.producto,
    this.caSelected = 0,
    this.moMontoSelected = 0.0,
  });

  factory Inventario.fromJson(Map<String, dynamic> json) => Inventario(
        idInventario: json["id_inventario"],
        idSucursal: json["id_sucursal"],
        idProducto: json["id_producto"],
        nuCantidad: json["nu_cantidad"],
        moMonto: json["mo_monto"],
        idEmpresa: json["id_empresa"],
        sucursal: json["sucursal"] == null
            ? null
            : Sucursal.fromJson(json["sucursal"]),
        producto: json["producto"] == null
            ? null
            : Producto.fromJson(json["producto"]),
        caSelected: 0,
        moMontoSelected: double.parse(json["mo_monto"] ?? '0.0'),
      );

  Map<String, dynamic> toJson() => {
        "id_inventario": idInventario,
        "id_sucursal": idSucursal,
        "id_producto": idProducto,
        "nu_cantidad": nuCantidad,
        "mo_monto": moMonto,
        "id_empresa": idEmpresa,
        "sucursal": sucursal?.toJson(),
        "producto": producto?.toJson(),
        "ca_selected": caSelected,
        "mo_monto_selected": moMontoSelected,
      };
}
