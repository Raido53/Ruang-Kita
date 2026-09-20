
import 'package:flutter/material.dart';
import '.././/models/room_session.dart';

class RuangPraktikum extends StatefulWidget {
  const RuangPraktikum({super.key});

  @override
  State<RuangPraktikum> createState() => _RuangPraktikumState();
}

class _RuangPraktikumState extends State<RuangPraktikum> {
  String selectedStatus = 'Semua';
  bool isDarkMode = false;

  final rooms = RoomSession.getSampleRooms();

  

  static const statuses = [
  'Semua',
  'Berlangsung',
  'Akan Datang',
  'Selesai',
  'Tersedia',
];

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
            Text(
              room.roomName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              room.activityName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                const Icon(Icons.access_time),
                const SizedBox(width: 8),
                Text(room.time),
              ],
            ),

            const SizedBox(height: 16),

            Text(
              'Status: ${room.status}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'Deskripsi Kegiatan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(room.description),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.check),
                label: const Text('Tandai Dipilih'),
              ),
            ),

            const SizedBox(height: 8),
          ],
        ),
      );
    },
  );
}

  @override
Widget build(BuildContext context) {
  final filteredRooms = selectedStatus == 'Semua'
      ? rooms
      : rooms
          .where((room) => room.status == selectedStatus)
          .toList();

  return Theme(
    data: ThemeData(
      brightness:
          isDarkMode ? Brightness.dark : Brightness.light,
      colorSchemeSeed: Colors.blue,
      useMaterial3: true,
    ),
    child: Scaffold(
      appBar: AppBar(
        title: const Text('RuangKita'),
        actions: [
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
          const Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: Text('M02-2036'),
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            int columns = 1;

            if (width >= 840) {
              columns = 3;
            } else if (width >= 600) {
              columns = 2;
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ketersediaan Ruang Hari Ini',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Pantau penggunaan ruang rapat dan coworking.',
                  ),

                  const SizedBox(height: 20),

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

                  const SizedBox(height: 20),

                  GridView.builder(
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: filteredRooms.length,
                    itemBuilder: (context, index) {
                      return _buildRoomCard(filteredRooms[index]);

                      
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
  ),
    );
  }

  Widget _buildRoomCard(RoomSession room) {
  Color statusColor;

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

  return Card(
    elevation: 2,
    child: InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        _showRoomDetail(room);
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.meeting_room,
                  size: 36,
                  color: Colors.blue,
                ),

                const SizedBox(height: 12),

                Text(
                  room.roomName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  room.activityName,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),

                const Spacer(),

                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16),
                    const SizedBox(width: 6),
                    Text(room.time),
                  ],
                ),
              ],
            ),
          ),

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
        ],
      ),
    ),
  );
}
  }
