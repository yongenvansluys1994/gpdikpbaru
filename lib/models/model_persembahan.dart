import 'package:cloud_firestore/cloud_firestore.dart';

class ModelPersembahan {
  String? bank;
  String? bukti_bayar;
  Timestamp? createdAt;
  String? nama;
  int? nominal;
  String? postID;
  String? status;
  String? user;
  String? user_nama;

  ModelPersembahan({
    this.bank,
    this.bukti_bayar,
    this.createdAt,
    this.nama,
    this.nominal,
    this.postID,
    this.status,
    this.user,
    this.user_nama,
  });

  factory ModelPersembahan.fromMap(DocumentSnapshot data) {
    final map =
        data.data() as Map<String, dynamic>?; // Pastikan data adalah Map

    if (map == null) {
      throw Exception("DocumentSnapshot does not contain valid data");
    }

    return ModelPersembahan(
      bank: map["bank"] ?? "", // Jika null, isi dengan string kosong
      bukti_bayar: map["bukti_bayar"] ?? "",
      createdAt:
          map["createdAt"] != null ? map["createdAt"] as Timestamp : null,
      nama: map["nama"] ?? "",
      nominal: map["nominal"] != null ? map["nominal"] as int : 0,
      postID: data.id, // ID dokumen diambil langsung dari DocumentSnapshot
      status: map["status"] ?? "0",
      user: map["user"] ?? "",
      user_nama: map["user_nama"] ?? "",
    );
  }
}
