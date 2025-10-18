import 'package:digifarm/auth/provider/login_provider.dart';
import 'package:digifarm/livestock/provider/livestock_fetch_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:digifarm/livestock/models/lamb.dart'; 

final livestockAddProvider = AsyncNotifierProvider<LivestockAddNotifier, void>(() {
  return LivestockAddNotifier();
});

class LivestockAddNotifier extends AsyncNotifier<void> {
  static const String _baseUrl = 'https://flutter-digifarm-default-rtdb.firebaseio.com';
  
  @override
  Future<void> build() async {
    return;
  }

  int _calculateAge(DateTime birthDate) {

    final now = DateTime.now();
    int totalMonths = (now.year - birthDate.year) * 12;
    totalMonths += now.month - birthDate.month;
    
    if (now.day < birthDate.day) {
        totalMonths--;
    }

    return totalMonths < 0 ? 0 : totalMonths;
  }

  Future<void> addLamb({
    required String id, 
    required Tipe tipe,
    required Gender kelamin, 
    required String berat,
    required Breed bangsa, 
    required DateTime tanggalLahir, 
    required StatusKesehatan statusKesehatan,
  }) async {
  
    final userId = ref.read(currentUserIdProvider);
    
    if (userId == null) {
      throw Exception('User tidak terautentikasi');
    }

    state = const AsyncValue.loading();
    
    final int umur = _calculateAge(tanggalLahir);

    final newLamb = Lamb(
      id: id,
      tipe: tipe,
      kelamin: kelamin,
      berat: berat,
      bangsa: bangsa,
      tanggalLahir: tanggalLahir,
      statusKesehatan: statusKesehatan,
      umur: umur,
    );
    
    final Map<String, dynamic> dataToSave = newLamb.toJson();
    
    try {
      final url = Uri.parse('$_baseUrl/users/$userId/lambs/$id.json');
      
      final response = await http.put(
        url,
        body: json.encode(dataToSave),
      );

      if (response.statusCode >= 400) {
          throw Exception('Gagal menyimpan data hewan ternak. Status: ${response.statusCode}');
      }
    
      state = const AsyncValue.data(null);

      ref.watch(livestockFetchProvider.notifier).refreshLambs();
      
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}