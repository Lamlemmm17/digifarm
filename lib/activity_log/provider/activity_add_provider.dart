import 'dart:async';
import 'dart:convert';

import 'package:digifarm/activity_log/model/activity_log.dart';
import 'package:digifarm/activity_log/provider/activity_fetch_provider.dart';
import 'package:digifarm/auth/provider/login_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final activityAddProvider = AsyncNotifierProvider<ActivityAddNotifier, void>(
  () {
    return ActivityAddNotifier();
  },
);

class ActivityAddNotifier extends AsyncNotifier<void> {
  static const String _baseUrl =
      'https://flutter-digifarm-default-rtdb.firebaseio.com';

  @override
  FutureOr<void> build() async {
    return;
  }

  Future<void> addActivity({
    required String judul,
    required String isiCatatan,
    required TipeKegiatan tipeKegiatan,
    required DateTime waktu,
  }) async {
    state = const AsyncValue.loading();

    final data = ActivityLog(
      judul: judul,
      isiCatatan: isiCatatan,
      tipeKegiatan: tipeKegiatan,
      waktu: waktu,
    );

    final Map<String, dynamic> savedData = data.toJson();

    try {

      final userId = ref.read(currentUserIdProvider);

      if (userId == null) {
        throw Exception('User tidak terautentikasi');
      }

      final url = Uri.parse('$_baseUrl/users/$userId/activity_logs.json');

      final response = await http.post(url, body: jsonEncode(savedData));

      if (response.statusCode >= 400) {
        throw Exception(
          'Gagal menyimpan data ke firebase, status: ${response.statusCode}',
        );
      }

      state = AsyncValue.data(null);
      ref.invalidate(activityFetchProvider);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
