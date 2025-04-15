// To parse this JSON data, do
//
//     final modelJadwal = modelJadwalFromJson(jsonString);

import 'dart:convert';

ModelJadwal modelJadwalFromJson(String str) =>
    ModelJadwal.fromJson(json.decode(str));

String modelJadwalToJson(ModelJadwal data) => json.encode(data.toJson());

class ModelJadwal {
  int id;
  String kategori;
  String lokasi;
  String alamat;
  String jam;
  DateTime createdAt;
  DateTime updatedAt;
  String idJadwal;
  String hambaTuhan;
  String wl;
  String singer;
  String pmusik;
  String pkolekte;
  String ptamu;
  String penyambutan;
  String persiapanAcara;
  String doaPelayan;
  String praise;
  String doaPembukaan;
  String pujian;
  String doaFirman;
  String firmanTuhan;
  String phBerdoa;
  String doaBerkat;
  String kesaksian;
  String bacaAyat;
  String persembahan;
  String jumJemaat;
  String jumBaru;
  String kesaksian2;
  String evaluasi;
  DateTime tanggal;
  String tanggal2;
  String hari;
  String tanggalLengkap;

  ModelJadwal({
    required this.id,
    required this.kategori,
    required this.lokasi,
    required this.alamat,
    required this.jam,
    required this.createdAt,
    required this.updatedAt,
    required this.idJadwal,
    required this.hambaTuhan,
    required this.wl,
    required this.singer,
    required this.pmusik,
    required this.pkolekte,
    required this.ptamu,
    required this.penyambutan,
    required this.persiapanAcara,
    required this.doaPelayan,
    required this.praise,
    required this.doaPembukaan,
    required this.pujian,
    required this.doaFirman,
    required this.firmanTuhan,
    required this.phBerdoa,
    required this.doaBerkat,
    required this.kesaksian,
    required this.bacaAyat,
    required this.persembahan,
    required this.jumJemaat,
    required this.jumBaru,
    required this.kesaksian2,
    required this.evaluasi,
    required this.tanggal,
    required this.tanggal2,
    required this.hari,
    required this.tanggalLengkap,
  });

  factory ModelJadwal.fromJson(Map<String, dynamic> json) => ModelJadwal(
        id: json["id"],
        kategori: json["kategori"],
        lokasi: json["lokasi"],
        alamat: json["alamat"],
        jam: json["jam"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        idJadwal: json["id_jadwal"],
        hambaTuhan: json["hamba_tuhan"],
        wl: json["wl"],
        singer: json["singer"],
        pmusik: json["pmusik"],
        pkolekte: json["pkolekte"],
        ptamu: json["ptamu"],
        penyambutan: json["penyambutan"],
        persiapanAcara: json["persiapan_acara"],
        doaPelayan: json["doa_pelayan"],
        praise: json["praise"],
        doaPembukaan: json["doa_pembukaan"],
        pujian: json["pujian"],
        doaFirman: json["doa_firman"],
        firmanTuhan: json["firman_tuhan"],
        phBerdoa: json["ph_berdoa"],
        doaBerkat: json["doa_berkat"],
        kesaksian: json["kesaksian"],
        bacaAyat: json["baca_ayat"],
        persembahan: json["persembahan"],
        jumJemaat: json["jum_jemaat"],
        jumBaru: json["jum_baru"],
        kesaksian2: json["kesaksian_2"],
        evaluasi: json["evaluasi"],
        tanggal: DateTime.parse(json["tanggal"]),
        tanggal2: json["tanggal2"],
        hari: json["hari"],
        tanggalLengkap: json["tanggal_lengkap"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kategori": kategori,
        "lokasi": lokasi,
        "alamat": alamat,
        "jam": jam,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "id_jadwal": idJadwal,
        "hamba_tuhan": hambaTuhan,
        "wl": wl,
        "singer": singer,
        "pmusik": pmusik,
        "pkolekte": pkolekte,
        "ptamu": ptamu,
        "penyambutan": penyambutan,
        "persiapan_acara": persiapanAcara,
        "doa_pelayan": doaPelayan,
        "praise": praise,
        "doa_pembukaan": doaPembukaan,
        "pujian": pujian,
        "doa_firman": doaFirman,
        "firman_tuhan": firmanTuhan,
        "ph_berdoa": phBerdoa,
        "doa_berkat": doaBerkat,
        "kesaksian": kesaksian,
        "baca_ayat": bacaAyat,
        "persembahan": persembahan,
        "jum_jemaat": jumJemaat,
        "jum_baru": jumBaru,
        "kesaksian_2": kesaksian2,
        "evaluasi": evaluasi,
        "tanggal": tanggal.toIso8601String(),
        "tanggal2": tanggal2,
        "hari": hari,
        "tanggal_lengkap": tanggalLengkap,
      };
}
