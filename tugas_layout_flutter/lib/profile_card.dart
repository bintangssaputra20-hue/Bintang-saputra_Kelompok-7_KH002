import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String nama;
  final String nim;
  final String hobi;
  final int skorAktivitas;

  const ProfileCard({
    Key? key,
    required this.nama,
    required this.nim,
    required this.hobi,
    required this.skorAktivitas,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335.0, // Hasil perhitungan: 320.0 + (3 * 5)
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13.5), // Hasil perhitungan: 12.0 + (1 * 1.5)
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bagian Header Kartu (Row)
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.teal, width: 1.5),
                ),
                padding: const EdgeInsets.all(8.0),
                child: const FlutterLogo(
                  size: 62.0, // Hasil perhitungan: 60.0 + (1 * 2)
                ),
              ),
              const SizedBox(width: 16.0), // Hasil perhitungan: 15.0 + 1
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Kartu Praktikan",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    "Bintang Saputra",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: Divider(thickness: 1.5),
          ),
          // Bagian Detail Identitas (Column)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("NIM : $nim", style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 6.0),
              Text("Hobi : $hobi", style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 6.0),
              Text("Skor Aktivitas : $skorAktivitas", style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }
}