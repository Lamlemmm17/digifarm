import 'dart:async';

import 'package:digifarm/auth/provider/login_provider.dart';
import 'package:digifarm/flock/provider/flock_fetch_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final livestockDeleteProvider =
    AsyncNotifierProvider<LivestockDeleteNotifier, void>(() {
      return LivestockDeleteNotifier();
    });

class LivestockDeleteNotifier extends AsyncNotifier<void> {
  static const String _baseUrl =
      'https://flutter-digifarm-default-rtdb.firebaseio.com';

  @override
  FutureOr<void> build() async {
    return;
  }

  Future<void> deleteLamb(String lambId) async {

    try {

      final userId = ref.read(currentUserIdProvider);

      if (userId == null) {
        throw Exception('User tidak terautentikasi');
      }
      state = const AsyncValue.loading();

      final url = Uri.parse('$_baseUrl/users/$userId/lambs/$lambId.json');

      final response = await http.delete(url);

      if (response.statusCode >= 400) {
        throw Exception(
          'Gagal menghapus domba. Status: ${response.statusCode}',
        );
      }

      ref.read(flockFetchProvider.notifier).hapusDombaDariKandang(lambId);

      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
