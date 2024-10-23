import 'dart:convert';

ModeloFinanciamiento modeloFinanciamientoFromJson(String str) =>
    ModeloFinanciamiento.fromJson(json.decode(str));

String modeloFinanciamientoToJson(ModeloFinanciamiento data) =>
    json.encode(data.toJson());

class ModeloFinanciamiento {
  int? idModeloFinanciamiento;
  String? pcInicial;
  String? pcEnCuotas;
  int? caCuotas;
  String? moLimite;
  String? coMoneda;
  String? stModeloFinanciamiento;
  int? nuDiasEntreCuotas;
  String? pcTasaInteres;
  String? moPenalizacionCuota;
  String? pcPenalizacionCuota;
  String? txModeloFinanciamiento;
  String? pcTasaComisionFlat;
  String? pcTasaDispersion;

  ModeloFinanciamiento({
    this.idModeloFinanciamiento,
    this.pcInicial,
    this.pcEnCuotas,
    this.caCuotas,
    this.moLimite,
    this.coMoneda,
    this.stModeloFinanciamiento,
    this.nuDiasEntreCuotas,
    this.pcTasaInteres,
    this.moPenalizacionCuota,
    this.pcPenalizacionCuota,
    this.txModeloFinanciamiento,
    this.pcTasaComisionFlat,
    this.pcTasaDispersion,
  });

  factory ModeloFinanciamiento.fromJson(Map<String, dynamic> json) =>
      ModeloFinanciamiento(
        idModeloFinanciamiento: json["id_modelo_financiamiento"],
        pcInicial: json["pc_inicial"],
        pcEnCuotas: json["pc_en_cuotas"],
        caCuotas: json["ca_cuotas"],
        moLimite: json["mo_limite"],
        coMoneda: json["co_moneda"],
        stModeloFinanciamiento: json["st_modelo_financiamiento"],
        nuDiasEntreCuotas: json["nu_dias_entre_cuotas"],
        pcTasaInteres: json["pc_tasa_interes"],
        moPenalizacionCuota: json["mo_penalizacion_cuota"],
        pcPenalizacionCuota: json["pc_penalizacion_cuota"],
        txModeloFinanciamiento: json["tx_modelo_financiamiento"],
        pcTasaComisionFlat: json["pc_tasa_comision_flat"],
        pcTasaDispersion: json["pc_tasa_dispersion"],
      );

  Map<String, dynamic> toJson() => {
        "id_modelo_financiamiento": idModeloFinanciamiento,
        "pc_inicial": pcInicial,
        "pc_en_cuotas": pcEnCuotas,
        "ca_cuotas": caCuotas,
        "mo_limite": moLimite,
        "co_moneda": coMoneda,
        "st_modelo_financiamiento": stModeloFinanciamiento,
        "nu_dias_entre_cuotas": nuDiasEntreCuotas,
        "pc_tasa_interes": pcTasaInteres,
        "mo_penalizacion_cuota": moPenalizacionCuota,
        "pc_penalizacion_cuota": pcPenalizacionCuota,
        "tx_modelo_financiamiento": txModeloFinanciamiento,
        "pc_tasa_comision_flat": pcTasaComisionFlat,
        "pc_tasa_dispersion": pcTasaDispersion,
      };
}
