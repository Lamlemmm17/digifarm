enum Gender { pejantan, betina }

enum StatusKesehatan {
  sehat,
  sakitRingan,
  sakitBerat,
  dalamPerawatan,
  penyembuhan,
}

enum Breed { garut, priangan, ekorTipis, ekorGemuk, suffolk, dorset, texel }

class Lamb {
  Lamb({
    required this.id,
    required this.kelamin,
    this.berat,
    required this.ras,
    this.tanggaLahir,
    required this.umur,
    required this.statusKesehatan,
  });

  final String id;
  final Gender kelamin;
  final double? berat;
  final Breed ras;
  final DateTime? tanggaLahir;
  final int umur;
  final StatusKesehatan statusKesehatan;

  String get displayGender {
    switch (kelamin) {
      case Gender.betina:
        return 'Betina';
      case Gender.pejantan:
        return 'Pejantan';
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

  String get displayRas {
    switch (ras) {
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
}
