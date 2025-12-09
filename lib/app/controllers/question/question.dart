part of 'question_controller.dart';

class Question {
  String title;
  String subTitle;
  String name;
  String type;
  int value;
  Question({required this.title, required this.subTitle, required this.name, required this.type, required this.value});

  Question copyWith({String? title, String? subTitle, String? name, String? type, int? value}) {
    return Question(
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      name: name ?? this.name,
      type: type ?? this.type,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {'title': title, 'subTitle': subTitle, 'name': name, 'type': type, 'value': value};
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
    return title.hashCode ^ subTitle.hashCode ^ name.hashCode ^ type.hashCode ^ value.hashCode;
  }
}

List<Question> questions = [
  Question(
    title: "questions.nociceptive.1.title".tr,
    subTitle: "questions.nociceptive.1.subtitle".tr,
    name: "Nyeri Nosiseptif",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "questions.nociceptive.2.title".tr,
    subTitle: "questions.nociceptive.2.subtitle".tr,
    name: "Nyeri Nosiseptif",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "questions.nociceptive.3.title".tr,
    subTitle: "questions.nociceptive.3.subtitle".tr,
    name: "Nyeri Nosiseptif",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "questions.nociceptive.4.title".tr,
    subTitle: "questions.nociceptive.4.subtitle".tr,
    name: "Nyeri Nosiseptif",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "questions.nociceptive.5.title".tr,
    subTitle: "questions.nociceptive.5.subtitle".tr,
    name: "Nyeri Nosiseptif",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "questions.nociceptive.6.title".tr,
    subTitle: "questions.nociceptive.6.subtitle".tr,
    name: "Nyeri Nosiseptif",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "questions.nociceptive.7.title".tr,
    subTitle: "questions.nociceptive.7.subtitle".tr,
    name: "Nyeri Nosiseptif",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "questions.nociceptive.8.title".tr,
    subTitle: "questions.nociceptive.8.subtitle".tr,
    name: "Nyeri Nosiseptif",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "questions.nociceptive.9.title".tr,
    subTitle: "questions.nociceptive.9.subtitle".tr,
    name: "Nyeri Nosiseptif",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "questions.nociceptive.10.title".tr,
    subTitle: "questions.nociceptive.10.subtitle".tr,
    name: "Nyeri Nosiseptif",
    type: "Physical examination",
    value: 1,
  ),
  Question(
    title: "questions.nociceptive.11.title".tr,
    subTitle: "questions.nociceptive.11.subtitle".tr,
    name: "Nyeri Nosiseptif",
    type: "Physical examination",
    value: 1,
  ),
  Question(
    title: "questions.neuropathic.1.title".tr,
    subTitle: "questions.neuropathic.1.subtitle".tr,
    name: "Nyeri Neuropatik",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "questions.neuropathic.2.title".tr,
    subTitle: "questions.neuropathic.2.subtitle".tr,
    name: "Nyeri Neuropatik",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "questions.neuropathic.3.title".tr,
    subTitle: "questions.neuropathic.3.subtitle".tr,
    name: "Nyeri Neuropatik",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "questions.neuropathic.4.title".tr,
    subTitle: "questions.neuropathic.4.subtitle".tr,
    name: "Nyeri Neuropatik",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "questions.neuropathic.5.title".tr,
    subTitle: "questions.neuropathic.5.subtitle".tr,
    name: "Nyeri Neuropatik",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "questions.neuropathic.6.title".tr,
    subTitle: "questions.neuropathic.6.subtitle".tr,
    name: "Nyeri Neuropatik",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "questions.neuropathic.7.title".tr,
    subTitle: "questions.neuropathic.7.subtitle".tr,
    name: "Nyeri Neuropatik",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "questions.neuropathic.8.title".tr,
    subTitle: "questions.neuropathic.8.subtitle".tr,
    name: "Nyeri Neuropatik",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "questions.neuropathic.9.title".tr,
    subTitle: "questions.neuropathic.9.subtitle".tr,
    name: "Nyeri Neuropatik",
    type: "Physical examination",
    value: 1,
  ),
  Question(
    title: "questions.neuropathic.10.title".tr,
    subTitle: "questions.neuropathic.10.subtitle".tr,
    name: "Nyeri Neuropatik",
    type: "Physical examination",
    value: 1,
  ),
  Question(
    title: "questions.neuropathic.11.title".tr,
    subTitle: "questions.neuropathic.11.subtitle".tr,
    name: "Nyeri Neuropatik",
    type: "Physical examination",
    value: 1,
  ),
  Question(
    title: "questions.neuropathic.12.title".tr,
    subTitle: "questions.neuropathic.12.subtitle".tr,
    name: "Nyeri Neuropatik",
    type: "Physical examination",
    value: 1,
  ),
  Question(
    title: "questions.neuropathic.13.title".tr,
    subTitle: "questions.neuropathic.13.subtitle".tr,
    name: "Nyeri Neuropatik",
    type: "Physical examination",
    value: 1,
  ),
  Question(
    title: "questions.central.1.title".tr,
    subTitle: "questions.central.1.subtitle".tr,
    name: "Nyeri Sensitisasi Sentral",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "questions.central.2.title".tr,
    subTitle: "questions.central.2.subtitle".tr,
    name: "Nyeri Sensitisasi Sentral",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "questions.central.3.title".tr,
    subTitle: "questions.central.3.subtitle".tr,
    name: "Nyeri Sensitisasi Sentral",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "questions.central.4.title".tr,
    subTitle: "questions.central.4.subtitle".tr,
    name: "Nyeri Sensitisasi Sentral",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "questions.central.5.title".tr,
    subTitle: "questions.central.5.subtitle".tr,
    name: "Nyeri Sensitisasi Sentral",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "questions.central.6.title".tr,
    subTitle: "questions.central.6.subtitle".tr,
    name: "Nyeri Sensitisasi Sentral",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "questions.central.7.title".tr,
    subTitle: "questions.central.7.subtitle".tr,
    name: "Nyeri Sensitisasi Sentral",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "questions.central.8.title".tr,
    subTitle: "questions.central.8.subtitle".tr,
    name: "Nyeri Sensitisasi Sentral",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "questions.central.9.title".tr,
    subTitle: "questions.central.9.subtitle".tr,
    name: "Nyeri Sensitisasi Sentral",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "questions.central.10.title".tr,
    subTitle: "questions.central.10.subtitle".tr,
    name: "Nyeri Sensitisasi Sentral",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "questions.central.11.title".tr,
    subTitle: "questions.central.11.subtitle".tr,
    name: "Nyeri Sensitisasi Sentral",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "questions.central.12.title".tr,
    subTitle: "questions.central.12.subtitle".tr,
    name: "Nyeri Sensitisasi Sentral",
    type: "Subjective",
    value: 1,
  ),
  Question(
    title: "questions.central.13.title".tr,
    subTitle: "questions.central.13.subtitle".tr,
    name: "Nyeri Sensitisasi Sentral",
    type: "Physical examination",
    value: 1,
  ),
  Question(
    title: "questions.central.14.title".tr,
    subTitle: "questions.central.14.subtitle".tr,
    name: "Nyeri Sensitisasi Sentral",
    type: "Physical examination",
    value: 1,
  ),
  Question(
    title: "questions.central.15.title".tr,
    subTitle: "questions.central.15.subtitle".tr,
    name: "Nyeri Sensitisasi Sentral",
    type: "Physical examination",
    value: 1,
  ),
  Question(
    title: "questions.central.16.title".tr,
    subTitle: "questions.central.16.subtitle".tr,
    name: "Nyeri Sensitisasi Sentral",
    type: "Physical examination",
    value: 1,
  ),
  Question(
    title: "questions.central.17.title".tr,
    subTitle: "questions.central.17.subtitle".tr,
    name: "Nyeri Sensitisasi Sentral",
    type: "Physical examination",
    value: 1,
  ),
  Question(
    title: "questions.central.18.title".tr,
    subTitle: "questions.central.18.subtitle".tr,
    name: "Nyeri Sensitisasi Sentral",
    type: "Physical examination",
    value: 1,
  ),
];
