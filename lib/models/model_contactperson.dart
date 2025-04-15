// To parse this JSON data, do
//
//     final modelContactPerson = modelContactPersonFromJson(jsonString);

import 'dart:convert';

ModelContactPerson modelContactPersonFromJson(String str) =>
    ModelContactPerson.fromJson(json.decode(str));

String modelContactPersonToJson(ModelContactPerson data) =>
    json.encode(data.toJson());

class ModelContactPerson {
  int id;
  String nama;
  String noHp;
  String alamat;
  String ket;
  String gmbrContactperson;
  String urlGambar;
  DateTime createdAt;
  DateTime updatedAt;

  ModelContactPerson({
    required this.id,
    required this.nama,
    required this.noHp,
    required this.alamat,
    required this.ket,
    required this.gmbrContactperson,
    required this.urlGambar,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ModelContactPerson.fromJson(Map<String, dynamic> json) =>
      ModelContactPerson(
        id: json["id"],
        nama: json["nama"],
        noHp: json["no_hp"],
        alamat: json["alamat"],
        ket: json["ket"],
        gmbrContactperson: json["gmbr_contactperson"],
        urlGambar: json["url_gambar"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "no_hp": noHp,
        "alamat": alamat,
        "ket": ket,
        "gmbr_contactperson": gmbrContactperson,
        "url_gambar": urlGambar,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
