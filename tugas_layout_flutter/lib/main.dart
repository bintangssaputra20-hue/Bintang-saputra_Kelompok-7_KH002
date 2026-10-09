import 'package:flutter/material.dart';

import 'profile_card.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas Layout Flutter',
      theme: ThemeData(
        // Karena digit terakhir NIM (1) adalah ganjil, gunakan Colors.tealAccent[100]
        scaffoldBackgroundColor: Colors.tealAccent[100],
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Praktikan - Bintang Saputra'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: ProfileCard(
          nama: "Bintang Saputra",
          nim: "20240801231",
          hobi: "Bermain Volly Dan Bermain Game",
          skorAktivitas: 81, // Hasil perhitungan: 31 + 50
        ),
      ),
    );
  }
}