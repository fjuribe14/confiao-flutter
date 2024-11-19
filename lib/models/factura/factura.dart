import 'dart:convert';

Factura facturaFromJson(String str) => Factura.fromJson(json.decode(str));

String facturaToJson(Factura data) => json.encode(data.toJson());

class Factura {
  int? idFactura;
  int? nuFactura;
  String? nuControl;
  int? idLoteControl;
  String? txReferenciaExterna;
  String? txIdCliente;
  String? nbCliente;
  String? txTelefonoCliente;
  String? txDireccionCliente;
  int? idCreado;
  int? idEmpresa;
  String? moTasaCambio;
  String? moSubTotal;
  String? moImpuesto;
  String? moTotal;
  String? coMoneda;
  String? stFactura;
  String? txAtributo;
  List<DetalleFactura>? detalles;

  Factura({
    this.idFactura,
    this.nuFactura,
    this.nuControl,
    this.idLoteControl,
    this.txReferenciaExterna,
    this.txIdCliente,
    this.nbCliente,
    this.txTelefonoCliente,
    this.txDireccionCliente,
    this.idCreado,
    this.idEmpresa,
    this.moTasaCambio,
    this.moSubTotal,
    this.moImpuesto,
    this.moTotal,
    this.coMoneda,
    this.stFactura,
    this.txAtributo,
    this.detalles,
  });

  factory Factura.fromJson(Map<String, dynamic> json) => Factura(
        idFactura: json["id_factura"],
        nuFactura: json["nu_factura"],
        nuControl: json["nu_control"],
        idLoteControl: json["id_lote_control"],
        txReferenciaExterna: json["tx_referencia_externa"],
        txIdCliente: json["tx_id_cliente"],
        nbCliente: json["nb_cliente"],
        txTelefonoCliente: json["tx_telefono_cliente"],
        txDireccionCliente: json["tx_direccion_cliente"],
        idCreado: json["id_creado"],
        idEmpresa: json["id_empresa"],
        moTasaCambio: json["mo_tasa_cambio"],
        moSubTotal: json["mo_sub_total"],
        moImpuesto: json["mo_impuesto"],
        moTotal: json["mo_total"],
        coMoneda: json["co_moneda"],
        stFactura: json["st_factura"],
        txAtributo: json["tx_atributo"],
        detalles: json["detalles"] == null
            ? []
            : List<DetalleFactura>.from(
                json["detalles"]!.map((x) => DetalleFactura.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id_factura": idFactura,
        "nu_factura": nuFactura,
        "nu_control": nuControl,
        "id_lote_control": idLoteControl,
        "tx_referencia_externa": txReferenciaExterna,
        "tx_id_cliente": txIdCliente,
        "nb_cliente": nbCliente,
        "tx_telefono_cliente": txTelefonoCliente,
        "tx_direccion_cliente": txDireccionCliente,
        "id_creado": idCreado,
        "id_empresa": idEmpresa,
        "mo_tasa_cambio": moTasaCambio,
        "mo_sub_total": moSubTotal,
        "mo_impuesto": moImpuesto,
        "mo_total": moTotal,
        "co_moneda": coMoneda,
        "st_factura": stFactura,
        "tx_atributo": txAtributo,
        "detalles": detalles == null
            ? []
            : List<dynamic>.from(detalles!.map((x) => x.toJson())),
      };
}

class DetalleFactura {
  int? idDetalleFactura;
  int? idProducto;
  String? nbProducto;
  String? txDescripcion;
  String? moIndividual;
  int? caProducto;
  String? moTasaCambio;
  String? moSubTotal;
  String? moImpuesto;
  String? moTotal;
  int? idFactura;
  int? idCreado;
  String? txAtributo;

  DetalleFactura({
    this.idDetalleFactura,
    this.idProducto,
    this.nbProducto,
    this.txDescripcion,
    this.moIndividual,
    this.caProducto,
    this.moTasaCambio,
    this.moSubTotal,
    this.moImpuesto,
    this.moTotal,
    this.idFactura,
    this.idCreado,
    this.txAtributo,
  });

  factory DetalleFactura.fromJson(Map<String, dynamic> json) => DetalleFactura(
        idDetalleFactura: json["id_detalle_factura"],
        idProducto: json["id_producto"],
        nbProducto: json["nb_producto"],
        txDescripcion: json["tx_descripcion"],
        moIndividual: json["mo_individual"],
        caProducto: json["ca_producto"],
        moTasaCambio: json["mo_tasa_cambio"],
        moSubTotal: json["mo_sub_total"],
        moImpuesto: json["mo_impuesto"],
        moTotal: json["mo_total"],
        idFactura: json["id_factura"],
        idCreado: json["id_creado"],
        txAtributo: json["tx_atributo"],
      );

  Map<String, dynamic> toJson() => {
        "id_detalle_factura": idDetalleFactura,
        "id_producto": idProducto,
        "nb_producto": nbProducto,
        "tx_descripcion": txDescripcion,
        "mo_individual": moIndividual,
        "ca_producto": caProducto,
        "mo_tasa_cambio": moTasaCambio,
        "mo_sub_total": moSubTotal,
        "mo_impuesto": moImpuesto,
        "mo_total": moTotal,
        "id_factura": idFactura,
        "id_creado": idCreado,
        "tx_atributo": txAtributo,
      };
}
