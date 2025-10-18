import 'package:digifarm/auth/provider/login_provider.dart';
import 'package:digifarm/flock/models/flock.dart';
import 'package:digifarm/flock/provider/flock_fetch_provider.dart';
import 'package:digifarm/livestock/models/lamb.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final flockAddProvider = AsyncNotifierProvider<FlockAddNotifier, void>(() {
  return FlockAddNotifier();
});

class FlockAddNotifier extends AsyncNotifier<void> {
  static const String _baseUrl =
      'https://flutter-digifarm-default-rtdb.firebaseio.com';

  @override
  Future<void> build() async {
    return;
  }

  Future<void> addFlock({
    required String id,
    required TipeKandang tipeKandang,
    required List<Lamb> hewanTernak,
  }) async {

    final userId = ref.read(currentUserIdProvider);

    if (userId == null){
      throw Exception('User tidak terautentikasi');
    }

    state = AsyncValue.loading();

    final newFlock = Flock(
      id: id,
      tipeKandang: tipeKandang,
      hewanTernak: hewanTernak,
    );

    final Map<String, dynamic> dataToSave = newFlock.toJson();

    try {
      final url = Uri.parse('$_baseUrl/users/$userId/flocks/$id.json');

      final response = await http.put(url, body: json.encode(dataToSave));

      if (response.statusCode >= 400) {
        throw Exception(
          'Gagal menyimpan data kandang. Status: ${response.statusCode}',
        );
      }

      state = AsyncValue.data(null);

      ref.invalidate(flockFetchProvider);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }
}
