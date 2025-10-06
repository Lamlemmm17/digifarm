import 'package:digifarm/livestock/models/lamb.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:digifarm/livestock/data/dummy_lambs.dart';
import 'package:flutter_riverpod/legacy.dart';


class LambsNotifier extends StateNotifier<List<Lamb>> {
  LambsNotifier() : super([]);

  void fetchLambs() {
    state = dummyLambs;
  }
}

final lambsProvider = StateNotifierProvider<LambsNotifier, List<Lamb>>((ref){
  final notifier = LambsNotifier();
  
  notifier.fetchLambs();

  return notifier;
});

final totalLambsProvider = Provider<int>((ref) {
  // Mengawasi state (List<Lamb>) dari LambNotifierProvider
  final lambs = ref.watch(lambsProvider); 
  return lambs.length;
});

// Total Pejantan
final maleLambsProvider = Provider<int>((ref) {
  final lambs = ref.watch(lambsProvider);
  return lambs.where((lamb) => lamb.kelamin == Gender.pejantan).length;
});

// Total Betina
final femaleLambsProvider = Provider<int>((ref) {
  final lambs = ref.watch(lambsProvider);
  return lambs.where((lamb) => lamb.kelamin == Gender.betina).length;
});

