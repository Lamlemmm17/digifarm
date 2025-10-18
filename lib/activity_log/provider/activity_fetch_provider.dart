import 'dart:async';
import 'dart:convert';
import 'package:digifarm/auth/provider/login_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:digifarm/activity_log/model/activity_log.dart';

final activityFetchProvider =
    AsyncNotifierProvider<ActivityFetchProvider, List<ActivityLog>>(() {
      return ActivityFetchProvider();
    });

class ActivityFetchProvider extends AsyncNotifier<List<ActivityLog>> {
  static const _baseUrl =
      'https://flutter-digifarm-default-rtdb.firebaseio.com';

  @override
  FutureOr<List<ActivityLog>> build() async {

    final userId = ref.read(currentUserIdProvider);

    final url = Uri.parse('$_baseUrl/users/$userId/activity_logs.json');
    final response = await http.get(url);

    if (response.statusCode >= 400) {
      throw Exception('Error Fetching data, status = ${response.statusCode}');
    }

    if (response.body == 'null' || response.body.isEmpty) {
      return [];
    }

    final Map<String, dynamic>? listData =
        jsonDecode(response.body) as Map<String, dynamic>?;

    final List<ActivityLog> dataActivity = [];

    if (listData != null) {
      listData.forEach((key, value) {

        final Map<String, dynamic> activityData = value as Map<String, dynamic>;

        activityData['id'] = key; 

        dataActivity.add(ActivityLog.fromJson(activityData));
      });
    }
    return dataActivity;
  }
}
