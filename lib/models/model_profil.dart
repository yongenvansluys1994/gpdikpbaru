// To parse this JSON data, do
//
//     final modelProfil = modelProfilFromJson(jsonString);

import 'dart:convert';

ModelProfil modelProfilFromJson(String str) =>
    ModelProfil.fromJson(json.decode(str));

String modelProfilToJson(ModelProfil data) => json.encode(data.toJson());

class ModelProfil {
  ModelProfil({
    required this.idUser,
    required this.nama,
    required this.username,
    required this.level,
  });

  String idUser;
  String nama;
  String username;
  String level;

  factory ModelProfil.fromJson(Map<String, dynamic> json) => ModelProfil(
        idUser: json["id_user"],
        nama: json["nama"],
        username: json["username"],
        level: json["level"],
      );

  Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "nama": nama,
        "username": username,
        "level": level,
      };
}
