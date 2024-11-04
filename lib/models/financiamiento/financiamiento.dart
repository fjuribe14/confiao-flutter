import 'dart:convert';

import 'package:confiao/models/index.dart';

Financiamiento financiamientoFromJson(String str) =>
    Financiamiento.fromJson(json.decode(str));

String financiamientoToJson(Financiamiento data) => json.encode(data.toJson());

class Financiamiento {
  int? idFinanciamiento;
  dynamic nuDocumento;
  DateTime? feFinanciamiento;
  String? idCliente;
  String? txDireccionFinanciamiento;
  String? moPrestamo;
  DateTime? fe1RaCuota;
  DateTime? feVencimiento;
  int? nuCuotas;
  int? nuDiasEntreCuotas;
  String? moCuota;
  String? pcTasaInteres;
  String? stFinanciamiento;
  int? idSucursalTienda;
  String? moTotalFinanc;
  String? moCuotaInicial;
  int? idFinanciador;
  dynamic idModeloFinanciamiento;
  int? idNivelCliente;
  String? moInteres;
  dynamic coIdentificacionCliente;
  String? txIdentificacionCliente;
  String? coIdentificacionEmpresa;
  int? idUsuarioCreador;
  String? moFlat;
  String? pcComisionFlat;
  List<Cuota>? cuotas;

  Financiamiento({
    this.idFinanciamiento,
    this.nuDocumento,
    this.feFinanciamiento,
    this.idCliente,
    this.txDireccionFinanciamiento,
    this.moPrestamo,
    this.fe1RaCuota,
    this.feVencimiento,
    this.nuCuotas,
    this.nuDiasEntreCuotas,
    this.moCuota,
    this.pcTasaInteres,
    this.stFinanciamiento,
    this.idSucursalTienda,
    this.moTotalFinanc,
    this.moCuotaInicial,
    this.idFinanciador,
    this.idModeloFinanciamiento,
    this.idNivelCliente,
    this.moInteres,
    this.coIdentificacionCliente,
    this.txIdentificacionCliente,
    this.coIdentificacionEmpresa,
    this.idUsuarioCreador,
    this.moFlat,
    this.pcComisionFlat,
    this.cuotas,
  });

  factory Financiamiento.fromJson(Map<String, dynamic> json) => Financiamiento(
        idFinanciamiento: json["id_financiamiento"],
        nuDocumento: json["nu_documento"],
        feFinanciamiento: json["fe_financiamiento"] == null
            ? null
            : DateTime.parse(json["fe_financiamiento"]),
        idCliente: json["id_cliente"],
        txDireccionFinanciamiento: json["tx_direccion_financiamiento"],
        moPrestamo: json["mo_prestamo"],
        fe1RaCuota: json["fe_1ra_cuota"] == null
            ? null
            : DateTime.parse(json["fe_1ra_cuota"]),
        feVencimiento: json["fe_vencimiento"] == null
            ? null
            : DateTime.parse(json["fe_vencimiento"]),
        nuCuotas: json["nu_cuotas"],
        nuDiasEntreCuotas: json["nu_dias_entre_cuotas"],
        moCuota: json["mo_cuota"],
        pcTasaInteres: json["pc_tasa_interes"],
        stFinanciamiento: json["st_financiamiento"],
        idSucursalTienda: json["id_sucursal_tienda"],
        moTotalFinanc: json["mo_total_financ"],
        moCuotaInicial: json["mo_cuota_inicial"],
        idFinanciador: json["id_financiador"],
        idModeloFinanciamiento: json["id_modelo_financiamiento"],
        idNivelCliente: json["id_nivel_cliente"],
        moInteres: json["mo_interes"],
        coIdentificacionCliente: json["co_identificacion_cliente"],
        txIdentificacionCliente: json["tx_identificacion_cliente"],
        coIdentificacionEmpresa: json["co_identificacion_empresa"],
        idUsuarioCreador: json["id_usuario_creador"],
        moFlat: json["mo_flat"],
        pcComisionFlat: json["pc_comision_flat"],
        cuotas: json["cuotas"] == null
            ? []
            : List<Cuota>.from(json["cuotas"]!.map((x) => Cuota.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id_financiamiento": idFinanciamiento,
        "nu_documento": nuDocumento,
        "fe_financiamiento": fe1RaCuota,
        "id_cliente": idCliente,
        "tx_direccion_financiamiento": txDireccionFinanciamiento,
        "mo_prestamo": moPrestamo,
        "fe_1ra_cuota": fe1RaCuota,
        "fe_vencimiento": feVencimiento,
        "nu_cuotas": nuCuotas,
        "nu_dias_entre_cuotas": nuDiasEntreCuotas,
        "mo_cuota": moCuota,
        "pc_tasa_interes": pcTasaInteres,
        "st_financiamiento": stFinanciamiento,
        "id_sucursal_tienda": idSucursalTienda,
        "mo_total_financ": moTotalFinanc,
        "mo_cuota_inicial": moCuotaInicial,
        "id_financiador": idFinanciador,
        "id_modelo_financiamiento": idModeloFinanciamiento,
        "id_nivel_cliente": idNivelCliente,
        "mo_interes": moInteres,
        "co_identificacion_cliente": coIdentificacionCliente,
        "tx_identificacion_cliente": txIdentificacionCliente,
        "co_identificacion_empresa": coIdentificacionEmpresa,
        "id_usuario_creador": idUsuarioCreador,
        "mo_flat": moFlat,
        "pc_comision_flat": pcComisionFlat,
        "cuotas": cuotas == null
            ? []
            : List<dynamic>.from(cuotas!.map((x) => x.toJson())),
      };
}
