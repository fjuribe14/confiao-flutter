import 'dart:convert';

Cuota cuotaFromJson(String str) => Cuota.fromJson(json.decode(str));

String cuotaToJson(Cuota data) => json.encode(data.toJson());

class Cuota {
  int? idCuota;
  int? idFinanciamiento;
  DateTime? feCuota;
  String? moCuota;
  DateTime? fePagoCuota;
  String? moInteresCuota;
  String? moTotalCuota;
  String? stCuota;
  int? nuCuota;
  int? inNotificada;
  String? txReferencia;
  String? idCuotaUuid;
  String? moInicioCuota;
  String? moSaldoCuota;
  bool selected;

  Cuota({
    this.idCuota,
    this.idFinanciamiento,
    this.feCuota,
    this.moCuota,
    this.fePagoCuota,
    this.moInteresCuota,
    this.moTotalCuota,
    this.stCuota,
    this.nuCuota,
    this.inNotificada,
    this.txReferencia,
    this.idCuotaUuid,
    this.moInicioCuota,
    this.moSaldoCuota,
    required this.selected,
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
        moInteresCuota: json["mo_interes_cuota"],
        moTotalCuota: json["mo_total_cuota"],
        stCuota: json["st_cuota"],
        nuCuota: json["nu_cuota"],
        inNotificada: json["in_notificada"],
        txReferencia: json["tx_referencia"],
        idCuotaUuid: json["id_cuota_uuid"],
        moInicioCuota: json["mo_inicio_cuota"],
        moSaldoCuota: json["mo_saldo_cuota"],
        selected: false,
      );

  Map<String, dynamic> toJson() => {
        "id_cuota": idCuota,
        "id_financiamiento": idFinanciamiento,
        "fe_cuota": feCuota == null
            ? null
            : "${feCuota!.year.toString().padLeft(4, '0')}-${feCuota!.month.toString().padLeft(2, '0')}-${feCuota!.day.toString().padLeft(2, '0')}",
        "mo_cuota": moCuota,
        "fe_pago_cuota": fePagoCuota == null
            ? null
            : "${fePagoCuota!.year.toString().padLeft(4, '0')}-${fePagoCuota!.month.toString().padLeft(2, '0')}-${fePagoCuota!.day.toString().padLeft(2, '0')}",
        "mo_interes_cuota": moInteresCuota,
        "mo_total_cuota": moTotalCuota,
        "st_cuota": stCuota,
        "nu_cuota": nuCuota,
        "in_notificada": inNotificada,
        "tx_referencia": txReferencia,
        "id_cuota_uuid": idCuotaUuid,
        "mo_inicio_cuota": moInicioCuota,
        "mo_saldo_cuota": moSaldoCuota,
      };
}
