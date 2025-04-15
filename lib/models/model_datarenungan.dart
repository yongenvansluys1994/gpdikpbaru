// To parse this JSON data, do
//
//     final modeldataRenungan = modeldataRenunganFromJson(jsonString);

import 'dart:convert';

ModeldataRenungan modeldataRenunganFromJson(String str) =>
    ModeldataRenungan.fromJson(json.decode(str));

String modeldataRenunganToJson(ModeldataRenungan data) =>
    json.encode(data.toJson());

class ModeldataRenungan {
  String idRenungan;
  String jenis;
  String judulRenungan;
  String isiRenungan;
  String gmbrRenungan;
  String urlGambar;
  DateTime createdAt;

  ModeldataRenungan({
    required this.idRenungan,
    required this.jenis,
    required this.judulRenungan,
    required this.isiRenungan,
    required this.gmbrRenungan,
    required this.urlGambar,
    required this.createdAt,
  });

  factory ModeldataRenungan.fromJson(Map<String, dynamic> json) =>
      ModeldataRenungan(
        idRenungan: json["id_renungan"],
        jenis: json["jenis"],
        judulRenungan: json["judul_renungan"],
        isiRenungan: json["isi_renungan"],
        gmbrRenungan: json["gmbr_renungan"],
        urlGambar: json["url_gambar"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id_renungan": idRenungan,
        "jenis": jenis,
        "judul_renungan": judulRenungan,
        "isi_renungan": isiRenungan,
        "gmbr_renungan": gmbrRenungan,
        "url_gambar": urlGambar,
        "created_at": createdAt.toIso8601String(),
      };
}
