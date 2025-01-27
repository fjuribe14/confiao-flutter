import 'dart:convert';

SolicitarClavePago solicitarClavePagoFromJson(String str) =>
    SolicitarClavePago.fromJson(json.decode(str));

String solicitarClavePagoToJson(SolicitarClavePago data) =>
    json.encode(data.toJson());

class SolicitarClavePago {
  double? moMonto;
  String? agtCliente;
  String? schemaIdCliente;
  String? schemaAcctCliente;
  String? idCliente;
  String? acctCliente;
  String? txIdentificacionEmpresa;

  SolicitarClavePago({
    this.moMonto,
    this.agtCliente,
    this.schemaIdCliente,
    this.schemaAcctCliente,
    this.idCliente,
    this.acctCliente,
    this.txIdentificacionEmpresa,
  });

  factory SolicitarClavePago.fromJson(Map<String, dynamic> json) =>
      SolicitarClavePago(
        moMonto: json["mo_monto"],
        agtCliente: json["agt_cliente"],
        schemaIdCliente: json["schema_id_cliente"],
        schemaAcctCliente: json["schema_acct_cliente"],
        idCliente: json["id_cliente"],
        acctCliente: json["acct_cliente"],
        txIdentificacionEmpresa: json["tx_identificacion_empresa"],
      );

  Map<String, dynamic> toJson() => {
        "mo_monto": moMonto,
        "agt_cliente": agtCliente,
        "schema_id_cliente": schemaIdCliente,
        "schema_acct_cliente": schemaAcctCliente,
        "id_cliente": idCliente,
        "acct_cliente": acctCliente,
        "tx_identificacion_empresa": txIdentificacionEmpresa,
      };
}
