import 'dart:convert';

RefreshSession refreshSessionFromJson(String str) =>
    RefreshSession.fromJson(json.decode(str));

String refreshSessionToJson(RefreshSession data) => json.encode(data.toJson());

class RefreshSession {
  String? grantType;
  String? refreshToken;
  String? clientId;
  String? secret;

  RefreshSession({
    this.grantType,
    this.refreshToken,
    this.clientId,
    this.secret,
  });

  factory RefreshSession.fromJson(Map<String, dynamic> json) => RefreshSession(
        grantType: json["grant_type"],
        refreshToken: json["refresh_token"],
        clientId: json["client_id"],
        secret: json["secret"],
      );

  Map<String, dynamic> toJson() => {
        "grant_type": grantType,
        "refresh_token": refreshToken,
        "client_id": clientId,
        "secret": secret,
      };
}
