import 'package:digifarm/livestock/models/lamb.dart';

enum TipeKandang {
  kandangBunting,
  kandangKawin,
  kandangMenyusui,
  kandangSapihan,
  kandangPejantan,
}

class Flock {
  const Flock({
    required this.id,
    required this.tipeKandang,
    required this.hewanTernak,
  });
  final String id;
  final TipeKandang tipeKandang;
  final List<Lamb> hewanTernak;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tipeKandang': tipeKandang.name,
      'hewanTernak': hewanTernak.map((lamb) => lamb.toJson()).toList(),
    };
  }

  factory Flock.fromJson(Map<String, dynamic> json) {
  
  // 1. Ambil data hewanTernak sebagai Map<String, dynamic> yang nullable
  // Ini menangani kasus RTDB menyimpannya sebagai Map ({ID_unik: {...}})
  final Map<String, dynamic>? hewanTernakMap = 
      json['hewanTernak'] is Map ? (json['hewanTernak'] as Map<String, dynamic>) : null;

  List<Lamb> loadedLambs = [];

  if (hewanTernakMap != null) {
    loadedLambs = hewanTernakMap.values
        .map((value) => Lamb.fromJson(value as Map<String, dynamic>))
        .toList();
  } 
  
  else if (json['hewanTernak'] is List) {
     loadedLambs = (json['hewanTernak'] as List<dynamic>)
        .map((lambJson) => Lamb.fromJson(lambJson as Map<String, dynamic>))
        .toList();
  }

  return Flock(
    id: json['id'] as String,
    tipeKandang: TipeKandang.values.firstWhere(
      (e) => e.name == json['tipeKandang'],
      orElse: () => TipeKandang.values.first,
    ),
    hewanTernak: loadedLambs, 
  );
}

  String get displayTipeKandang {
    switch (tipeKandang) {
      case TipeKandang.kandangBunting:
        return 'Kandang Bunting';
      case TipeKandang.kandangKawin:
        return 'Kandang Kawin';
      case TipeKandang.kandangMenyusui:
        return 'Kandang Menyusuin';
      case TipeKandang.kandangPejantan:
        return 'Kandang Pejantan';
      case TipeKandang.kandangSapihan:
        return 'Kandang Sapihan';
    }
  }
}
