import 'dart:convert';

SearchProducto searchProductoFromJson(String str) =>
    SearchProducto.fromJson(json.decode(str));

String searchProductoToJson(SearchProducto data) => json.encode(data.toJson());

class SearchProducto {
  int? idProducto;
  String? nbProducto;
  String? coProducto;
  String? txDescripcion;
  String? txImagen;
  int? idCategoria;
  String? nbCategoria;
  int? idEmpresa;
  String? nbEmpresa;
  int? nuCantidad;
  String? moMonto;
  int? idSucursal;
  String? nbSucursal;
  bool? selected = false;

  SearchProducto({
    this.idProducto,
    this.nbProducto,
    this.coProducto,
    this.txDescripcion,
    this.txImagen,
    this.idCategoria,
    this.nbCategoria,
    this.idEmpresa,
    this.nbEmpresa,
    this.nuCantidad,
    this.moMonto,
    this.idSucursal,
    this.nbSucursal,
    this.selected,
  });

  factory SearchProducto.fromJson(Map<String, dynamic> json) => SearchProducto(
        idProducto: json["id_producto"],
        nbProducto: json["nb_producto"],
        coProducto: json["co_producto"],
        txDescripcion: json["tx_descripcion"],
        txImagen: json["tx_imagen"],
        idCategoria: json["id_categoria"],
        nbCategoria: json["nb_categoria"],
        idEmpresa: json["id_empresa"],
        nbEmpresa: json["nb_empresa"],
        nuCantidad: json["nu_cantidad"],
        moMonto: json["mo_monto"],
        idSucursal: json["id_sucursal"],
        nbSucursal: json["nb_sucursal"],
        selected: false,
      );

  Map<String, dynamic> toJson() => {
        "id_producto": idProducto,
        "nb_producto": nbProducto,
        "co_producto": coProducto,
        "tx_descripcion": txDescripcion,
        "tx_imagen": txImagen,
        "id_categoria": idCategoria,
        "nb_categoria": nbCategoria,
        "id_empresa": idEmpresa,
        "nb_empresa": nbEmpresa,
        "nu_cantidad": nuCantidad,
        "mo_monto": moMonto,
        "id_sucursal": idSucursal,
        "nb_sucursal": nbSucursal,
      };
}
