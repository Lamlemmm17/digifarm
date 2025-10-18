import 'package:intl/intl.dart';

enum TipeKegiatan { pakan, kesehatan, pencukuran, lingkungan, lainnya }

class ActivityLog {
  const ActivityLog({
    this.id,
    required this.judul,
    required this.isiCatatan,
    required this.tipeKegiatan,
    required this.waktu
  });

  final String? id;
  final String judul;
  final String isiCatatan;
  final TipeKegiatan tipeKegiatan;
  final DateTime waktu;

  Map<String, dynamic> toJson() {
    return {
      'judul': judul,
      'isiCatatan': isiCatatan,
      'TipeKegiatan': tipeKegiatan.name,
      'waktu': waktu.toIso8601String(),
    };
  }

  factory ActivityLog.fromJson(Map<String, dynamic> json) {
    return ActivityLog(
      id: json['id'] as String?,
      judul: json['judul'],
      isiCatatan: json['isiCatatan'],
      tipeKegiatan: TipeKegiatan.values.firstWhere(
        (e) => e.name == json['TipeKegiatan'],
        orElse: () => TipeKegiatan.values.first,
      ),
      waktu: DateTime.parse(json['waktu'] as String),
    );
  }

  String get displayTipeKegiatan {
    switch (tipeKegiatan) {
      case TipeKegiatan.kesehatan:
        return 'Kesehatan';
      case TipeKegiatan.lainnya:
        return 'Lainnya';
      case TipeKegiatan.lingkungan:
        return 'Lingkungan';
      case TipeKegiatan.pakan:
        return 'Pakan';
      case TipeKegiatan.pencukuran:
        return 'Pencukuran';
    }
  }

  String get displayWaktu {
    final dateFormatter = DateFormat('EEEE, dd/MM HH:mm', 'id');

    return dateFormatter.format(waktu);
  }
}
