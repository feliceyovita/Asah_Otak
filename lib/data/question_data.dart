import '../models/question.dart';

class QuestionData {
  // Matematika
  static const math = [
    Question(
      text: 'Hasil dari 12 × 8 adalah...',
      options: ['80', '88', '96', '108'],
      correctIndex: 2, // 96
    ),
    Question(
      text: 'Jika 3x + 5 = 20, maka nilai x adalah...',
      options: ['3', '5', '7', '10'],
      correctIndex: 1, // 5
    ),
    Question(
      text: 'Berapakah akar kuadrat dari 169?',
      options: ['11', '12', '13', '14'],
      correctIndex: 2, // 13
    ),
    Question(
      text: '50% dari 240 adalah...',
      options: ['100', '110', '120', '130'],
      correctIndex: 2, // 120
    ),
    Question(
      text: 'Luas persegi dengan sisi 12 cm adalah...',
      options: ['100', '156', '120', '144'],
      correctIndex: 3, // 144
    ),
  ];

  // IPA
  static const ipa = [
    Question(
      text: 'Zat yang paling banyak di atmosfer Bumi adalah...',
      options: ['Oksigen', 'Nitrogen', 'Karbon dioksida', 'Hidrogen'],
      correctIndex: 1, // Nitrogen
    ),
    Question(
      text: 'Air pada tekanan 1 atm mendidih pada suhu...',
      options: ['80°C', '90°C', '100°C', '120°C'],
      correctIndex: 2, // 100°C
    ),
    Question(
      text: 'Organ yang memompa darah ke seluruh tubuh adalah...',
      options: ['Paru-paru', 'Jantung', 'Lambung', 'Ginjal'],
      correctIndex: 1, // Jantung
    ),
    Question(
      text: 'Fotosintesis terutama terjadi pada bagian tumbuhan...',
      options: ['Akar', 'Batang', 'Daun', 'Bunga'],
      correctIndex: 2, // Daun
    ),
    Question(
      text: 'Perubahan wujud dari gas menjadi cair disebut...',
      options: ['Menguap', 'Membeku', 'Mengembun', 'Menyublim'],
      correctIndex: 2, // Mengembun
    ),
  ];

  // Bahasa Inggris
  static const english = [
    Question(
      text: 'Choose the correct past form of "go":',
      options: ['goes', 'went', 'gone', 'going'],
      correctIndex: 1, // went
    ),
    Question(
      text: 'Fill in the blank: She ___ a student.',
      options: ['am', 'is', 'are', 'be'],
      correctIndex: 1, // is
    ),
    Question(
      text: 'Synonym of "big" is...',
      options: ['tiny', 'huge', 'thin', 'short'],
      correctIndex: 1, // huge
    ),
    Question(
      text: 'Antonym of "happy" is...',
      options: ['sad', 'glad', 'joyful', 'delighted'],
      correctIndex: 0, // sad
    ),
    Question(
      text: 'Plural form of "child" is...',
      options: ['childs', 'childes', 'children', 'childrens'],
      correctIndex: 2, // children
    ),
  ];

  // Geografi
  static const geography = [
    Question(
      text: 'Ibukota provinsi Jawa Barat adalah...',
      options: ['Bogor', 'Bandung', 'Bekasi', 'Cirebon'],
      correctIndex: 1, // Bandung
    ),
    Question(
      text: 'Benua terbesar di dunia adalah...',
      options: ['Afrika', 'Asia', 'Amerika', 'Eropa'],
      correctIndex: 1, // Asia
    ),
    Question(
      text: 'Samudra terluas di dunia adalah...',
      options: ['Hindia', 'Atlantik', 'Pasifik', 'Arktik'],
      correctIndex: 2, // Pasifik
    ),
    Question(
      text: 'Garis khayal 0° disebut...',
      options: ['Garis Bujur', 'Garis Lintang', 'Khatulistiwa', 'Tropis'],
      correctIndex: 2, // Khatulistiwa
    ),
    Question(
      text: 'Letusan gunung berapi mengeluarkan...',
      options: ['Lahar & lava', 'Salju', 'Hujan asam saja', 'Ombak'],
      correctIndex: 0, // Lahar & lava
    ),
  ];

  // Sejarah
  static const history = [
    Question(
      text: 'Proklamasi Kemerdekaan Indonesia terjadi pada tahun...',
      options: ['1942', '1945', '1947', '1950'],
      correctIndex: 1, // 1945
    ),
    Question(
      text: 'Tokoh perumus Pancasila adalah...',
      options: ['Moh. Hatta', 'Soekarno', 'Sutan Sjahrir', 'Tan Malaka'],
      correctIndex: 1, // Soekarno
    ),
    Question(
      text: 'Kerajaan Hindu-Buddha tertua di Indonesia adalah...',
      options: ['Majapahit', 'Tarumanegara', 'Sriwijaya', 'Kutai'],
      correctIndex: 3, // Kutai
    ),
    Question(
      text: 'Sumpah Pemuda diikrarkan pada tahun...',
      options: ['1908', '1928', '1945', '1965'],
      correctIndex: 1, // 1928
    ),
    Question(
      text: 'VOC (Belanda) dibubarkan pada tahun...',
      options: ['1602', '1700', '1799', '1820'],
      correctIndex: 2, // 1799
    ),
  ];

  // Budaya dan Seni
  static const arts = [
    Question(
      text: 'Batik diakui UNESCO sebagai Warisan Budaya Dunia pada tahun...',
      options: ['2005', '2009', '2012', '2015'],
      correctIndex: 1, // 2009
    ),
    Question(
      text: 'Angklung berasal dari provinsi...',
      options: ['Jawa Barat', 'Jawa Tengah', 'Bali', 'Sumatera Barat'],
      correctIndex: 0, // Jawa Barat
    ),
    Question(
      text: 'Tari Kecak berasal dari...',
      options: ['Aceh', 'Bali', 'Papua', 'Sulawesi Selatan'],
      correctIndex: 1, // Bali
    ),
    Question(
      text: 'Wayang kulit menggunakan bahan utama...',
      options: ['Kain', 'Kulit', 'Kertas', 'Kayu'],
      correctIndex: 1, // Kulit
    ),
    Question(
      text: 'Alat musik daerah Minangkabau bernama...',
      options: ['Sasando', 'Talempong', 'Tifa', 'Gamelan'],
      correctIndex: 1, // Talempong
    ),
  ];

  // Kuliner Dunia
  static const cuisine = [
    Question(
      text: 'Sushi berasal dari negara...',
      options: ['Korea Selatan', 'Jepang', 'Tiongkok', 'Thailand'],
      correctIndex: 1, // Jepang
    ),
    Question(
      text: 'Pizza Margherita identik dengan bendera negara...',
      options: ['Italia', 'Spanyol', 'Prancis', 'Portugal'],
      correctIndex: 0, // Italia
    ),
    Question(
      text: 'Taco adalah makanan khas...',
      options: ['Meksiko', 'Brasil', 'Argentina', 'Peru'],
      correctIndex: 0, // Meksiko
    ),
    Question(
      text: 'Kimchi terbuat terutama dari...',
      options: ['Kubis/sawei', 'Kacang kedelai', 'Ikan', 'Kentang'],
      correctIndex: 0, // Kubis
    ),
    Question(
      text: 'Ratatouille berasal dari...',
      options: ['Prancis', 'Jerman', 'Belgia', 'Swiss'],
      correctIndex: 0, // Prancis
    ),
  ];

  // Olahraga
  static const sports = [
    Question(
      text: 'Jumlah pemain sepak bola dalam satu tim di lapangan adalah...',
      options: ['9', '10', '11', '12'],
      correctIndex: 2, // 11
    ),
    Question(
      text: 'Raket dan shuttlecock digunakan dalam olahraga...',
      options: ['Tenis', 'Bulu tangkis', 'Squash', 'Pingpong'],
      correctIndex: 1, // Bulu tangkis
    ),
    Question(
      text: 'Pertandingan basket resmi berlangsung selama...',
      options: ['2×20 menit', '4×10 menit', '3×12 menit', '4×12 menit'],
      correctIndex: 1, // FIBA 4x10
    ),
    Question(
      text: 'Grand Slam yang dimainkan di lapangan rumput adalah...',
      options: ['Australian Open', 'Roland Garros', 'Wimbledon', 'US Open'],
      correctIndex: 2, // Wimbledon
    ),
    Question(
      text: 'Dalam atletik, lari jarak 42,195 km disebut...',
      options: ['Sprint', 'Maraton', 'Lari gawang', 'Lari estafet'],
      correctIndex: 1, // Maraton
    ),
  ];

  // Peta kategori ke soal
  static const byCategory = {
    'Matematika': math,
    'IPA': ipa,
    'Bahasa Inggris': english,
    'Geografi': geography,
    'Sejarah': history,
    'Budaya & Seni': arts,
    'Kuliner Dunia': cuisine,
    'Olahraga': sports,
  };
}
