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
        selected: false,
      );

  Map<String, dynamic> toJson() => {
        "id_cuota": idCuota,
        "id_financiamiento": idFinanciamiento,
        "fe_cuota":
            "${feCuota!.year.toString().padLeft(4, '0')}-${feCuota!.month.toString().padLeft(2, '0')}-${feCuota!.day.toString().padLeft(2, '0')}",
        "mo_cuota": moCuota,
        "fe_pago_cuota":
            "${fePagoCuota!.year.toString().padLeft(4, '0')}-${fePagoCuota!.month.toString().padLeft(2, '0')}-${fePagoCuota!.day.toString().padLeft(2, '0')}",
        "mo_total_cuota": moTotalCuota,
        "st_cuota": stCuota,
        "nu_cuota": nuCuota,
        "in_notificada": inNotificada,
        "selected": selected,
      };
}
