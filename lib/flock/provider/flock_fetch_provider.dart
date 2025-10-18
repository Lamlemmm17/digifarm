import 'dart:async';
import 'dart:convert';
import 'package:digifarm/auth/provider/login_provider.dart';
import 'package:digifarm/livestock/models/lamb.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:digifarm/flock/models/flock.dart';

final flockFetchProvider =
    AsyncNotifierProvider<FlockFetchProvider, List<Flock>>(() {
      return FlockFetchProvider();
    });

class FlockFetchProvider extends AsyncNotifier<List<Flock>> {
  static const _baseUrl =
      'https://flutter-digifarm-default-rtdb.firebaseio.com';

  @override
  FutureOr<List<Flock>> build() async {

    final userId = ref.read(currentUserIdProvider);
    if (userId == null) {
      throw Exception('User tidak terautentikasi!');
    }

    final url = Uri.parse('$_baseUrl/users/$userId/flocks.json');
    final response = await http.get(url);

    if (response.statusCode >= 400) {
      throw Exception('Error Fetching Data, Status = ${response.statusCode}');
    }

    if (response.body == 'null' || response.body.isEmpty) {
      return [];
    }

    final Map<String, dynamic>? listData =
        jsonDecode(response.body) as Map<String, dynamic>?;

    final List<Flock> dataFlock = [];

    if (listData != null) {
      listData.forEach((key, value) {
        final Map<String, dynamic> flockData = value as Map<String, dynamic>;

        dataFlock.add(Flock.fromJson(flockData));
      });
    }
    return dataFlock;
  }

  void hapusDombaDariKandang(String lambId) {
    if (state.value == null) return;

    final updatedFlocks = state.value!.map((flock) {
      final updatedLambs = List<Lamb>.from(flock.hewanTernak);

      updatedLambs.removeWhere((lamb) => lamb.id == lambId);

      return Flock(
        id: flock.id,
        tipeKandang: flock.tipeKandang,
        hewanTernak: updatedLambs,
      );
    }).toList();
    state = AsyncValue.data(updatedFlocks);
  }
}

final totalFlockProvider = Provider<int>((ref) {
  final flockState = ref.watch(flockFetchProvider);

  if (flockState.value == null) {
    return 0;
  }
  return flockState.value!.length;
});
