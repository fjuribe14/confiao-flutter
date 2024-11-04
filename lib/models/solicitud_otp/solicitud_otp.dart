import 'dart:convert';

SolicitudOtp solicitudOtpFromJson(String str) =>
    SolicitudOtp.fromJson(json.decode(str));

String solicitudOtpToJson(SolicitudOtp data) => json.encode(data.toJson());

class SolicitudOtp {
  AuthstnReq? authstnReq;

  SolicitudOtp({
    this.authstnReq,
  });

  factory SolicitudOtp.fromJson(Map<String, dynamic> json) => SolicitudOtp(
        authstnReq: json["AuthstnReq"] == null
            ? null
            : AuthstnReq.fromJson(json["AuthstnReq"]),
      );

  Map<String, dynamic> toJson() => {
        "AuthstnReq": authstnReq?.toJson(),
      };
}

class AuthstnReq {
  GrpHdr? grpHdr;
  Initn? initn;

  AuthstnReq({
    this.grpHdr,
    this.initn,
  });

  factory AuthstnReq.fromJson(Map<String, dynamic> json) => AuthstnReq(
        grpHdr: json["GrpHdr"] == null ? null : GrpHdr.fromJson(json["GrpHdr"]),
        initn: json["Initn"] == null ? null : Initn.fromJson(json["Initn"]),
      );

  Map<String, dynamic> toJson() => {
        "GrpHdr": grpHdr?.toJson(),
        "Initn": initn?.toJson(),
      };
}

class GrpHdr {
  String? msgId;
  DateTime? creDtTm;
  Agt? instgAgt;
  Agt? instdAgt;
  InitgPty? initgPty;
  InitnSrc? initnSrc;

  GrpHdr({
    this.msgId,
    this.creDtTm,
    this.instgAgt,
    this.instdAgt,
    this.initgPty,
    this.initnSrc,
  });

  factory GrpHdr.fromJson(Map<String, dynamic> json) => GrpHdr(
        msgId: json["MsgId"],
        creDtTm:
            json["CreDtTm"] == null ? null : DateTime.parse(json["CreDtTm"]),
        instgAgt:
            json["InstgAgt"] == null ? null : Agt.fromJson(json["InstgAgt"]),
        instdAgt:
            json["InstdAgt"] == null ? null : Agt.fromJson(json["InstdAgt"]),
        initgPty: json["InitgPty"] == null
            ? null
            : InitgPty.fromJson(json["InitgPty"]),
        initnSrc: json["InitnSrc"] == null
            ? null
            : InitnSrc.fromJson(json["InitnSrc"]),
      );

  Map<String, dynamic> toJson() => {
        "MsgId": msgId,
        "CreDtTm": creDtTm?.toIso8601String(),
        "InstgAgt": instgAgt?.toJson(),
        "InstdAgt": instdAgt?.toJson(),
        "InitgPty": initgPty?.toJson(),
        "InitnSrc": initnSrc?.toJson(),
      };
}

class InitgPty {
  InitgPtyId? id;

  InitgPty({
    this.id,
  });

  factory InitgPty.fromJson(Map<String, dynamic> json) => InitgPty(
        id: json["Id"] == null ? null : InitgPtyId.fromJson(json["Id"]),
      );

  Map<String, dynamic> toJson() => {
        "Id": id?.toJson(),
      };
}

class InitgPtyId {
  PurplePrvtId? prvtId;

  InitgPtyId({
    this.prvtId,
  });

  factory InitgPtyId.fromJson(Map<String, dynamic> json) => InitgPtyId(
        prvtId: json["PrvtId"] == null
            ? null
            : PurplePrvtId.fromJson(json["PrvtId"]),
      );

  Map<String, dynamic> toJson() => {
        "PrvtId": prvtId?.toJson(),
      };
}

class PurplePrvtId {
  PurpleOthr? othr;

  PurplePrvtId({
    this.othr,
  });

  factory PurplePrvtId.fromJson(Map<String, dynamic> json) => PurplePrvtId(
        othr: json["Othr"] == null ? null : PurpleOthr.fromJson(json["Othr"]),
      );

  Map<String, dynamic> toJson() => {
        "Othr": othr?.toJson(),
      };
}

class PurpleOthr {
  String? id;

  PurpleOthr({
    this.id,
  });

  factory PurpleOthr.fromJson(Map<String, dynamic> json) => PurpleOthr(
        id: json["Id"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
      };
}

class InitnSrc {
  String? nm;
  String? prvdr;
  String? vrsn;

  InitnSrc({
    this.nm,
    this.prvdr,
    this.vrsn,
  });

  factory InitnSrc.fromJson(Map<String, dynamic> json) => InitnSrc(
        nm: json["Nm"],
        prvdr: json["Prvdr"],
        vrsn: json["Vrsn"],
      );

  Map<String, dynamic> toJson() => {
        "Nm": nm,
        "Prvdr": prvdr,
        "Vrsn": vrsn,
      };
}

class Agt {
  FinInstnId? finInstnId;

  Agt({
    this.finInstnId,
  });

  factory Agt.fromJson(Map<String, dynamic> json) => Agt(
        finInstnId: json["FinInstnId"] == null
            ? null
            : FinInstnId.fromJson(json["FinInstnId"]),
      );

  Map<String, dynamic> toJson() => {
        "FinInstnId": finInstnId?.toJson(),
      };
}

class FinInstnId {
  ClrSysMmbId? clrSysMmbId;

  FinInstnId({
    this.clrSysMmbId,
  });

  factory FinInstnId.fromJson(Map<String, dynamic> json) => FinInstnId(
        clrSysMmbId: json["ClrSysMmbId"] == null
            ? null
            : ClrSysMmbId.fromJson(json["ClrSysMmbId"]),
      );

  Map<String, dynamic> toJson() => {
        "ClrSysMmbId": clrSysMmbId?.toJson(),
      };
}

class ClrSysMmbId {
  ClrSysId? clrSysId;
  String? mmbId;

  ClrSysMmbId({
    this.clrSysId,
    this.mmbId,
  });

  factory ClrSysMmbId.fromJson(Map<String, dynamic> json) => ClrSysMmbId(
        clrSysId: json["ClrSysId"] == null
            ? null
            : ClrSysId.fromJson(json["ClrSysId"]),
        mmbId: json["MmbId"],
      );

  Map<String, dynamic> toJson() => {
        "ClrSysId": clrSysId?.toJson(),
        "MmbId": mmbId,
      };
}

class ClrSysId {
  String? cd;

  ClrSysId({
    this.cd,
  });

  factory ClrSysId.fromJson(Map<String, dynamic> json) => ClrSysId(
        cd: json["Cd"],
      );

  Map<String, dynamic> toJson() => {
        "Cd": cd,
      };
}

class Initn {
  OrgnlTxRef? orgnlTxRef;

  Initn({
    this.orgnlTxRef,
  });

  factory Initn.fromJson(Map<String, dynamic> json) => Initn(
        orgnlTxRef: json["OrgnlTxRef"] == null
            ? null
            : OrgnlTxRef.fromJson(json["OrgnlTxRef"]),
      );

  Map<String, dynamic> toJson() => {
        "OrgnlTxRef": orgnlTxRef?.toJson(),
      };
}

class OrgnlTxRef {
  InstdAmt? instdAmt;
  MndtRltdInf? mndtRltdInf;
  Cdtr? dbtr;
  Agt? dbtrAgt;
  TrAcct? dbtrAcct;
  Cdtr? cdtr;
  Agt? cdtrAgt;
  TrAcct? cdtrAcct;

  OrgnlTxRef({
    this.instdAmt,
    this.mndtRltdInf,
    this.dbtr,
    this.dbtrAgt,
    this.dbtrAcct,
    this.cdtr,
    this.cdtrAgt,
    this.cdtrAcct,
  });

  factory OrgnlTxRef.fromJson(Map<String, dynamic> json) => OrgnlTxRef(
        instdAmt: json["InstdAmt"] == null
            ? null
            : InstdAmt.fromJson(json["InstdAmt"]),
        mndtRltdInf: json["MndtRltdInf"] == null
            ? null
            : MndtRltdInf.fromJson(json["MndtRltdInf"]),
        dbtr: json["Dbtr"] == null ? null : Cdtr.fromJson(json["Dbtr"]),
        dbtrAgt: json["DbtrAgt"] == null ? null : Agt.fromJson(json["DbtrAgt"]),
        dbtrAcct:
            json["DbtrAcct"] == null ? null : TrAcct.fromJson(json["DbtrAcct"]),
        cdtr: json["Cdtr"] == null ? null : Cdtr.fromJson(json["Cdtr"]),
        cdtrAgt: json["CdtrAgt"] == null ? null : Agt.fromJson(json["CdtrAgt"]),
        cdtrAcct:
            json["CdtrAcct"] == null ? null : TrAcct.fromJson(json["CdtrAcct"]),
      );

  Map<String, dynamic> toJson() => {
        "InstdAmt": instdAmt?.toJson(),
        "MndtRltdInf": mndtRltdInf?.toJson(),
        "Dbtr": dbtr?.toJson(),
        "DbtrAgt": dbtrAgt?.toJson(),
        "DbtrAcct": dbtrAcct?.toJson(),
        "Cdtr": cdtr?.toJson(),
        "CdtrAgt": cdtrAgt?.toJson(),
        "CdtrAcct": cdtrAcct?.toJson(),
      };
}

class Cdtr {
  CdtrId? id;

  Cdtr({
    this.id,
  });

  factory Cdtr.fromJson(Map<String, dynamic> json) => Cdtr(
        id: json["Id"] == null ? null : CdtrId.fromJson(json["Id"]),
      );

  Map<String, dynamic> toJson() => {
        "Id": id?.toJson(),
      };
}

class CdtrId {
  FluffyPrvtId? prvtId;

  CdtrId({
    this.prvtId,
  });

  factory CdtrId.fromJson(Map<String, dynamic> json) => CdtrId(
        prvtId: json["PrvtId"] == null
            ? null
            : FluffyPrvtId.fromJson(json["PrvtId"]),
      );

  Map<String, dynamic> toJson() => {
        "PrvtId": prvtId?.toJson(),
      };
}

class FluffyPrvtId {
  FluffyOthr? othr;

  FluffyPrvtId({
    this.othr,
  });

  factory FluffyPrvtId.fromJson(Map<String, dynamic> json) => FluffyPrvtId(
        othr: json["Othr"] == null ? null : FluffyOthr.fromJson(json["Othr"]),
      );

  Map<String, dynamic> toJson() => {
        "Othr": othr?.toJson(),
      };
}

class FluffyOthr {
  String? id;
  ClrSysId? schmeNm;

  FluffyOthr({
    this.id,
    this.schmeNm,
  });

  factory FluffyOthr.fromJson(Map<String, dynamic> json) => FluffyOthr(
        id: json["Id"],
        schmeNm:
            json["SchmeNm"] == null ? null : ClrSysId.fromJson(json["SchmeNm"]),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "SchmeNm": schmeNm?.toJson(),
      };
}

class TrAcct {
  Prxy? prxy;

  TrAcct({
    this.prxy,
  });

  factory TrAcct.fromJson(Map<String, dynamic> json) => TrAcct(
        prxy: json["Prxy"] == null ? null : Prxy.fromJson(json["Prxy"]),
      );

  Map<String, dynamic> toJson() => {
        "Prxy": prxy?.toJson(),
      };
}

class Prxy {
  ClrSysId? tp;
  String? id;

  Prxy({
    this.tp,
    this.id,
  });

  factory Prxy.fromJson(Map<String, dynamic> json) => Prxy(
        tp: json["Tp"] == null ? null : ClrSysId.fromJson(json["Tp"]),
        id: json["Id"],
      );

  Map<String, dynamic> toJson() => {
        "Tp": tp?.toJson(),
        "Id": id,
      };
}

class InstdAmt {
  String? ccy;
  double? amt;

  InstdAmt({
    this.ccy,
    this.amt,
  });

  factory InstdAmt.fromJson(Map<String, dynamic> json) => InstdAmt(
        ccy: json["Ccy"],
        amt: json["Amt"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "Ccy": ccy,
        "Amt": amt,
      };
}

class MndtRltdInf {
  Tp? tp;

  MndtRltdInf({
    this.tp,
  });

  factory MndtRltdInf.fromJson(Map<String, dynamic> json) => MndtRltdInf(
        tp: json["Tp"] == null ? null : Tp.fromJson(json["Tp"]),
      );

  Map<String, dynamic> toJson() => {
        "Tp": tp?.toJson(),
      };
}

class Tp {
  ClrSysId? lclInstrm;

  Tp({
    this.lclInstrm,
  });

  factory Tp.fromJson(Map<String, dynamic> json) => Tp(
        lclInstrm: json["LclInstrm"] == null
            ? null
            : ClrSysId.fromJson(json["LclInstrm"]),
      );

  Map<String, dynamic> toJson() => {
        "LclInstrm": lclInstrm?.toJson(),
      };
}
