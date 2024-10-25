import 'dart:convert';

TasaValor tasaValorFromJson(String str) => TasaValor.fromJson(json.decode(str));

String tasaValorToJson(TasaValor data) => json.encode(data.toJson());

class TasaValor {
  int? idTasa;
  String? moMonto;
  String? coTasa;
  DateTime? fechaValor;

  TasaValor({
    this.idTasa,
    this.moMonto,
    this.coTasa,
    this.fechaValor,
  });

  factory TasaValor.fromJson(Map<String, dynamic> json) => TasaValor(
        idTasa: json["id_tasa"],
        moMonto: json["mo_monto"],
        coTasa: json["co_tasa"],
        fechaValor: json["fecha_valor"] == null
            ? null
            : DateTime.parse(json["fecha_valor"]),
      );

  Map<String, dynamic> toJson() => {
        "id_tasa": idTasa,
        "mo_monto": moMonto,
        "co_tasa": coTasa,
        "fecha_valor":
            "${fechaValor!.year.toString().padLeft(4, '0')}-${fechaValor!.month.toString().padLeft(2, '0')}-${fechaValor!.day.toString().padLeft(2, '0')}",
      };
}
