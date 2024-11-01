import 'dart:convert';

Cuota cuotaFromJson(String str) => Cuota.fromJson(json.decode(str));

String cuotaToJson(Cuota data) => json.encode(data.toJson());

class Cuota {
  int? idCuota;
  int? idFinanciamiento;
  DateTime? feCuota;
  String? moCuota;
  DateTime? fePagoCuota;
  String? moTotalCuota;
  String? stCuota;
  int? nuCuota;
  int? inNotificada;
  String? txReferencia;
  bool? selected;

  Cuota({
    this.idCuota,
    this.idFinanciamiento,
    this.feCuota,
    this.moCuota,
    this.fePagoCuota,
    this.moTotalCuota,
    this.stCuota,
    this.nuCuota,
    this.inNotificada,
    this.txReferencia,
    this.selected = false,
  });

  factory Cuota.fromJson(Map<String, dynamic> json) => Cuota(
        idCuota: json["id_cuota"],
        idFinanciamiento: json["id_financiamiento"],
        feCuota:
            json["fe_cuota"] == null ? null : DateTime.parse(json["fe_cuota"]),
        moCuota: json["mo_cuota"],
        fePagoCuota: json["fe_pago_cuota"] == null
            ? null
            : DateTime.parse(json["fe_pago_cuota"]),
        moTotalCuota: json["mo_total_cuota"],
        stCuota: json["st_cuota"],
        nuCuota: json["nu_cuota"],
        inNotificada: json["in_notificada"],
        txReferencia: json["tx_referencia"],
        selected: false,
      );

  Map<String, dynamic> toJson() => {
        "id_cuota": idCuota,
        "id_financiamiento": idFinanciamiento,
        "fe_cuota": feCuota,
        "mo_cuota": moCuota,
        "fe_pago_cuota": fePagoCuota,
        "mo_total_cuota": moTotalCuota,
        "st_cuota": stCuota,
        "nu_cuota": nuCuota,
        "in_notificada": inNotificada,
        'tx_referencia': txReferencia,
        "selected": selected,
      };
}
