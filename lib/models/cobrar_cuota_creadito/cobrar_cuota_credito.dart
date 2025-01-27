import 'dart:convert';

CobrarCuotaDebito cobrarCuotaDebitoFromJson(String str) =>
    CobrarCuotaDebito.fromJson(json.decode(str));

String cobrarCuotaDebitoToJson(CobrarCuotaDebito data) =>
    json.encode(data.toJson());

class CobrarCuotaDebito {
  int? idFinanciamiento;
  List<int?> cuotas;
  String? coCdtragtReceptor;
  String? coSchemaIdReceptor;
  String? coSchemaAcctReceptor;
  String? idCdtrReceptor;
  String? idAcctReceptor;
  String? txClavePago;

  CobrarCuotaDebito({
    this.idFinanciamiento,
    required this.cuotas,
    this.coCdtragtReceptor,
    this.coSchemaIdReceptor,
    this.coSchemaAcctReceptor,
    this.idCdtrReceptor,
    this.idAcctReceptor,
    this.txClavePago,
  });

  factory CobrarCuotaDebito.fromJson(Map<String, dynamic> json) =>
      CobrarCuotaDebito(
        idFinanciamiento: json["id_financiamiento"],
        cuotas: json["cuotas"] == null
            ? []
            : List<int>.from(json["cuotas"]!.map((x) => x)),
        coCdtragtReceptor: json["co_cdtragt_receptor"],
        coSchemaIdReceptor: json["co_schema_id_receptor"],
        coSchemaAcctReceptor: json["co_schema_acct_receptor"],
        idCdtrReceptor: json["id_cdtr_receptor"],
        idAcctReceptor: json["id_acct_receptor"],
        txClavePago: json["tx_clave_pago"],
      );

  Map<String, dynamic> toJson() => {
        "id_financiamiento": idFinanciamiento,
        "cuotas": List<dynamic>.from(cuotas.map((x) => x)),
        "co_cdtragt_receptor": coCdtragtReceptor,
        "co_schema_id_receptor": coSchemaIdReceptor,
        "co_schema_acct_receptor": coSchemaAcctReceptor,
        "id_cdtr_receptor": idCdtrReceptor,
        "id_acct_receptor": idAcctReceptor,
        "tx_clave_pago": txClavePago,
      };
}
