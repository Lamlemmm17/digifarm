import 'dart:async';

import 'package:digifarm/activity_log/provider/activity_fetch_provider.dart';
import 'package:digifarm/auth/provider/login_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final activityDeleteProvider =
    AsyncNotifierProvider<ActivityDeleteNotifier, void>(() {
      return ActivityDeleteNotifier();
    });

class ActivityDeleteNotifier extends AsyncNotifier<void> {
  static const String _baseUrl =
      'https://flutter-digifarm-default-rtdb.firebaseio.com';

  @override
  FutureOr<void> build() async {
    return;
  }

  Future<void> deleteActivity(String activityId) async {

    try {
      state = AsyncValue.loading();

      final userId = ref.read(currentUserIdProvider);

      final url = Uri.parse('$_baseUrl/users/$userId/activity_logs/$activityId.json');

      final response = await http.delete(url);

      if (response.statusCode >= 400) {
        throw Exception('Delete error, Status: ${response.statusCode}');
      }

      ref.invalidate(activityFetchProvider);
      state = AsyncValue.data(null);

    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }
}
