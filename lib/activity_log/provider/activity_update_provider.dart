import 'dart:async';
import 'dart:convert';

import 'package:digifarm/activity_log/model/activity_log.dart';
import 'package:digifarm/activity_log/provider/activity_fetch_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final activityUpdateProvider = AsyncNotifierProvider<ActivityUpdateNotifier, void>(
  () {
    return ActivityUpdateNotifier();
  },
);

class ActivityUpdateNotifier extends AsyncNotifier<void> {
  static const String _baseUrl =
      'https://flutter-digifarm-default-rtdb.firebaseio.com/activity_log';

  @override
  FutureOr<void> build() async {
    return;
  }

  Future<void> addActivity({
    required String id,
    required String judul,
    required String isiCatatan,
    required TipeKegiatan tipeKegiatan,
    required DateTime waktu
  }) async {
    state = const AsyncValue.loading();

    final data = ActivityLog(
      judul: judul,
      isiCatatan: isiCatatan,
      tipeKegiatan: tipeKegiatan,
      waktu: waktu
    );

    final Map<String, dynamic> savedData = data.toJson();

    try {
      final updateUrl = _baseUrl.replaceAll('.json', '');
      final url = Uri.parse('$updateUrl/$id.json');

      final response = await http.patch(url, body: jsonEncode(savedData));

      if (response.statusCode >= 400) {
        throw Exception(
          'Gagal menyimpan data ke firebase, status: ${response.statusCode}',
        );
      }

      state = AsyncValue.data(null);
      ref.invalidate(activityFetchProvider);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }
}
