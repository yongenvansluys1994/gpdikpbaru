// To parse this JSON data, do
//
//     final modelDataGame = modelDataGameFromJson(jsonString);

import 'dart:convert';

ModelDataGame modelDataGameFromJson(String str) =>
    ModelDataGame.fromJson(json.decode(str));

String modelDataGameToJson(ModelDataGame data) => json.encode(data.toJson());

class ModelDataGame {
  int id;
  String nmGame;
  String url;
  String urlGambar;
  DateTime createdAt;
  DateTime updatedAt;

  ModelDataGame({
    required this.id,
    required this.nmGame,
    required this.url,
    required this.urlGambar,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ModelDataGame.fromJson(Map<String, dynamic> json) => ModelDataGame(
        id: json["id"],
        nmGame: json["nm_game"],
        url: json["url"],
        urlGambar: json["url_gambar"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nm_game": nmGame,
        "url": url,
        "url_gambar": urlGambar,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
