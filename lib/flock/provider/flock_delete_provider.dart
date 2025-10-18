import 'dart:async';

import 'package:digifarm/auth/provider/login_provider.dart';
import 'package:digifarm/flock/provider/flock_fetch_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final flockDeleteProvider = AsyncNotifierProvider<FlockDeleteNotifier, void>(
  () {
    return FlockDeleteNotifier();
  },
);

class FlockDeleteNotifier extends AsyncNotifier<void> {
  static const _baseUrl =
      'https://flutter-digifarm-default-rtdb.firebaseio.com';

  @override
  FutureOr<void> build() async {
    return;
  }

  Future<void> deleteFlock(String flockId) async {

    try {
      final userId = ref.read(currentUserIdProvider);

      if (userId == null) {
        throw Exception('User tidak terautentikasi');
      }

      state = AsyncValue.loading();

      final url = Uri.parse('$_baseUrl/users/$userId/flocks/$flockId.json');

      final response = await http.delete(url);

      if (response.statusCode >= 400) {
        throw Exception('Delete error, status: ${response.statusCode}');
      }

      state = AsyncValue.data(null);
      ref.invalidate(flockFetchProvider);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }
}
