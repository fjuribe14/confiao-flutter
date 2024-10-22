import 'dart:convert';

Financiador financiadorFromJson(String str) =>
    Financiador.fromJson(json.decode(str));

String financiadorToJson(Financiador data) => json.encode(data.toJson());

class Financiador {
  int? idFinanciador;
  String? nbFinanciador;
  String? txIdentificacion;
  String? tiIdentificacion;
  String? moLimiteFinanciamiento;
  dynamic moFinanciadoTotal;
  String? stFinanciador;
  bool? inAfiliado;
  dynamic limiteCliente;

  Financiador({
    this.idFinanciador,
    this.nbFinanciador,
    this.txIdentificacion,
    this.tiIdentificacion,
    this.moLimiteFinanciamiento,
    this.moFinanciadoTotal,
    this.stFinanciador,
    this.inAfiliado,
    this.limiteCliente,
  });

  factory Financiador.fromJson(Map<String, dynamic> json) => Financiador(
        idFinanciador: json["id_financiador"],
        nbFinanciador: json["nb_financiador"],
        txIdentificacion: json["tx_identificacion"],
        tiIdentificacion: json["ti_identificacion"],
        moLimiteFinanciamiento: json["mo_limite_financiamiento"],
        moFinanciadoTotal: json["mo_financiado_total"],
        stFinanciador: json["st_financiador"],
        inAfiliado: json["in_afiliado"],
        limiteCliente: json["limite_cliente"],
      );

  Map<String, dynamic> toJson() => {
        "id_financiador": idFinanciador,
        "nb_financiador": nbFinanciador,
        "tx_identificacion": txIdentificacion,
        "ti_identificacion": tiIdentificacion,
        "mo_limite_financiamiento": moLimiteFinanciamiento,
        "mo_financiado_total": moFinanciadoTotal,
        "st_financiador": stFinanciador,
        "in_afiliado": inAfiliado,
        "limite_cliente": limiteCliente,
      };
}
