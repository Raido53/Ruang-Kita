# AI USAGE - MODUL 02 (RuangKita)

**Nama**: Raido Octaviandy  
**NIM**: 362558302036  
**Program Studi**: D4 Teknologi Rekayasa Perangkat Lunak  
**Domain**: Ruang Rapat & Coworking  
**Identitas**: M02-2036

Dokumentasi penggunaan Artificial Intelligence (AI) selama proses pengembangan aplikasi RuangKita pada Modul 02.

---

## 1. Informasi Penggunaan AI

### Tools AI yang Digunakan

- **Nama AI**: ChatGPT
- **Bahasa Pemrograman**: Dart
- **Framework**: Flutter
- **Tujuan Penggunaan**: Membantu memahami konsep Flutter, menyusun kode, memperbaiki error dan warning, serta memahami struktur kode yang digunakan.

AI digunakan sebagai alat bantu dalam proses pengembangan. Kode yang diberikan kemudian disesuaikan dengan kebutuhan aplikasi RuangKita.

---

## 2. Penggunaan AI dalam Pengembangan

### Kasus 1: Penggunaan StatefulWidget dan State

#### Tujuan

AI digunakan untuk membantu memahami alasan penggunaan `StatefulWidget` pada halaman RuangKita.

Pada aplikasi ini terdapat beberapa data yang dapat berubah ketika pengguna berinteraksi, seperti:

- Status filter ruangan
- Mode Light/Dark
- Ruangan yang dipilih

Bagian kode yang digunakan:

```dart
class RuangPraktikum extends StatefulWidget {
  const RuangPraktikum({super.key});

  @override
  State<RuangPraktikum> createState() => _RuangPraktikumState();
}

class _RuangPraktikumState extends State<RuangPraktikum> {
  String selectedStatus = 'Semua';
  bool isDarkMode = false;
  RoomSession? selectedRoom;

  final rooms = RoomSession.getSampleRooms();
}
```

#### Penjelasan

`RuangPraktikum` menggunakan `StatefulWidget` karena terdapat data yang dapat berubah selama aplikasi berjalan.

`selectedStatus` digunakan untuk menyimpan filter yang dipilih, `isDarkMode` digunakan untuk menyimpan kondisi mode tampilan, sedangkan `selectedRoom` digunakan untuk menyimpan ruangan yang dipilih.

---

### Kasus 2: Filter Status Menggunakan ChoiceChip

#### Tujuan

AI digunakan untuk membantu memahami cara membuat filter status ruangan menggunakan `ChoiceChip` dan `setState`.

Status yang digunakan:

- Semua
- Berlangsung
- Akan Datang
- Selesai
- Tersedia

Bagian kode yang digunakan:

```dart
static const statuses = [
  'Semua',
  'Berlangsung',
  'Akan Datang',
  'Selesai',
  'Tersedia',
];
```

Filter pada tampilan:

```dart
Wrap(
  spacing: 8,
  runSpacing: 8,
  children: statuses.map((status) {
    return ChoiceChip(
      label: Text(status),
      selected: selectedStatus == status,
      onSelected: (selected) {
        setState(() {
          selectedStatus = status;
        });
      },
    );
  }).toList(),
),
```

Data ruangan kemudian difilter menggunakan:

```dart
final filteredRooms = selectedStatus == 'Semua'
    ? rooms
    : rooms
        .where((room) => room.status == selectedStatus)
        .toList();
```

#### Penjelasan

Ketika pengguna memilih salah satu `ChoiceChip`, nilai `selectedStatus` diubah menggunakan `setState`.

Setelah state berubah, widget dibangun kembali sehingga `filteredRooms` menampilkan data sesuai status yang dipilih.

---

### Kasus 3: Responsive Layout Menggunakan LayoutBuilder

#### Tujuan

AI digunakan untuk memahami cara membuat tampilan responsive berdasarkan ukuran layar.

Bagian kode yang digunakan:

```dart
LayoutBuilder(
  builder: (context, constraints) {
    final width = constraints.maxWidth;

    int columns = 1;

    if (width >= 840) {
      columns = 3;
    } else if (width >= 600) {
      columns = 2;
    }
```

Jumlah kolom tersebut digunakan pada `GridView.builder`:

```dart
GridView.builder(
  shrinkWrap: true,
  physics:
      const NeverScrollableScrollPhysics(),
  gridDelegate:
      SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: columns,
    crossAxisSpacing: 16,
    mainAxisSpacing: 16,
    childAspectRatio: 1.1,
  ),
  itemCount: filteredRooms.length,
  itemBuilder: (context, index) {
    return _buildRoomCard(filteredRooms[index]);
  },
),
```

#### Breakpoint yang Digunakan

| Lebar Layar | Jumlah Kolom |
|---|---:|
| < 600 dp | 1 kolom |
| 600–839 dp | 2 kolom |
| >= 840 dp | 3 kolom |

#### Penjelasan

`LayoutBuilder` digunakan untuk mendapatkan lebar ruang yang tersedia pada bagian layout tersebut.

Nilai `constraints.maxWidth` kemudian digunakan untuk menentukan jumlah kolom sehingga tampilan dapat menyesuaikan ukuran layar.

---

### Kasus 4: Detail Ruangan Menggunakan Bottom Sheet

#### Tujuan

AI digunakan untuk membantu memahami cara menampilkan detail ruangan tanpa berpindah halaman.

Fungsi yang digunakan:

```dart
void _showRoomDetail(RoomSession room) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
```

Informasi ruangan yang ditampilkan berasal dari object `RoomSession`, seperti:

```dart
Text(room.roomName),
Text(room.activityName),
Text(room.time),
Text('Status: ${room.status}'),
Text(room.description),
```

#### Tombol Tandai Dipilih

Pada bottom sheet terdapat tombol:

```dart
SizedBox(
  width: double.infinity,
  child: ElevatedButton.icon(
    onPressed: () {
      setState(() {
        selectedRoom = room;
      });

      Navigator.pop(context);

      ScaffoldMessenger.of(this.context).showSnackBar(
        SnackBar(
          content: Text(
            '${room.roomName} berhasil dipilih',
          ),
        ),
      );
    },
    icon: const Icon(Icons.check),
    label: const Text('Tandai Dipilih'),
  ),
),
```

#### Penjelasan

Ketika tombol `Tandai Dipilih` ditekan, `selectedRoom` diubah menggunakan `setState`.

Setelah itu bottom sheet ditutup menggunakan `Navigator.pop(context)` dan aplikasi menampilkan `SnackBar` sebagai informasi bahwa ruangan berhasil dipilih.

---

### Kasus 5: Mode Light dan Dark

#### Tujuan

AI digunakan untuk membantu memahami perubahan tampilan menggunakan state.

Bagian kode yang digunakan:

```dart
bool isDarkMode = false;
```

Kemudian tema aplikasi dibuat berdasarkan nilai tersebut:

```dart
Theme(
  data: ThemeData(
    brightness:
        isDarkMode ? Brightness.dark : Brightness.light,
    colorSchemeSeed: Colors.blue,
    useMaterial3: true,
  ),
```

Tombol untuk mengganti mode:

```dart
IconButton(
  onPressed: () {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  },
  icon: Icon(
    isDarkMode
        ? Icons.light_mode
        : Icons.dark_mode,
  ),
  tooltip: 'Ganti mode tampilan',
),
```

#### Penjelasan

Nilai `isDarkMode` digunakan untuk menentukan `Brightness` pada `ThemeData`.

Ketika tombol ditekan, nilai boolean dibalik menggunakan `setState`, sehingga tampilan berubah antara Light Mode dan Dark Mode.

---

### Kasus 6: Status Badge Menggunakan Stack dan Positioned

#### Tujuan

AI digunakan untuk membantu memahami cara menempatkan status ruangan pada bagian kanan atas kartu.

Bagian kode yang digunakan:

```dart
return Card(
  elevation: 2,
  child: InkWell(
    borderRadius: BorderRadius.circular(12),
    onTap: () {
      _showRoomDetail(room);
    },
    child: Stack(
      children: [
```

Status ditempatkan menggunakan `Positioned`:

```dart
Positioned(
  top: 12,
  right: 12,
  child: Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 8,
      vertical: 4,
    ),
    decoration: BoxDecoration(
      color: statusColor.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      room.status,
      style: TextStyle(
        color: statusColor,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
),
```

#### Penjelasan

`Stack` digunakan untuk menumpuk beberapa widget dalam satu area.

`Positioned` digunakan untuk menempatkan badge status pada posisi kanan atas kartu ruangan.

Warna badge ditentukan berdasarkan status ruangan melalui `switch`.

```dart
switch (room.status) {
  case 'Berlangsung':
    statusColor = Colors.green;
    break;
  case 'Akan Datang':
    statusColor = Colors.orange;
    break;
  case 'Selesai':
    statusColor = Colors.grey;
    break;
  default:
    statusColor = Colors.blue;
}
```

---

## 3. Debugging dengan Bantuan AI

Selama proses pengembangan, dilakukan pengecekan menggunakan:

```powershell
flutter analyze
```

Salah satu warning yang ditemukan adalah:

```text
unused_local_variable
```

Warning tersebut berkaitan dengan variabel `filteredRooms`.

AI membantu menjelaskan bahwa variabel tersebut harus digunakan pada bagian `GridView.builder`.

Kode yang digunakan:

```dart
itemCount: filteredRooms.length,
itemBuilder: (context, index) {
  return _buildRoomCard(filteredRooms[index]);
},
```

Setelah dilakukan pengecekan dan perbaikan, `filteredRooms` digunakan sebagai sumber data pada `GridView.builder`.

---

## 4. Verifikasi Kode

Kode yang diberikan AI tidak langsung digunakan seluruhnya.

Setiap bagian kode diperiksa dan disesuaikan dengan struktur project RuangKita. Pengujian dilakukan dengan menjalankan aplikasi dan menggunakan:

```powershell
flutter analyze
```

Selain itu, tampilan diuji pada ukuran layar yang berbeda untuk memastikan responsive layout dapat berjalan sesuai breakpoint yang telah dibuat.

---

## 5. Pemahaman yang Diperoleh

Dari penggunaan AI selama proses pengembangan, saya memahami beberapa konsep Flutter yang digunakan dalam aplikasi RuangKita, yaitu:

1. `StatefulWidget` digunakan karena terdapat state yang dapat berubah.
2. `setState` digunakan untuk memperbarui state dan membangun kembali tampilan.
3. `ChoiceChip` digunakan untuk membuat pilihan filter status.
4. `LayoutBuilder` digunakan untuk menentukan layout berdasarkan ukuran ruang yang tersedia.
5. `GridView.builder` digunakan untuk menampilkan daftar ruangan secara dinamis.
6. `showModalBottomSheet` digunakan untuk menampilkan detail ruangan.
7. `Stack` dan `Positioned` digunakan untuk menempatkan badge status pada kartu.
8. `ThemeData` digunakan untuk mengatur Light Mode dan Dark Mode.
9. `flutter analyze` digunakan untuk membantu menemukan masalah pada kode.

---

## 6. Batasan Penggunaan AI

AI digunakan sebagai alat bantu dalam proses pengembangan, terutama untuk memahami konsep, mencari solusi, menjelaskan error atau warning, dan memberikan contoh implementasi.

Kode yang diberikan AI tetap diperiksa dan disesuaikan dengan kebutuhan aplikasi RuangKita. Pengujian juga dilakukan kembali untuk memastikan kode dapat berjalan sesuai dengan rancangan.

---

## 7. Kesimpulan

Penggunaan AI membantu proses pengembangan aplikasi RuangKita dalam memahami struktur `StatefulWidget`, pengelolaan state menggunakan `setState`, filter status menggunakan `ChoiceChip`, responsive layout menggunakan `LayoutBuilder`, tampilan daftar menggunakan `GridView.builder`, detail menggunakan `showModalBottomSheet`, serta penggunaan `Stack` dan `Positioned` untuk status badge.

AI digunakan sebagai alat bantu selama proses pengembangan, sedangkan penyesuaian kode, pengujian, dan pemahaman terhadap kode tetap dilakukan selama proses pengerjaan aplikasi.