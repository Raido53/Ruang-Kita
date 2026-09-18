
class RoomSession {
  final String roomName;
  final String activityName;
  final String time;
  final String status;
  final String description;

  const RoomSession({
    required this.roomName,
    required this.activityName,
    required this.time,
    required this.status,
    required this.description,
  });

  static List<RoomSession> getSampleRooms() {
    return [
      const RoomSession(
        roomName: 'Ruang Rapat Askala',
        activityName: 'Rapat Koordinasi BEM',
        time: '08.00 - 10.00',
        status: 'Berlangsung',
        description:
            'Rapat koordinasi pengurus untuk membahas persiapan kegiatan, pembagian tugas, dan evaluasi program kerja organisasi.',
      ),

      const RoomSession(
        roomName: 'Coworking Space',
        activityName:
            'Diskusi Pengembangan Sistem Informasi Akademik Terintegrasi',
        time: '09.00 - 11.00',
        status: 'Berlangsung',
        description:
            'Kegiatan diskusi kelompok mahasiswa untuk merancang sistem informasi akademik yang dapat membantu pengelolaan data dan meningkatkan efisiensi pelayanan kampus.',
      ),

      const RoomSession(
        roomName: 'Ruang Diskusi 1',
        activityName: 'Presentasi Proyek Perangkat Lunak',
        time: '10.00 - 12.00',
        status: 'Akan Datang',
        description:
            'Ruang digunakan untuk presentasi hasil pengembangan proyek perangkat lunak dan pemberian masukan dari anggota kelompok.',
      ),

      const RoomSession(
        roomName: 'Ruang Diskusi 2',
        activityName: 'Belajar Kelompok Basis Data',
        time: '13.00 - 15.00',
        status: 'Akan Datang',
        description:
            'Mahasiswa melakukan pembelajaran bersama untuk memahami perancangan database, relasi antar tabel, dan penerapan query SQL.',
      ),

      const RoomSession(
        roomName: 'Ruang Rapat Askala',
        activityName: 'Evaluasi Program Kerja Organisasi',
        time: '07.30 - 09.00',
        status: 'Selesai',
        description:
            'Evaluasi kegiatan organisasi yang telah dilaksanakan untuk mengetahui hasil, kendala, dan perbaikan yang diperlukan pada kegiatan berikutnya.',
      ),

      const RoomSession(
        roomName: 'Coworking Space',
        activityName: 'Pengerjaan Tugas Pemrograman Flutter',
        time: '14.00 - 16.00',
        status: 'Selesai',
        description:
            'Mahasiswa menyelesaikan tugas pemrograman perangkat bergerak dengan menerapkan konsep widget, layout responsif, dan pengelolaan state.',
      ),

      const RoomSession(
        roomName: 'Ruang Diskusi 1',
        activityName: 'Sesi Konsultasi Proyek Mahasiswa',
        time: '16.00 - 17.00',
        status: 'Tersedia',
        description:
            'Ruangan tersedia untuk mahasiswa yang membutuhkan tempat konsultasi, diskusi, atau persiapan tugas akademik secara berkelompok.',
      ),

      const RoomSession(
        roomName: 'Ruang Diskusi 2',
        activityName: 'Persiapan Rapat Kepanitiaan',
        time: '18.00 - 19.30',
        status: 'Tersedia',
        description:
            'Ruangan dapat digunakan untuk persiapan rapat kepanitiaan, penyusunan agenda, pembagian tanggung jawab, dan koordinasi antaranggota.',
      ),
    ];
  }
}