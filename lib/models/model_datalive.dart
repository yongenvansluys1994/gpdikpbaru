// To parse this JSON data, do
//
//     final modeldataLive = modeldataLiveFromJson(jsonString);

import 'dart:convert';

ModeldataLive modeldataLiveFromJson(String str) =>
    ModeldataLive.fromJson(json.decode(str));

String modeldataLiveToJson(ModeldataLive data) => json.encode(data.toJson());

class ModeldataLive {
  String judulLive;
  String urlLive;
  DateTime createdAt;
  DateTime updatedAt;
  String idLive;

  ModeldataLive({
    required this.judulLive,
    required this.urlLive,
    required this.createdAt,
    required this.updatedAt,
    required this.idLive,
  });

  factory ModeldataLive.fromJson(Map<String, dynamic> json) => ModeldataLive(
        judulLive: json["judul_live"],
        urlLive: json["url_live"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        idLive: json["id_live"],
      );

  Map<String, dynamic> toJson() => {
        "judul_live": judulLive,
        "url_live": urlLive,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "id_live": idLive,
      };
}
