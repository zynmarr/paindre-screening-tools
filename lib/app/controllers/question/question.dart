import 'dart:convert';

class Question {
  String title;
  String subTitle;
  String name;
  String type;
  int value;
  Question({
    required this.title,
    required this.subTitle,
    required this.name,
    required this.type,
    required this.value,
  });

  Question copyWith({
    String? title,
    String? subTitle,
    String? name,
    String? type,
    int? value,
  }) {
    return Question(
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      name: name ?? this.name,
      type: type ?? this.type,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subTitle': subTitle,
      'name': name,
      'type': type,
      'value': value,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      title: map['title'] ?? '',
      subTitle: map['subTitle'] ?? '',
      name: map['name'] ?? '',
      type: map['type'] ?? '',
      value: map['value']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) => Question.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Question(title: $title, subTitle: $subTitle, name: $name, type: $type, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Question &&
      other.title == title &&
      other.subTitle == subTitle &&
      other.name == name &&
      other.type == type &&
      other.value == value;
  }

  @override
  int get hashCode {
    return title.hashCode ^
      subTitle.hashCode ^
      name.hashCode ^
      type.hashCode ^
      value.hashCode;
  }
}

List<Question> questions = [
  Question(
    title: "Mengetahui faktor yang dapat memperberat dan meringankan nyeri",
    subTitle: "Apakah ada hal-hal yang dapat memperberat atau memperingan nyeri yang Anda rasakan?",
    name: "Nyeri Nosiseptif",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "Nyeri yang dirasakan berkaitan dengan riwayat trauma atau disfungsi postural",
    subTitle: "Apakah nyeri yang Anda rasakan disebabkan oleh adanya trauma atau luka sebelumnya?",
    name: "Nyeri Nosiseptif",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "Nyeri yang dirasakan terlokalisir pada daerah cedera",
    subTitle: "Apakah nyeri yang Anda rasakan hanya terasa di daerah luka atau cedera?",
    name: "Nyeri Nosiseptif",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "Proses penyembuhan nyeri terjadi sesuai dengan waktu penyembuhan jaringan",
    subTitle: "Apakah Anda pernah mengalami luka di lokasi nyeri Anda saat ini?",
    name: "Nyeri Nosiseptif",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "Proses penyembuhan nyeri terjadi sesuai dengan waktu penyembuhan jaringan",
    subTitle: "Bila ada, apakah nyeri yang dirasakan hilang setelah luka Anda sembuh?",
    name: "Nyeri Nosiseptif",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "Nyeri berespon terhadap analgesik/NSAID",
    subTitle: "Apakah nyeri Anda berkurang setelah minum obat-obatan anti nyeri?(paracetamol, NSAID, dan lain-lain)",
    name: "Nyeri Nosiseptif",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "Gerakan/rangsangan mekanis menimbulkan rasa nyeri yang bersifat tajam dan sesaat",
    subTitle: "Apakah Anda merasakan nyeri tajam saat melakukan suatu gerakan, dan hanya berlangsung sesaat?",
    name: "Nyeri Nosiseptif",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "Nyeri yang dirasakan berhubungan dengan gejala inflamasi (seperti: bengkak, kemerahan dan panas)",
    subTitle: "Apakah terdapat bengkak, kemerahan, dan rasa panas pada lokasi nyeri Anda?",
    name: "Nyeri Nosiseptif",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "Nyeri timbul baru-baru ini",
    subTitle: "Apakah nyeri yang Anda rasakan berlangsung belum lama?(kurang dari 3 bulan)",
    name: "Nyeri Nosiseptif",
    type: "Subjective",
    value: 1,
  ),
  // Physical examination
  Question(
    title: "Pada pergerakan, nyeri yang dirasakan jelas dan sesuai dengan anatomis",
    subTitle: "",
    name: "Nyeri Nosiseptif",
    type: "Physical examination",
    value: 1,
  ),
  Question(
    title: "Pada palpasi, nyeri tekan dirasakan terlokalisir pada daerah cedera",
    subTitle: "",
    name: "Nyeri Nosiseptif",
    type: "Physical examination",
    value: 1,
  ),

  // Nyeri Neuropatik
  Question(
    title: "Nyeri yang dirasakan seperti sensasi terbakar, tajam, tersengat listrik atau tersetrum",
    subTitle: "Apakah Anda merasakan nyeri seperti sensasi terbakar, tajam, tersengat listrik atau tersetrum?",
    name: "Nyeri Neuropatik",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "Nyeri yang dirasakan diakibatkan oleh riwayat cedera secara mekanis atau patologis",
    subTitle: "Apakah Anda pernah mengalami cidera atau luka pada saraf sebelumnya?",
    name: "Nyeri Neuropatik",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "Nyeri yang dirasakan diakibatkan oleh riwayat cedera secara mekanis atau patologis",
    subTitle: "Apakah nyeri yang Anda rasakan disertai oleh rasa kebas, kesemutan, dan terasa tebal?",
    name: "Nyeri Neuropatik",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "Nyeri yang dirasakan sedikit memberikan respon terhadap analgesik/NSAID dan lebih berespon terhadap anti kejang atau anti depresan",
    subTitle: "Apakah obat-obatan seperti paracetamol dan NSAID dapat mengurangi nyeri Anda secara signifikan",
    name: "Nyeri Neuropatik",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "Apabila terstimulasi, maka dibutuhkan waktu yang lama untuk nyeri tersebut menghilang",
    subTitle: "Apabila ada tindakan yang menimbulkan nyeri di tubuh Anda, apakah dibutuhkan waktu yang lama sampai nyeri tersebut menghilamg?",
    name: "Nyeri Neuropatik",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "Adanya pola mekanik terhadap faktor yang memperberat dan meringankan nyeri termasuk aktivitas/postur yang berhubungan dengan gerakan atau kompresi pada jaringan saraf",
    subTitle: "Apakah ada gerakan tertentu, seperti berdiri tegak, membungkuk ke depan atau belakang, memutar pinggang, atau menggerakkan pinggang ke kiri dan ke kanan, dapat memperberat atau memperingan nyeri yang Anda rasakan?",
    name: "Nyeri Neuropatik",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "Nyeri yang dirasakan berhubungan dengan gejala distesia (seperti: gatal atau terasa seperti ada yang merayap)",
    subTitle: "Apakah nyeri yang Anda rakan terasa gatal atau seperti ada yang merayap?",
    name: "Nyeri Neuropatik",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "Nyeri yang dirasakan terjadi secara spontan dan memberat",
    subTitle: "Apakah nyeri Anda terasa lebih berat bila Anda sedang sedih, marah, stres, atau sedang bermasalah dengan orang lain?",
    name: "Nyeri Neuropatik",
    type: "Subjective",
    value: 1,
  ),
  //Physical examination
  Question(
    title: "Nyeri memberat dengan tes pergerakan, diantaranya pergerakan aktif/pasif, Neurodinamik dengan tes SLR dan tes Plexus Brachialis",
    subTitle: "",
    name: "Nyeri Neuropatik",
    type: "Physical examination",
    value: 1,
  ),
  Question(
    title: "Nyeri timbul dengan palpasi pada jaringan saraf yang cedera",
    subTitle: "",
    name: "Nyeri Neuropatik",
    type: "Physical examination",
    value: 1,
  ),
  Question(
    title: "Pemeriksaan neurologis didapatkan gangguan reflex, sensasi dan kekuatan otot menurun yang terdistribusi secara dermatom",
    subTitle: "",
    name: "Nyeri Neuropatik",
    type: "Physical examination",
    value: 1,
  ),
  Question(
    title: "Ditemukannya gerakan antalgik",
    subTitle: "",
    name: "Nyeri Neuropatik",
    type: "Physical examination",
    value: 1,
  ),
  Question(
    title: "Ditemukannya hiperalgesia atau alodinia",
    subTitle: "",
    name: "Nyeri Neuropatik",
    type: "Physical examination",
    value: 1,
  ),

  //Nyeri Sensitisasi Sentral
  Question(
    title: "Ketidaksesuaian antara nyeri yang dirasakan dengan aktivitas yang dilakukan",
    subTitle: "Apakah Anda merasakan nyeri bila melakukan gerakangerakan ringan?",
    name: "Nyeri Sensitisasi Sentral",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "Nyeri yang dirasakan tidak dipengaruhi oleh faktor mekanis (beban)",
    subTitle: "Apakah Anda merasakan nyeri tidak sedang melakukan suatu gerakan?",
    name: "Nyeri Sensitisasi Sentral",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "Nyeri yang terjadi tidak dapat diprediksikan polanya terhadap provokasi yang dilakukan",
    subTitle: "Apakah Anda bisa merasakan nyeri yang yang timbul kapan saja?",
    name: "Nyeri Sensitisasi Sentral",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "Nyeri yang dirasakan menetap melebihi waktu penyembuhan jaringan",
    subTitle: "Apakah nyeri tetap dirasakan walaupun luka yang Anda alami sudah sembuh?",
    name: "Nyeri Sensitisasi Sentral",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "Nyeri yang dirasakan disproporsional terhadap sifat atau patologi cedera",
    subTitle: "Apakah Anda merasakan nyeri yang berat pada kondisi luka atau cedera yang ringan?",
    name: "Nyeri Sensitisasi Sentral",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "Nyeri yang dirasakan terdistribusi secara luas dan tidak sesuai anatomis",
    subTitle: "Apakah Anda merasakan nyeri di banyak atau hampir seluruh bagian tubuh?",
    name: "Nyeri Sensitisasi Sentral",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "Nyeri berhubungan dengan gangguan psikososial (seperti: emosi negatif, kurang percaya diri, masalah dalam hubungan keluarga/pekerjaan/lingkungan)",
    subTitle: "Apakah nyeri Anda terasa lebih berat bila Anda sedang sedih, marah, stres, atau sedang bermasalah dengan orang lain?",
    name: "Nyeri Sensitisasi Sentral",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "Pemberian analgesik/NSAID tidak menghasilkan respon yang diharapkan dan atau pemberian anti epileptik (seperti Gabapenin, Pregabalin)/anti-depresan (seperti Amitriptilin) lebih baik dalam mengurangi nyeri",
    subTitle: "",
    name: "Nyeri Sensitisasi Sentral",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "Nyeri yang dirasakan berhubungan dengan disabilitas fungsional",
    subTitle: "Apakah nyeri menyebabkan terganggunya semua kegiatan Anda?",
    name: "Nyeri Sensitisasi Sentral",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "Nyeri timbul pada malam hari yang menyebabkan gangguan tidur",
    subTitle: "Apakah nyeri mengganggu tidur Anda?",
    name: "Nyeri Sensitisasi Sentral",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "Nyeri yang dirasakan berhubungan dengan gejala distesia (seperti: dingin, menjalar atau seperti ada yang merayap)",
    subTitle: "Apakah nyeri Anda terasa seperti dingin, menjalar, atau seperti ada yang merayap?",
    name: "Nyeri Sensitisasi Sentral",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "Apabila nyeri terstimulasi, maka dibutuhkan waktu yang lama untuk nyeri tersebut menghilang",
    subTitle: "Apakah nyeri Anda mudah terjadi, dan butuh waktu yang lama sebelum menghilang?",
    name: "Nyeri Sensitisasi Sentral",
    type: "Subjective",
    value: 1,
  ),
  //Physical examination
  Question(
    title: "Uji gerak dapat menyebabkan nyeri yang tidak proporsional",
    subTitle: "",
    name: "Nyeri Sensitisasi Sentral",
    type: "Physical examination",
    value: 1,
  ),
  Question(
    title: "Uji gerak dapat menyebabkan nyeri yang tidak konsisten",
    subTitle: "",
    name: "Nyeri Sensitisasi Sentral",
    type: "Physical examination",
    value: 1,
  ),
  Question(
    title: "Uji gerak dapat menyebabkan nyeri yang non mekanik atau non anatomis",
    subTitle: "",
    name: "Nyeri Sensitisasi Sentral",
    type: "Physical examination",
    value: 1,
  ),
  Question(
    title: "HIperalgesia (primer, sekunder)",
    subTitle: "",
    name: "Nyeri Sensitisasi Sentral",
    type: "Physical examination",
    value: 1,
  ),
  Question(
    title: "Alodinia",
    subTitle: "",
    name: "Nyeri Sensitisasi Sentral",
    type: "Physical examination",
    value: 1,
  ),
  Question(
    title: "HIperpatia",
    subTitle: "",
    name: "Nyeri Sensitisasi Sentral",
    type: "Physical examination",
    value: 1,
  ),
];
