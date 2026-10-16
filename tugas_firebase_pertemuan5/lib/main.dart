import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pencatatan Stok Barang',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const FormStokBarangPage(),
    );
  }
}

class FormStokBarangPage extends StatefulWidget {
  const FormStokBarangPage({super.key});

  @override
  State<FormStokBarangPage> createState() => _FormStokBarangPageState();
}

class _FormStokBarangPageState extends State<FormStokBarangPage> {
  final _formKey = GlobalKey<FormState>();

  // Controller untuk setiap input field
  final TextEditingController _namaBarangController = TextEditingController();
  final TextEditingController _tglMasukController = TextEditingController();
  final TextEditingController _tglKeluarController = TextEditingController();
  final TextEditingController _kodeBarangController = TextEditingController();
  final TextEditingController _jumlahStokController = TextEditingController();

  bool _isLoading = false;

  // Fungsi untuk menyimpan data ke Firebase Cloud Firestore
  Future<void> _simpanBarang() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Konversi nilai String dari input menjadi int/number
      int kodeBarangInt = int.parse(_kodeBarangController.text.trim());
      int jumlahStokInt = int.parse(_jumlahStokController.text.trim());

      // Simpan ke Firestore collection 'stok_barang'
      await FirebaseFirestore.instance.collection('stok_barang').add({
        'nama_barang': _namaBarangController.text.trim(),
        'tanggal_masuk': _tglMasukController.text.trim(),
        'tanggal_keluar': _tglKeluarController.text.trim(),
        'kode_barang': kodeBarangInt, // Tipe Integer/Number
        'jumlah_stok': jumlahStokInt, // Tipe Integer/Number
        'waktu': FieldValue.serverTimestamp(), // Timestamp dari server Firebase
      });

      if (!mounted) return;

      // Notifikasi Berhasil
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Berhasil menyimpan data stok barang!'),
          backgroundColor: Colors.green,
        ),
      );

      // Kosongkan seluruh field input setelah sukses
      _namaBarangController.clear();
      _tglMasukController.clear();
      _tglKeluarController.clear();
      _kodeBarangController.clear();
      _jumlahStokController.clear();
    } catch (e) {
      if (!mounted) return;

      // Notifikasi Gagal/Error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menyimpan data: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _namaBarangController.dispose();
    _tglMasukController.dispose();
    _tglKeluarController.dispose();
    _kodeBarangController.dispose();
    _jumlahStokController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Stok Barang - Bintang Saputra'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Nama Barang
              TextFormField(
                controller: _namaBarangController,
                decoration: const InputDecoration(
                  labelText: 'Nama Barang (Inisial Nama Depan)',
                  hintText: 'Contoh: Bintang - Sepatu Running',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.inventory_2),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama barang wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // 2. Tanggal Masuk
              TextFormField(
                controller: _tglMasukController,
                decoration: const InputDecoration(
                  labelText: 'Tanggal Masuk Barang',
                  hintText: 'YYYY-MM-DD (Contoh: 2026-10-16)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Tanggal masuk wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // 3. Tanggal Keluar
              TextFormField(
                controller: _tglKeluarController,
                decoration: const InputDecoration(
                  labelText: 'Tanggal Keluar Barang',
                  hintText: 'YYYY-MM-DD (Contoh: 2026-10-20)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.event_available),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Tanggal keluar wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // 4. Kode Barang (Keyboard Numerik & Validasi NIM Ganjil "231")
              TextFormField(
                controller: _kodeBarangController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Kode Barang (Min 6 Angka, Akhiran 231)',
                  hintText: 'Contoh: 100231',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.qr_code),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Kode barang wajib diisi';
                  }
                  if (value.length < 6) {
                    return 'Kode barang minimal 6 digit angka';
                  }
                  // Karena NIM 20240801231 Ganjil, 3 angka terakhir harus "231"
                  if (!value.endsWith('231')) {
                    return '3 angka terakhir harus sesuai NIM Ganjil (231)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // 5. Jumlah Stok (Keyboard Numerik & Tidak Boleh Negatif)
              TextFormField(
                controller: _jumlahStokController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Jumlah Stok',
                  hintText: 'Masukkan angka (misal: 50)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.numbers),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Jumlah stok wajib diisi';
                  }
                  final stok = int.tryParse(value);
                  if (stok == null) {
                    return 'Jumlah stok harus berupa angka';
                  }
                  if (stok < 0) {
                    return 'Jumlah stok tidak boleh negatif';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Tombol Simpan Data
              ElevatedButton(
                onPressed: _isLoading ? null : _simpanBarang,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Simpan Barang'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}