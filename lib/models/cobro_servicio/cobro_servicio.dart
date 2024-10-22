import 'dart:convert';

CobroServicio cobroServicioFromJson(String str) =>
    CobroServicio.fromJson(json.decode(str));

String cobroServicioToJson(CobroServicio data) => json.encode(data.toJson());

class CobroServicio {
  String? coServicio;
  String? txReferencia;
  String? nbCliente;
  String? idCliente;
  String? schemaIdCliente;
  String? acctCliente;
  String? schemaAcctCliente;
  String? agtCliente;
  String? otp;
  String? moMonto;
  String? txConcepto;
  JsDataExtra? jsDataExtra;

  CobroServicio({
    this.coServicio,
    this.txReferencia,
    this.nbCliente,
    this.idCliente,
    this.schemaIdCliente,
    this.acctCliente,
    this.schemaAcctCliente,
    this.agtCliente,
    this.otp,
    this.moMonto,
    this.txConcepto,
    this.jsDataExtra,
  });

  factory CobroServicio.fromJson(Map<String, dynamic> json) => CobroServicio(
        coServicio: json["co_servicio"],
        txReferencia: json["tx_referencia"],
        nbCliente: json["nb_cliente"],
        idCliente: json["id_cliente"],
        schemaIdCliente: json["schema_id_cliente"],
        acctCliente: json["acct_cliente"],
        schemaAcctCliente: json["schema_acct_cliente"],
        agtCliente: json["agt_cliente"],
        otp: json["otp"],
        moMonto: json["mo_monto"],
        txConcepto: json["tx_concepto"],
        jsDataExtra: json["js_data_extra"] == null
            ? null
            : JsDataExtra.fromJson(json["js_data_extra"]),
      );

  Map<String, dynamic> toJson() => {
        "co_servicio": coServicio,
        "tx_referencia": txReferencia,
        "nb_cliente": nbCliente,
        "id_cliente": idCliente,
        "schema_id_cliente": schemaIdCliente,
        "acct_cliente": acctCliente,
        "schema_acct_cliente": schemaAcctCliente,
        "agt_cliente": agtCliente,
        "otp": otp,
        "mo_monto": moMonto,
        "tx_concepto": txConcepto,
        "js_data_extra": jsDataExtra?.toJson(),
      };
}

class JsDataExtra {
  int? idFinanciamiento;
  List<int>? cuotas;

  JsDataExtra({
    this.idFinanciamiento,
    this.cuotas,
  });

  factory JsDataExtra.fromJson(Map<String, dynamic> json) => JsDataExtra(
        idFinanciamiento: json["id_financiamiento"],
        cuotas: json["cuotas"] == null
            ? []
            : List<int>.from(json["cuotas"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id_financiamiento": idFinanciamiento,
        "cuotas":
            cuotas == null ? [] : List<dynamic>.from(cuotas!.map((x) => x)),
      };
}
