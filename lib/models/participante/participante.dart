import 'dart:convert';

Participante participanteFromJson(String str) =>
    Participante.fromJson(json.decode(str));

String participanteToJson(Participante data) => json.encode(data.toJson());

class Participante {
  int? coParticipante;
  String? nbParticipante;
  bool? stInpersonal;
  String? stParticipante;
  String? txAlias;

  Participante({
    this.coParticipante,
    this.nbParticipante,
    this.stInpersonal,
    this.stParticipante,
    this.txAlias,
  });

  factory Participante.fromJson(Map<String, dynamic> json) => Participante(
        coParticipante: json["co_participante"],
        nbParticipante: json["nb_participante"],
        stInpersonal: json["st_inpersonal"],
        stParticipante: json["st_participante"],
        txAlias: json["tx_alias"],
      );

  Map<String, dynamic> toJson() => {
        "co_participante": coParticipante,
        "nb_participante": nbParticipante,
        "st_inpersonal": stInpersonal,
        "st_participante": stParticipante,
        "tx_alias": txAlias,
      };
}
