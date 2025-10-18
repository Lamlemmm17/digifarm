import 'package:digifarm/auth/provider/login_provider.dart';
import 'package:digifarm/livestock/models/lamb.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LambsState {
  final List<Lamb> lambs;
  final bool isLoading;
  final String? errorMessage;

  LambsState({required this.lambs, this.isLoading = false, this.errorMessage});

  LambsState copyWith({
    List<Lamb>? lambs,
    bool? isLoading,
    String? errorMessage,
  }) {
    return LambsState(
      lambs: lambs ?? this.lambs,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class LivestockFetchNotifier extends StateNotifier<LambsState> {
  final Ref ref;

  LivestockFetchNotifier(this.ref) : super(LambsState(lambs: [], isLoading: true)) {
    fetchLambs();
  }
  
  static const String _baseUrl =
      'https://flutter-digifarm-default-rtdb.firebaseio.com';

  Future<void> fetchLambs() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    final userId = ref.read(currentUserIdProvider);
    
    if (userId == null) {
      throw Exception('User tidak terautentikasi');
    }

    try {

      final url = Uri.parse('$_baseUrl/users/$userId/lambs.json');

      final response = await http.get(url);

      if (response.statusCode >= 400) {
        throw Exception(
          'FETCH DATA: Gagal mengambil data Status: ${response.statusCode}',
        );
      }

      final Map<String, dynamic>? listData =
          json.decode(response.body) as Map<String, dynamic>?;
      final List<Lamb> loadedLambs = [];

      if (listData != null) {
        listData.forEach((key, value) {
          loadedLambs.add(Lamb.fromJson(value));
        });
      } 
  
      state = state.copyWith(lambs: loadedLambs, isLoading: false);
    } catch (error) {
      state = state.copyWith(
        lambs: [],
        isLoading: false,
        errorMessage: 'Gagal memuat data: ${error.toString()}',
      );
      rethrow;
    }
  }

  Future<void> refreshLambs() async {
    await fetchLambs();
  }
}

final livestockFetchProvider = StateNotifierProvider<LivestockFetchNotifier, LambsState>((ref) {
  return LivestockFetchNotifier(ref);
});

final totalLambsProvider = Provider<int>((ref) {
  final lambsState = ref.watch(livestockFetchProvider);
  return lambsState.lambs.length;
});

final maleLambsProvider = Provider<int>((ref) {
  final lambsState = ref.watch(livestockFetchProvider);
  return lambsState.lambs.where((lamb) => lamb.kelamin == Gender.jantan).length;
});

final femaleLambsProvider = Provider<int>((ref) {
  final lambsState = ref.watch(livestockFetchProvider);
  return lambsState.lambs.where((lamb) => lamb.kelamin == Gender.betina).length;
});
