import 'dart:convert';

Producto productoFromJson(String str) => Producto.fromJson(json.decode(str));

String productoToJson(Producto data) => json.encode(data.toJson());

class Producto {
  int? idProducto;
  String? coProducto;
  String? coSku;
  String? nbProducto;
  String? txDescripcion;
  String? txImagen;
  String? stProducto;
  int? nuOrden;
  int? idCategoria;
  int? idEmpresa;
  bool? inFinancia;

  Producto({
    this.idProducto,
    this.coProducto,
    this.coSku,
    this.nbProducto,
    this.txDescripcion,
    this.txImagen,
    this.stProducto,
    this.nuOrden,
    this.idCategoria,
    this.idEmpresa,
    this.inFinancia,
  });

  factory Producto.fromJson(Map<String, dynamic> json) => Producto(
        idProducto: json["id_producto"],
        coProducto: json["co_producto"],
        coSku: json["co_sku"],
        nbProducto: json["nb_producto"],
        txDescripcion: json["tx_descripcion"],
        txImagen: json["tx_imagen"],
        stProducto: json["st_producto"],
        nuOrden: json["nu_orden"],
        idCategoria: json["id_categoria"],
        idEmpresa: json["id_empresa"],
        inFinancia: json["in_financia"],
      );

  Map<String, dynamic> toJson() => {
        "id_producto": idProducto,
        "co_producto": coProducto,
        "co_sku": coSku,
        "nb_producto": nbProducto,
        "tx_descripcion": txDescripcion,
        "tx_imagen": txImagen,
        "st_producto": stProducto,
        "nu_orden": nuOrden,
        "id_categoria": idCategoria,
        "id_empresa": idEmpresa,
        "in_financia": inFinancia,
      };
}
