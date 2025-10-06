import 'package:digifarm/livestock/models/lamb.dart';

final List<Lamb> dummyLambs = [
  // Domba 1: Pejantan Garut Sehat
  Lamb(
    id: 'GRT001', // 6 karakter
    kelamin: Gender.pejantan,
    berat: 35.5,
    ras: Breed.garut,
    tanggaLahir: DateTime(2023, 5, 10),
    umur: 18, 
    statusKesehatan: StatusKesehatan.sehat,
  ),

  // Domba 2: Betina Ekor Tipis Sakit Berat
  Lamb(
    id: 'ETT002', // 6 karakter
    kelamin: Gender.betina,
    berat: 28.0,
    ras: Breed.ekorTipis,
    umur: 12, 
    statusKesehatan: StatusKesehatan.sakitBerat,
  ),

  // Domba 3: Pejantan Suffolk Dalam Perawatan
  Lamb(
    id: 'SFK003', // 6 karakter
    kelamin: Gender.pejantan,
    berat: 50.2,
    ras: Breed.suffolk,
    tanggaLahir: DateTime(2022, 11, 25),
    umur: 22, 
    statusKesehatan: StatusKesehatan.dalamPerawatan,
  ),

  // Domba 4: Betina Priangan Penyembuhan
  Lamb(
    id: 'PRG004', // 6 karakter
    kelamin: Gender.betina,
    berat: 20.7,
    ras: Breed.priangan,
    tanggaLahir: DateTime(2024, 1, 15),
    umur: 8, 
    statusKesehatan: StatusKesehatan.penyembuhan,
  ),

  // Domba 5: Betina Dorset Sakit Ringan
  Lamb(
    id: 'DST005', // 6 karakter
    kelamin: Gender.betina,
    berat: null, // Masih menggunakan null untuk variasi
    ras: Breed.dorset,
    tanggaLahir: DateTime(2023, 9, 1),
    umur: 13, 
    statusKesehatan: StatusKesehatan.sakitRingan,
  ),

  // Domba 6: Pejantan Garut
// Lanjutan dari List<Lamb> dummyLambs:

// Domba 6: Pejantan Garut
  Lamb(
    id: 'GRT006',
    kelamin: Gender.pejantan,
    berat: 42.0,
    ras: Breed.garut,
    tanggaLahir: DateTime(2023, 7, 1),
    umur: 15,
    statusKesehatan: StatusKesehatan.sehat,
  ),

// Domba 7: Betina Ekor Tipis
  Lamb(
    id: 'ETT007',
    kelamin: Gender.betina,
    berat: 31.2,
    ras: Breed.ekorTipis,
    tanggaLahir: DateTime(2024, 3, 15),
    umur: 6,
    statusKesehatan: StatusKesehatan.sehat,
  ),

// Domba 8: Pejantan Suffolk Sakit Berat
  Lamb(
    id: 'SFK008',
    kelamin: Gender.pejantan,
    berat: 55.0,
    ras: Breed.suffolk,
    tanggaLahir: DateTime(2022, 5, 5),
    umur: 29,
    statusKesehatan: StatusKesehatan.sakitBerat,
  ),

// Domba 9: Betina Priangan Penyembuhan
  Lamb(
    id: 'PRG009',
    kelamin: Gender.betina,
    berat: 24.5,
    ras: Breed.priangan,
    tanggaLahir: DateTime(2024, 7, 20),
    umur: 2,
    statusKesehatan: StatusKesehatan.penyembuhan,
  ),

// Domba 10: Pejantan Garut Sehat
  Lamb(
    id: 'GRT010',
    kelamin: Gender.pejantan,
    berat: 39.8,
    ras: Breed.garut,
    tanggaLahir: DateTime(2023, 12, 1),
    umur: 9,
    statusKesehatan: StatusKesehatan.sehat,
  ),

// Domba 11: Betina Ekor Tipis Dalam Perawatan
  Lamb(
    id: 'ETT011',
    kelamin: Gender.betina,
    berat: 29.0,
    ras: Breed.ekorTipis,
    tanggaLahir: DateTime(2023, 10, 20),
    umur: 11,
    statusKesehatan: StatusKesehatan.dalamPerawatan,
  ),

// Domba 12: Pejantan Priangan
  Lamb(
    id: 'PRG012',
    kelamin: Gender.pejantan,
    berat: 45.0,
    ras: Breed.priangan,
    tanggaLahir: DateTime(2023, 3, 3),
    umur: 31,
    statusKesehatan: StatusKesehatan.sehat,
  ),

// Domba 13: Betina Suffolk Sakit Ringan
  Lamb(
    id: 'SFK013',
    kelamin: Gender.betina,
    berat: 33.7,
    ras: Breed.suffolk,
    tanggaLahir: DateTime(2024, 2, 8),
    umur: 7,
    statusKesehatan: StatusKesehatan.sakitRingan,
  ),

// Domba 14: Pejantan Dorset
  Lamb(
    id: 'DST014',
    kelamin: Gender.pejantan,
    berat: 60.1,
    ras: Breed.dorset,
    tanggaLahir: DateTime(2022, 10, 1),
    umur: 36,
    statusKesehatan: StatusKesehatan.sehat,
  ),

// Domba 15: Betina Garut Sehat
  Lamb(
    id: 'GRT015',
    kelamin: Gender.betina,
    berat: 38.0,
    ras: Breed.garut,
    tanggaLahir: DateTime(2023, 1, 20),
    umur: 33,
    statusKesehatan: StatusKesehatan.sehat,
  ),

// Domba 16: Pejantan Ekor Tipis Penyembuhan
  Lamb(
    id: 'ETT016',
    kelamin: Gender.pejantan,
    berat: 30.5,
    ras: Breed.ekorTipis,
    tanggaLahir: DateTime(2024, 5, 12),
    umur: 4,
    statusKesehatan: StatusKesehatan.penyembuhan,
  ),

// Domba 17: Betina Priangan
  Lamb(
    id: 'PRG017',
    kelamin: Gender.betina,
    berat: 22.0,
    ras: Breed.priangan,
    tanggaLahir: DateTime(2024, 8, 1),
    umur: 1,
    statusKesehatan: StatusKesehatan.sehat,
  ),

// Domba 18: Pejantan Suffolk Sakit Ringan
  Lamb(
    id: 'SFK018',
    kelamin: Gender.pejantan,
    berat: 48.0,
    ras: Breed.suffolk,
    tanggaLahir: DateTime(2023, 4, 15),
    umur: 24,
    statusKesehatan: StatusKesehatan.sakitRingan,
  ),
];