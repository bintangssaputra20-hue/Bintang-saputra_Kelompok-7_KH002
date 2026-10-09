import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'widgets/app_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Profile Card',
      theme: AppTheme.lightTheme,
      home: const ProfileScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Definisikan variabel d dan perhitungannya di sini (paling atas dalam build)
    const double d = 1;
    final double paddingCard = 16 + d;        
    final double roundedCard = 8 + d;         
    final double tinggiTombol = 40 + d;       // <--- Variabel didefinisikan di sini
    final double roundedTombol = 4 + d;       // <--- Variabel didefinisikan di sini
    final double ukuranAvatar = 40 + (2 * d); 
    final double jarakNamaNim = 8 + d;        

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Mahasiswa'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(roundedCard),
            ),
            child: Padding(
              padding: EdgeInsets.all(paddingCard),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: ukuranAvatar / 2,
                    backgroundImage: const NetworkImage(
                      'https://avatars.githubusercontent.com/u/9919335?v=4', 
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('Bintang Saputra'),
                  SizedBox(height: jarakNamaNim),
                  const Text('NIM: 20240801231'),
                  const SizedBox(height: 8),
                  const Text('Program Studi: Teknik Informatika'),
                  const SizedBox(height: 12),
                  const Text(
                    'Halo! Saya Bintang Saputra, mahasiswa Teknik Informatika yang sedang belajar pengembangan aplikasi menggunakan Flutter.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  
                  // 2. Pemanggilan AppButton sekarang bisa membaca tinggiTombol & roundedTombol
                  AppButton(
                    label: 'Kunjungi GitHub Saya',
                    icon: Icons.code,
                    url: 'https://github.com/bintangssaputra20-hue',
                    height: tinggiTombol,
                    borderRadius: roundedTombol,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}