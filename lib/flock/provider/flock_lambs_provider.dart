import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:digifarm/flock/provider/flock_fetch_provider.dart'; 
import 'package:digifarm/livestock/provider/livestock_fetch_provider.dart'; 
import 'package:digifarm/livestock/models/lamb.dart'; 
import 'package:digifarm/flock/models/flock.dart'; 

final flockLambsProvider = 
    FutureProvider.family<List<Lamb>, String?>((ref, idKandang) async {
  
    final allFlocks = await ref.watch(flockFetchProvider.future);
    final allLambsState = ref.watch(livestockFetchProvider);
    
    if (allLambsState.isLoading) {
        throw Exception('Data domba sedang dimuat. Coba lagi.');
    }
    
    final List<Lamb> listDomba = allLambsState.lambs;
    final List<Flock> listKandang = allFlocks;

    Set<String> dombaDalamKandang = {};

    for (final flock in listKandang){
        if (flock.id != idKandang) {
            dombaDalamKandang.addAll(flock.hewanTernak.map((lamb) => lamb.id));
        }
    }

    List<Lamb> dombaTersedia = listDomba
        .where((lamb) => !dombaDalamKandang.contains(lamb.id))
        .toList();

    if (idKandang != null) {
        try {
            final kandangSaatIni = listKandang.firstWhere((flock) => flock.id == idKandang);
            
            dombaTersedia.addAll(kandangSaatIni.hewanTernak);
            
            final uniqueMap = <String, Lamb>{};
            for (final lamb in dombaTersedia) {
                uniqueMap[lamb.id] = lamb;
            }
            dombaTersedia = uniqueMap.values.toList();
            
        } catch (e) {
             throw Exception('Kandang $idKandang tidak ditemukan: $e');
        }
    }
    return dombaTersedia;
});