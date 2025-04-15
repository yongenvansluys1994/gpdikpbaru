import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/controller/home_controller2.dart';
import 'package:gpdikpbaru/controller/profil/p_iman_controller.dart';
import 'package:gpdikpbaru/custom_widget/custom_appbar.dart';
import 'package:gpdikpbaru/routes/routes.dart';
import 'package:gpdikpbaru/widgets/logger.dart';
import 'package:http/http.dart' as http;

import 'package:sizer/sizer.dart';

class MyProfil extends StatefulWidget {
  @override
  State<MyProfil> createState() => _MyProfilState();
}

class _MyProfilState extends State<MyProfil> {
  home_controller2 session_C = Get.find();
  p_iman_controller p_iman_c = Get.find();
  int likes = 0;
  StreamSubscription<DocumentSnapshot>? _likesSubscription;
  List<Map<String, dynamic>> suggestions = []; // Menyimpan hasil pencarian
  bool isLoading = false; // Menampilkan indikator loading
  Timer? _debounce;

  // Fungsi untuk mencari teman
  Future<void> searchFriends(String query) async {
    // Batalkan debounce sebelumnya jika ada
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // Set debounce untuk menunda eksekusi fungsi
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      if (query.isEmpty) {
        setState(() {
          suggestions = []; // Kosongkan suggestions jika input kosong
        });
        return;
      }

      setState(() {
        isLoading = true;
      });

      try {
        // Ganti URL dengan endpoint Laravel Anda
        final response = await http.get(
          Uri.parse(
              'https://yongen-bisa.com/backend_gpdi/api/auth/cariuser/search?name=$query'),
        );

        if (response.statusCode == 200) {
          final List<dynamic> data = json.decode(response.body);
          setState(() {
            suggestions = data.map((item) {
              return {
                'id': item['id'],
                'username': item['username'],
                'name': item['name'],
                'profile_picture':
                    item['profile_picture'], // Tambahkan jika ada
              };
            }).toList();
          });
        } else {
          print('Error: ${response.statusCode}');
        }
      } catch (e) {
        print('Error fetching suggestions: $e');
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // Mulai stream untuk memantau likes
    startLikesStream();
  }

  @override
  void dispose() {
    // Batalkan subscription saat widget di-dispose untuk mencegah memory leak
    _debounce?.cancel(); // Batalkan debounce jika masih aktif
    _likesSubscription?.cancel();
    super.dispose();
  }

  void startLikesStream() {
    // Ambil username dari session atau tempat penyimpanan user saat ini
    final String username = session_C.items[0].username;

    // Set up stream ke document user
    _likesSubscription = FirebaseFirestore.instance
        .collection('data_user')
        .doc(username)
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        // Update state with the latest likes count
        setState(() {
          likes = snapshot.get('likes') ?? 0;
        });
      } else {
        // Handle case where document doesn't exist
        setState(() {
          likes = 0;
        });
      }
    }, onError: (error) {
      print("Error listening to likes updates: $error");
    });
  }

  Future<void> incrementLikes() async {
    final String username = session_C.items[0].username;
    try {
      // Referensi ke dokumen user
      DocumentReference userRef =
          FirebaseFirestore.instance.collection('data_user').doc(username);

      // Gunakan transaction untuk atomic update (mencegah race condition)
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        // Ambil snapshot terbaru
        DocumentSnapshot snapshot = await transaction.get(userRef);

        // Cek apakah dokumen ada
        if (!snapshot.exists) {
          // Jika tidak ada, buat dokumen baru dengan likes = 1
          transaction.set(userRef, {'likes': 1});
        } else {
          // Jika dokumen ada, cek apakah field 'likes' ada
          if (snapshot.data() != null &&
              (snapshot.data() as Map<String, dynamic>).containsKey('likes')) {
            // Increment nilai likes
            int currentLikes = snapshot.get('likes') ?? 0;
            transaction.update(userRef, {'likes': currentLikes + 1});
          } else {
            // Jika field 'likes' tidak ada, tambahkan field 'likes' dengan nilai 1
            transaction.update(userRef, {'likes': 1});
          }
        }
      });

      // Optional: Tampilkan pesan sukses
      EasyLoading.showSuccess('Berhasil Memberi Likes');
    } catch (e) {
      // Handle error
      print('Error incrementing likes: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = session_C.items[0];
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Column(
          children: [
            TextField(
              onChanged: (value) {
                searchFriends(value);
              },
              decoration: InputDecoration(
                hintText: 'Cari Profil Teman...',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 12.sp, // Ukuran teks lebih kecil
                ),
                filled: true, // Memberikan background
                fillColor: Colors.white, // Warna background
                isDense: true, // Mengurangi tinggi TextField
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(10), // Membuat border melengkung
                  borderSide: BorderSide(
                    color: Colors.grey, // Warna border
                    width: 1.0, // Ketebalan border
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.grey, // Warna border saat tidak fokus
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.blue, // Warna border saat fokus
                    width: 1.5,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 2.h, // Padding atas dan bawah (sedikit lebih besar)
                  horizontal: 10, // Padding kiri dan kanan
                ),
              ),
              style: TextStyle(
                color: Colors.black,
                fontSize: 12.sp, // Ukuran teks lebih kecil
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // Header with gradient background
                Container(
                  height: 21.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(255, 133, 186, 219),
                        Color.fromARGB(255, 133, 219, 208),
                      ],
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          // Top navigation
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [],
                          ),

                          // Wave pattern
                          SizedBox(
                            height: 50,
                            child: CustomPaint(
                              size: Size(MediaQuery.of(context).size.width, 50),
                              painter: WavePainter(),
                            ),
                          ),

                          // Profile picture that extends below the header
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),

                // Negative margin to position profile picture and info
                Transform.translate(
                  offset: Offset(0, -60),
                  child: Column(
                    children: [
                      // Profile picture
                      Container(
                        width: 32.w,
                        height: 15.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF3B82F6),
                          border: Border.all(color: Colors.white, width: 4),
                          image: DecorationImage(
                            image: session_C.fotoprofil != ""
                                ? NetworkImage('${session_C.fotoprofil}')
                                    as ImageProvider
                                : AssetImage('assets/images/icon-user.png')
                                    as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      SizedBox(height: 15),

                      // Profile name and location
                      Text(
                        '${user.nama}',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Obx(() => Container(
                          width: 16.w,
                          height: 7.h,
                          child: session_C.lencana == ""
                              ? Image.asset("assets/badge/2.png")
                              : Image.asset(
                                  "assets/badge/${session_C.lencana}"))),

                      SizedBox(height: 20),

                      // Activity card
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.h),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            // Main activity card
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 10,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Activities title with total distance
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              incrementLikes();
                                            },
                                            child: ActivityStat(
                                              icon: Icons.thumb_up_outlined,
                                              value: '${likes}',
                                              unit: ' likes',
                                              label: 'Jumlah Suka',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 25),

                                  // Activity stats row 1
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Jumlah Koleksi Lencana",
                                            style: TextStyle(fontSize: 12.sp),
                                          ),
                                          SizedBox(height: 0.5.h),
                                          Obx(() {
                                            // Get the list of badges
                                            List<Map<String, String>> badges =
                                                p_iman_c.getBadges();

                                            if (badges.isEmpty) {
                                              return Center(
                                                child:
                                                    Text('No badges available'),
                                              );
                                            }

                                            // Wrap ListView.builder with a SizedBox or Container to provide bounded width
                                            return SizedBox(
                                              width: 75.w, // Lebar layar
                                              height:
                                                  100, // Tinggi untuk item horizontal
                                              child: ListView.builder(
                                                scrollDirection: Axis
                                                    .horizontal, // Scroll secara horizontal
                                                itemCount: badges.length,
                                                itemBuilder: (context, index) {
                                                  final badge = badges[index];
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal:
                                                            8.0), // Jarak antar item
                                                    child: Column(
                                                      children: [
                                                        Image.asset(
                                                          badge[
                                                              'badge']!, // Menampilkan gambar badge
                                                          width: 13
                                                              .w, // Lebar gambar
                                                          height: 9
                                                              .h, // Tinggi gambar
                                                          fit: BoxFit.contain,
                                                        ),
                                                        SizedBox(height: 5),
                                                        Text(
                                                          badge[
                                                              'name']!, // Menampilkan nama task
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            );
                                          }),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // "No goal" circle
                            Positioned(
                              right: -10,
                              top: -30,
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color.fromARGB(255, 133, 186, 219),
                                      Color.fromARGB(255, 133, 219, 208),
                                    ],
                                  ),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${double.parse(p_iman_c.sumpoin.toStringAsFixed(3))}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Poin Iman',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.h),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Card(
                                  margin: EdgeInsets.symmetric(vertical: 1),
                                  child: InkWell(
                                    child: ListTile(
                                        title: Text('Edit Profil'),
                                        dense: true,
                                        visualDensity:
                                            VisualDensity(vertical: -1),
                                        trailing:
                                            Icon(Icons.arrow_forward_ios)),
                                    onTap: () {
                                      Get.toNamed(GetRoutes.editprofil);
                                    },
                                  )),
                              Card(
                                  margin: EdgeInsets.symmetric(vertical: 1),
                                  child: InkWell(
                                    child: ListTile(
                                        title: Text('Ganti Password'),
                                        dense: true,
                                        visualDensity:
                                            VisualDensity(vertical: -1),
                                        trailing:
                                            Icon(Icons.arrow_forward_ios)),
                                    onTap: () {},
                                  )),
                              SizedBox(height: 2.h),
                              GestureDetector(
                                child: Card(
                                    margin: EdgeInsets.symmetric(vertical: 1),
                                    child: ListTile(
                                        title: Text('Perjalanan Iman'),
                                        dense: true,
                                        visualDensity:
                                            VisualDensity(vertical: -1),
                                        trailing:
                                            Icon(Icons.arrow_forward_ios))),
                                onTap: () {
                                  Get.toNamed(GetRoutes.perjalanan_iman);
                                },
                              ),
                              Card(
                                  margin: EdgeInsets.symmetric(vertical: 1),
                                  child: ListTile(
                                      title: Text('Hubungi Kami'),
                                      dense: true,
                                      visualDensity:
                                          VisualDensity(vertical: -1),
                                      trailing: Icon(Icons.arrow_forward_ios))),
                              Card(
                                  margin: EdgeInsets.symmetric(vertical: 1),
                                  child: ListTile(
                                      title: Text('Tentang Aplikasi'),
                                      dense: true,
                                      visualDensity:
                                          VisualDensity(vertical: -1),
                                      trailing: Icon(Icons.arrow_forward_ios))),
                              GestureDetector(
                                onTap: () async {
                                  await session_C.FetchlaunchUrl();
                                },
                                child: Card(
                                    margin: EdgeInsets.symmetric(vertical: 1),
                                    child: ListTile(
                                        title: Text('Hapus Akun'),
                                        dense: true,
                                        visualDensity:
                                            VisualDensity(vertical: -1),
                                        trailing:
                                            Icon(Icons.arrow_forward_ios))),
                              ),
                              SizedBox(height: 2.h),
                              SizedBox(
                                width: 85.w, // <-- Your width
                                height: 40, // <-- Your height
                                child: TextButton(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    child: Text('Logout',
                                        style: TextStyle(
                                            color: Colors.teal,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  style: TextButton.styleFrom(
                                    primary: Colors.teal,
                                    onSurface: Colors.yellow,
                                    side: BorderSide(
                                        color: Colors.teal, width: 1),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25))),
                                  ),
                                  onPressed: () {
                                    session_C.logout();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Dropdown suggestions
          Positioned(
            top: kToolbarHeight + 2.5.h, // Posisi di bawah AppBar
            left: 10,
            right: 10,
            child: suggestions.isNotEmpty
                ? Container(
                    height: (suggestions.length * 7.h)
                        .clamp(0, 25.h), // Tinggi sesuai jumlah data
                    color: Colors.white,
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: suggestions.length,
                      itemBuilder: (context, index) {
                        final suggestion = suggestions[index];
                        return GestureDetector(
                          onTap: () {
                            // Navigasi ke halaman profil_user dan kirimkan data
                            Get.toNamed(
                              GetRoutes.profil_user,
                              arguments: {
                                'id': suggestion['id'],
                                'name': suggestion['name'],
                                'username': suggestion['username'],
                              },
                            );

                            // Reset pencarian dan suggestions
                            setState(() {
                              suggestions = []; // Kosongkan daftar suggestions
                            });

                            // Dismiss keyboard jika masih terbuka
                            FocusScope.of(context).unfocus();
                          },
                          child: ListTile(
                            dense: true,
                            visualDensity: VisualDensity(
                                vertical:
                                    -4), // Mengurangi jarak vertikal antar ListTile
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 0, // Padding atas dan bawah
                              horizontal: 10, // Padding kiri dan kanan
                            ),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                suggestion['profile_picture'] ??
                                    'https://via.placeholder.com/150',
                              ),
                            ),
                            title: Text(suggestion['name']),
                            subtitle: Text(suggestion['username']),
                          ),
                        );
                      },
                    ),
                  )
                : SizedBox(), // Tidak tampil jika suggestions kosong
          ),
        ],
      ),
    );
  }
}

// Custom widget for activity stats with icon
class ActivityStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String unit;
  final String label;

  ActivityStat({
    Key? key,
    required this.icon,
    required this.value,
    required this.unit,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.black),
        ),
        SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: value,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: unit,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Custom widget for activity stats without icon
class ActivityValueOnly extends StatelessWidget {
  final String value;
  final String label;

  ActivityValueOnly({
    Key? key,
    required this.value,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

// Custom painter for wave pattern in header
class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path();

    // Draw wave pattern
    path.moveTo(0, size.height * 0.5);

    // First wave
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.25,
        size.width * 0.5, size.height * 0.5);

    // Second wave
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.75, size.width, size.height * 0.5);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
