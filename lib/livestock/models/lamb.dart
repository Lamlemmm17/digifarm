enum Gender { jantan, betina }

enum StatusKesehatan {
  sehat,
  sakitRingan,
  sakitBerat,
  dalamPerawatan,
  penyembuhan,
}

enum Breed { garut, priangan, ekorTipis, ekorGemuk, suffolk, dorset, texel }

enum Tipe { praSapih, pascaSapih, remaja, indukan }

class Lamb {
  const Lamb({
    required this.id,
    required this.tipe,
    required this.kelamin,
    required this.berat,
    required this.bangsa,
    required this.tanggalLahir,
    required this.umur,
    required this.statusKesehatan,
  });

  final String id;
  final Tipe tipe;
  final Gender kelamin;
  final String berat;
  final Breed bangsa;
  final DateTime tanggalLahir;
  final int umur;
  final StatusKesehatan statusKesehatan;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tipe': tipe.name,
      'kelamin': kelamin.name,
      'berat': berat,
      'bangsa': bangsa.name,
      'tanggalLahir': tanggalLahir.toIso8601String(),
      'statusKesehatan': statusKesehatan.name,
      'umur': umur,
    };
  }

  factory Lamb.fromJson(Map<String, dynamic> json) {
    return Lamb(
      id: json['id'] as String,
      tipe: Tipe.values.firstWhere(
        (e) => e.name == json['tipe'],
        orElse: () => Tipe.praSapih,
      ),
      kelamin: Gender.values.firstWhere(
        (e) => e.name == json['kelamin'],
        orElse: () => Gender.jantan,
      ),
      berat: json['berat'] as String,
      bangsa: Breed.values.firstWhere(
        (e) => e.name == json['bangsa'],
        orElse: () => Breed.garut,
      ),
      tanggalLahir: DateTime.parse(json['tanggalLahir'] as String)
          ,
      statusKesehatan: StatusKesehatan.values.firstWhere(
        (e) => e.name == json['statusKesehatan'],
        orElse: () => StatusKesehatan.sehat,
      ),
      umur: json['umur'] as int,
    );
  }

  String get displayGender {
    switch (kelamin) {
      case Gender.betina:
        return 'Betina';
      case Gender.jantan:
        return 'Jantan';
    }
  }

  String get displayKesehatan {
    switch (statusKesehatan) {
      case StatusKesehatan.sehat:
        return 'Sehat';
      case StatusKesehatan.sakitRingan:
        return 'Sakit Ringan';
      case StatusKesehatan.sakitBerat:
        return 'Sakit Berat';
      case StatusKesehatan.penyembuhan:
        return 'Dalam Penyembuhan';
      case StatusKesehatan.dalamPerawatan:
        return 'Dalam Perawatan';
    }
  }

  String get displayBangsa {
    switch (bangsa) {
      case Breed.dorset:
        return 'Dorset';
      case Breed.ekorGemuk:
        return 'Ekor Gemuk';
      case Breed.ekorTipis:
        return 'Ekor Tipis';
      case Breed.garut:
        return 'Garut';
      case Breed.priangan:
        return 'Priangan';
      case Breed.suffolk:
        return 'Suffolk';
      case Breed.texel:
        return 'Texel';
    }
  }

  String get displayUmur {
    if (umur == 0) {
      return 'Baru Lahir';
    }

    final tahun = umur ~/ 12; 
    final bulan = umur % 12; 

    if (tahun > 0 && bulan > 0) {
      return '$tahun tahun $bulan bulan';
    } else if (tahun > 0) {
      return '$tahun tahun';
    } else {
      return '$bulan bulan';
    }
  }
}

extension StringCasingExtension on String {
  String toTitleCaseWithSpaces() {
    if (isEmpty) return '';

    String temp = replaceAllMapped(
      RegExp(r'([a-z])([A-Z])'),
      (Match m) => '${m[1]} ${m[2]}',
    );

    return temp[0].toUpperCase() + temp.substring(1);
  }
}
