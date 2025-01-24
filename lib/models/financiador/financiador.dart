import 'dart:convert';

Financiador financiadorFromJson(String str) =>
    Financiador.fromJson(json.decode(str));

String financiadorToJson(Financiador data) => json.encode(data.toJson());

class Financiador {
  int? idFinanciador;
  String? nbFinanciador;
  String? txIdentificacion;
  String? txImagen;
  String? tiIdentificacion;
  String? moLimiteFinanciamiento;
  String? moFinanciadoTotal;
  String? stFinanciador;
  bool? inAfiliado;
  bool? inPublico;
  bool? inBeneficiario;
  LimiteCliente? limiteCliente;

  Financiador({
    this.idFinanciador,
    this.nbFinanciador,
    this.txIdentificacion,
    this.txImagen,
    this.tiIdentificacion,
    this.moLimiteFinanciamiento,
    this.moFinanciadoTotal,
    this.stFinanciador,
    this.inAfiliado,
    this.inPublico,
    this.inBeneficiario,
    this.limiteCliente,
  });

  factory Financiador.fromJson(Map<String, dynamic> json) => Financiador(
        idFinanciador: json["id_financiador"],
        nbFinanciador: json["nb_financiador"],
        txIdentificacion: json["tx_identificacion"],
        txImagen: json["tx_imagen"],
        tiIdentificacion: json["ti_identificacion"],
        moLimiteFinanciamiento: json["mo_limite_financiamiento"],
        moFinanciadoTotal: json["mo_financiado_total"],
        stFinanciador: json["st_financiador"],
        inAfiliado: json["in_afiliado"],
        inPublico: json["in_publico"],
        inBeneficiario: json["in_beneficiario"],
        limiteCliente: json["limite_cliente"] == null
            ? null
            : LimiteCliente.fromJson(json["limite_cliente"]),
      );

  Map<String, dynamic> toJson() => {
        "id_financiador": idFinanciador,
        "nb_financiador": nbFinanciador,
        "tx_identificacion": txIdentificacion,
        "tx_imagen": txImagen,
        "ti_identificacion": tiIdentificacion,
        "mo_limite_financiamiento": moLimiteFinanciamiento,
        "mo_financiado_total": moFinanciadoTotal,
        "st_financiador": stFinanciador,
        "in_afiliado": inAfiliado,
        "in_publico": inPublico,
        "in_beneficiario": inBeneficiario,
        "limite_cliente": limiteCliente?.toJson(),
      };
}

class LimiteCliente {
  int? idLimiteCliente;
  int? idNivelCliente;
  String? moLimite;
  String? moDeuda;
  String? moDisponible;
  String? stLimite;
  int? idFinanciador;
  String? txIdentificacionCliente;
  String? coIdentificacionCliente;
  String? idCliente;

  LimiteCliente({
    this.idLimiteCliente,
    this.idNivelCliente,
    this.moLimite,
    this.moDeuda,
    this.moDisponible,
    this.stLimite,
    this.idFinanciador,
    this.txIdentificacionCliente,
    this.coIdentificacionCliente,
    this.idCliente,
  });

  factory LimiteCliente.fromJson(Map<String, dynamic> json) => LimiteCliente(
        idLimiteCliente: json["id_limite_cliente"],
        idNivelCliente: json["id_nivel_cliente"],
        moLimite: json["mo_limite"],
        moDeuda: json["mo_deuda"],
        moDisponible: json["mo_disponible"],
        stLimite: json["st_limite"],
        idFinanciador: json["id_financiador"],
        txIdentificacionCliente: json["tx_identificacion_cliente"],
        coIdentificacionCliente: json["co_identificacion_cliente"],
        idCliente: json["id_cliente"],
      );

  Map<String, dynamic> toJson() => {
        "id_limite_cliente": idLimiteCliente,
        "id_nivel_cliente": idNivelCliente,
        "mo_limite": moLimite,
        "mo_deuda": moDeuda,
        "mo_disponible": moDisponible,
        "st_limite": stLimite,
        "id_financiador": idFinanciador,
        "tx_identificacion_cliente": txIdentificacionCliente,
        "co_identificacion_cliente": coIdentificacionCliente,
        "id_cliente": idCliente,
      };
}
