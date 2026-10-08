import 'package:flutter/material.dart';

class GantiKataSandiPage extends StatefulWidget {
  const GantiKataSandiPage({super.key});

  @override
  State<GantiKataSandiPage> createState() => _GantiKataSandiPageState();
}

class _GantiKataSandiPageState extends State<GantiKataSandiPage> {
  // Controller untuk mengambil teks input
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Status visibilitas teks sandi
  bool _obscureOld = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  // Variabel validasi sandi baru
  bool _hasMinLength = false;
  bool _hasComplexChar = false;
  bool _isMatch = false;

  @override
  void initState() {
    super.initState();
    _newPasswordController.addListener(_validatePassword);
    _confirmPasswordController.addListener(_validatePassword);
  }

  void _validatePassword() {
    final newPass = _newPasswordController.text;
    final confirmPass = _confirmPasswordController.text;

    setState(() {
      _hasMinLength = newPass.length >= 8;
      _hasComplexChar = newPass.contains(RegExp(r'[A-Z]')) &&
          newPass.contains(RegExp(r'[0-9]')) &&
          newPass.isNotEmpty;
      _isMatch = newPass.isNotEmpty && newPass == confirmPass;
    });
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Menghitung skor kekuatan sandi (0.0 - 1.0)
  double get _passwordStrength {
    int score = 0;
    if (_hasMinLength) score++;
    if (_hasComplexChar) score++;
    if (_newPasswordController.text.length >= 12) score++;
    if (_isMatch) score++;
    return score / 4.0;
  }

  String get _strengthText {
    final strength = _passwordStrength;
    if (strength <= 0.25) return 'Lemah';
    if (strength <= 0.5) return 'Cukup';
    if (strength <= 0.75) return 'Baik';
    return 'Kuat';
  }

  Color get _strengthColor {
    final strength = _passwordStrength;
    if (strength <= 0.25) return Colors.red;
    if (strength <= 0.5) return Colors.orange;
    if (strength <= 0.75) return Colors.blue;
    return Colors.green;
  }

  void _savePassword() {
    if (_oldPasswordController.text.isEmpty) {
      _showSnackbar('Kata sandi lama harus diisi!');
      return;
    }
    if (!_hasMinLength || !_hasComplexChar) {
      _showSnackbar('Kata sandi baru belum memenuhi syarat keamanan!');
      return;
    }
    if (!_isMatch) {
      _showSnackbar('Konfirmasi kata sandi tidak cocok!');
      return;
    }

    // Tampilkan dialog sukses
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Berhasil', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('Kata sandi Anda berhasil diperbarui. Silakan gunakan kata sandi baru untuk login berikutnya.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Tutup dialog
              Navigator.pop(context); // Kembali ke halaman profil
            },
            child: const Text('OK', style: TextStyle(color: Color(0xFF2563EB), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 16, color: Color(0xFF2563EB)),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Ganti Kata Sandi',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            Text(
              'Keamanan akun Wali Murid',
              style: TextStyle(
                fontSize: 11,
                color: Color(0xFF94A3B8),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Banner Atas
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF2563EB),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.lock_outline, color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Perbarui kata sandi Anda',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Gunakan kata sandi yang kuat dan tidak mudah ditebak.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Form Input Kartu Putih
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sandi Lama
                  const Text('Kata sandi lama', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF1E293B))),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _oldPasswordController,
                    obscureText: _obscureOld,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF94A3B8)),
                      suffixIcon: IconButton(
                        icon: Icon(_obscureOld ? Icons.visibility_off : Icons.visibility, color: const Color(0xFF94A3B8)),
                        onPressed: () => setState(() => _obscureOld = !_obscureOld),
                      ),
                      hintText: '••••••••',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Center(
                    child: Text(
                      'KATA SANDI BARU',
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF94A3B8)),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Sandi Baru
                  const Text('Kata sandi baru', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF1E293B))),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _newPasswordController,
                    obscureText: _obscureNew,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF94A3B8)),
                      suffixIcon: IconButton(
                        icon: Icon(_obscureNew ? Icons.visibility_off : Icons.visibility, color: const Color(0xFF94A3B8)),
                        onPressed: () => setState(() => _obscureNew = !_obscureNew),
                      ),
                      hintText: '••••••••',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Konfirmasi Sandi Baru
                  const Text('Konfirmasi kata sandi baru', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF1E293B))),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirm,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF94A3B8)),
                      suffixIcon: IconButton(
                        icon: Icon(_obscureConfirm ? Icons.visibility_off : Icons.visibility, color: const Color(0xFF94A3B8)),
                        onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
                      ),
                      hintText: '••••••••',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Indikator Kekuatan Kata Sandi
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Kekuatan kata sandi baru', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                      Text(_strengthText, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: _strengthColor)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: _passwordStrength,
                    backgroundColor: const Color(0xFFE2E8F0),
                    color: _strengthColor,
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Daftar Checklist Syarat Sandi
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                children: [
                  _buildRequirementRow('Minimal 8 karakter', _hasMinLength),
                  const SizedBox(height: 10),
                  _buildRequirementRow('Huruf besar, kecil, angka, atau simbol', _hasComplexChar),
                  const SizedBox(height: 10),
                  _buildRequirementRow('Konfirmasi kata sandi sudah cocok', _isMatch),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Info Box Orange
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFBEB),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFFDE68A)),
              ),
              child: Row(
                children: const [
                  Icon(Icons.info_outline, color: Color(0xFFD97706), size: 22),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Anda akan tetap masuk',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF92400E)),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Setelah kata sandi diganti, gunakan kata sandi baru untuk login berikutnya.',
                          style: TextStyle(fontSize: 11, color: Color(0xFFB45309)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Tombol Simpan Kata Sandi
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  elevation: 0,
                ),
                onPressed: _savePassword,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.check, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Simpan Kata Sandi',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Tombol Batal
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Batal',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF64748B)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildRequirementRow(String text, bool isCompleted) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: isCompleted ? const Color(0xFFDCFCE7) : const Color(0xFFF1F5F9),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isCompleted ? Icons.check : Icons.circle,
            size: 14,
            color: isCompleted ? const Color(0xFF16A34A) : const Color(0xFFCBD5E1),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: isCompleted ? const Color(0xFF1E293B) : const Color(0xFF64748B),
            fontWeight: isCompleted ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}