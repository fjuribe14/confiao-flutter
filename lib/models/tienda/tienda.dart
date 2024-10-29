import 'dart:convert';

Tienda tiendaFromJson(String str) => Tienda.fromJson(json.decode(str));

String tiendaToJson(Tienda data) => json.encode(data.toJson());

class Tienda {
  int? idEmpresa;
  String? nbEmpresa;
  String? coIdentificacion;
  String? txDireccion;
  String? txDescripcion;
  bool? boFinanciamiento;
  String? txImagen;
  bool? credito;
  List<EmpresaModeloFinanciamiento>? empresaModeloFinanciamiento;

  Tienda({
    this.idEmpresa,
    this.nbEmpresa,
    this.coIdentificacion,
    this.txDireccion,
    this.txDescripcion,
    this.boFinanciamiento,
    this.txImagen,
    this.credito,
    this.empresaModeloFinanciamiento,
  });

  factory Tienda.fromJson(Map<String, dynamic> json) => Tienda(
        idEmpresa: json["id_empresa"],
        nbEmpresa: json["nb_empresa"],
        coIdentificacion: json["co_identificacion"],
        txDireccion: json["tx_direccion"],
        txDescripcion: json["tx_descripcion"],
        boFinanciamiento: json["bo_financiamiento"],
        txImagen: json["tx_imagen"],
        credito: json["credito"],
        empresaModeloFinanciamiento:
            json["empresa_modelo_financiamiento"] == null
                ? []
                : List<EmpresaModeloFinanciamiento>.from(
                    json["empresa_modelo_financiamiento"]!
                        .map((x) => EmpresaModeloFinanciamiento.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id_empresa": idEmpresa,
        "nb_empresa": nbEmpresa,
        "co_identificacion": coIdentificacion,
        "tx_direccion": txDireccion,
        "tx_descripcion": txDescripcion,
        "bo_financiamiento": boFinanciamiento,
        "tx_imagen": txImagen,
        "credito": credito,
        "empresa_modelo_financiamiento": empresaModeloFinanciamiento == null
            ? []
            : List<dynamic>.from(
                empresaModeloFinanciamiento!.map((x) => x.toJson())),
      };
}

class EmpresaModeloFinanciamiento {
  int? idEmpresaModeloFinanciamiento;
  int? idEmpresa;
  String? idModeloFinanciamiento;
  String? txTipoModeloFinanciamiento;

  EmpresaModeloFinanciamiento({
    this.idEmpresaModeloFinanciamiento,
    this.idEmpresa,
    this.idModeloFinanciamiento,
    this.txTipoModeloFinanciamiento,
  });

  factory EmpresaModeloFinanciamiento.fromJson(Map<String, dynamic> json) =>
      EmpresaModeloFinanciamiento(
        idEmpresaModeloFinanciamiento: json["id_empresa_modelo_financiamiento"],
        idEmpresa: json["id_empresa"],
        idModeloFinanciamiento: json["id_modelo_financiamiento"],
        txTipoModeloFinanciamiento: json["tx_tipo_modelo_financiamiento"],
      );

  Map<String, dynamic> toJson() => {
        "id_empresa_modelo_financiamiento": idEmpresaModeloFinanciamiento,
        "id_empresa": idEmpresa,
        "id_modelo_financiamiento": idModeloFinanciamiento,
        "tx_tipo_modelo_financiamiento": txTipoModeloFinanciamiento,
      };
}
