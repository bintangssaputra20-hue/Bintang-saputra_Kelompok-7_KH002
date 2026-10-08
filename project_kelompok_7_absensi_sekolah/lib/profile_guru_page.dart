import 'package:flutter/material.dart';
import 'ganti_kata_sandi_page.dart';

class ProfilGuruPage extends StatelessWidget {
  const ProfilGuruPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Biru Atas
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 30),
              decoration: const BoxDecoration(
                color: Color(0xFF2563EB),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Baris Judul & Tombol Edit Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Profil Guru',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.edit_outlined, color: Colors.white, size: 20),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Foto Profil & Nama
                  Center(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 3),
                                image: const DecorationImage(
                                  image: NetworkImage(
                                    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  size: 16,
                                  color: Color(0xFF2563EB),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Ahmad Hidayat, S.Pd.',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Guru Matematika • Wali Kelas 8A',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Informasi Detail (NIP, Email, Bidang Studi)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  children: [
                    _buildInfoItem(
                      Icons.person_outline,
                      'NIP',
                      '19870512 201203 1 004',
                    ),
                    const Divider(height: 24, color: Color(0xFFF1F5F9)),
                    _buildInfoItem(
                      Icons.mail_outline,
                      'Email',
                      'ahmad@smartschool.id',
                    ),
                    const Divider(height: 24, color: Color(0xFFF1F5F9)),
                    _buildInfoItem(
                      Icons.school_outlined,
                      'Bidang Studi',
                      'Matematika',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Kotak Statistik (Kelas Diampu, Jam/Minggu, Wali Kelas)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(child: _buildStatCard('3', 'Kelas Diampu', Icons.people_outline)),
                  const SizedBox(width: 8),
                  Expanded(child: _buildStatCard('18', 'Jam / Minggu', Icons.book_outlined)),
                  const SizedBox(width: 8),
                  Expanded(child: _buildStatCard('8A', 'Wali Kelas', Icons.calendar_today_outlined)),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Menu Aksi (Edit Profil, Ubah Kata Sandi, Keluar)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  children: [
                    _buildMenuActionItem(context, 'Edit Profil', Icons.edit_outlined, const Color(0xFF2563EB), const Color(0xFFEFF6FF)),
                    const Divider(height: 1, color: Color(0xFFF1F5F9)),
                    _buildMenuActionItem(context, 'Ubah Kata Sandi', Icons.lock_outline, const Color(0xFF2563EB), const Color(0xFFEFF6FF)),
                    const Divider(height: 1, color: Color(0xFFF1F5F9)),
                    _buildMenuActionItem(context, 'Keluar', Icons.logout, Colors.red, const Color(0xFFFEF2F2), isLogout: true),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      
      // Navbar Bawah Lengkap 5 Menu
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 4, // Indeks 4 menunjuk ke "Profil" di ujung kanan
        onTap: (index) {
          // Tambahkan logika perpindahan halaman antar tab di sini jika diperlukan
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF2563EB),
        unselectedItemColor: const Color(0xFF94A3B8),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            activeIcon: Icon(Icons.calendar_today),
            label: 'Jadwal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            activeIcon: Icon(Icons.assignment),
            label: 'Absensi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            activeIcon: Icon(Icons.people),
            label: 'Siswa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  // Widget baris informasi detail
  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF64748B), size: 22),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Widget kartu statistik
  Widget _buildStatCard(String value, String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF2563EB), size: 22),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }

  // Widget menu aksi bawah dengan context yang diteruskan
  Widget _buildMenuActionItem(BuildContext context, String label, IconData icon, Color color, Color bgColor, {bool isLogout = false}) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(
      label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: isLogout ? Colors.red : const Color(0xFF1E293B),
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF94A3B8)),
      onTap: () {
        if (label == 'Ubah Kata Sandi') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const GantiKataSandiPage()),
          );
        }
      },
    );
  }
}