import 'dart:convert';

PagoServicio pagoServicioFromJson(String str) =>
    PagoServicio.fromJson(json.decode(str));

String pagoServicioToJson(PagoServicio data) => json.encode(data.toJson());

class PagoServicio {
  String? coServicio;
  String? txReferencia;
  double? moMonto;
  String? nbCliente;
  String? idCliente;
  String? schemaIdCliente;
  String? acctCliente;
  String? schemaAcctCliente;
  String? agtCliente;
  String? coProducto;
  String? coSubProducto;
  String? coClavePago;
  List<int>? idCuotas;

  PagoServicio({
    this.coServicio,
    this.txReferencia,
    this.moMonto,
    this.nbCliente,
    this.idCliente,
    this.schemaIdCliente,
    this.acctCliente,
    this.schemaAcctCliente,
    this.agtCliente,
    this.coProducto,
    this.coSubProducto,
    this.coClavePago,
    this.idCuotas,
  });

  factory PagoServicio.fromJson(Map<String, dynamic> json) => PagoServicio(
        coServicio: json["co_servicio"],
        txReferencia: json["tx_referencia"],
        moMonto: json["mo_monto"]?.toDouble(),
        nbCliente: json["nb_cliente"],
        idCliente: json["id_cliente"],
        schemaIdCliente: json["schema_id_cliente"],
        acctCliente: json["acct_cliente"],
        schemaAcctCliente: json["schema_acct_cliente"],
        agtCliente: json["agt_cliente"],
        coProducto: json["co_producto"],
        coSubProducto: json["co_sub_producto"],
        coClavePago: json["co_clave_pago"],
        idCuotas: json["id_cuotas"] == null
            ? []
            : List<int>.from(json["id_cuotas"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "co_servicio": coServicio,
        "tx_referencia": txReferencia,
        "mo_monto": moMonto,
        "nb_cliente": nbCliente,
        "id_cliente": idCliente,
        "schema_id_cliente": schemaIdCliente,
        "acct_cliente": acctCliente,
        "schema_acct_cliente": schemaAcctCliente,
        "agt_cliente": agtCliente,
        "co_producto": coProducto,
        "co_sub_producto": coSubProducto,
        "co_clave_pago": coClavePago,
        "id_cuotas":
            idCuotas == null ? [] : List<dynamic>.from(idCuotas!.map((x) => x)),
      };
}
