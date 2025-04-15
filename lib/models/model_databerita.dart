// To parse this JSON data, do
//
//     final modeldataBerita = modeldataBeritaFromJson(jsonString);

import 'dart:convert';

ModeldataBerita modeldataBeritaFromJson(String str) =>
    ModeldataBerita.fromJson(json.decode(str));

String modeldataBeritaToJson(ModeldataBerita data) =>
    json.encode(data.toJson());

class ModeldataBerita {
  String idKegiatan;
  String judulKegiatan;
  String isiKegiatan;
  String gmbrKegiatan;
  String urlGambar;
  DateTime createdAt;

  ModeldataBerita({
    required this.idKegiatan,
    required this.judulKegiatan,
    required this.isiKegiatan,
    required this.gmbrKegiatan,
    required this.urlGambar,
    required this.createdAt,
  });

  factory ModeldataBerita.fromJson(Map<String, dynamic> json) =>
      ModeldataBerita(
        idKegiatan: json["id_kegiatan"],
        judulKegiatan: json["judul_kegiatan"],
        isiKegiatan: json["isi_kegiatan"],
        gmbrKegiatan: json["gmbr_kegiatan"],
        urlGambar: json["url_gambar"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id_kegiatan": idKegiatan,
        "judul_kegiatan": judulKegiatan,
        "isi_kegiatan": isiKegiatan,
        "gmbr_kegiatan": gmbrKegiatan,
        "url_gambar": urlGambar,
        "created_at": createdAt.toIso8601String(),
      };
}
