import 'dart:convert';

PushMessage pushMessageFromJson(String str) =>
    PushMessage.fromJson(json.decode(str));

String pushMessageToJson(PushMessage data) => json.encode(data.toJson());

class PushMessage {
  String messageId;
  String title;
  String body;
  DateTime sentDate;
  dynamic data;
  String? imageUrl;
  bool? status;

  PushMessage({
    required this.messageId,
    required this.title,
    required this.body,
    required this.sentDate,
    this.data,
    this.imageUrl,
    this.status,
  });

  @override
  String toString() {
    return '''
      --- PushMessage -
      --- id: $messageId
      --- messageId: $messageId
      --- title: $title
      --- body: $body
      --- sentDate: $sentDate
      --- data: $data
      --- imageUrl: $imageUrl
      --- status: $status
    ''';
  }

  factory PushMessage.fromJson(Map<String, dynamic> json) => PushMessage(
        messageId: json["message_id"],
        title: json["title"],
        body: json["body"],
        sentDate: DateTime.parse(json["sent_date"]),
        data: json["data"],
        imageUrl: json["image_url"],
        status: json['status'] ?? true,
      );

  Map<String, dynamic> toJson() => {
        "message_id": messageId,
        "title": title,
        "body": body,
        "sent_date": sentDate.toIso8601String(),
        "data": data,
        "image_url": imageUrl,
        'status': status,
      };
}
