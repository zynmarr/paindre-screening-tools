import 'dart:convert';

class ScoringResult {
  String type;
  String value;
  String createdAt;
  ScoringResult({
    required this.type,
    required this.value,
    required this.createdAt,
  });

  ScoringResult copyWith({
    String? type,
    String? value,
    String? createdAt,
  }) {
    return ScoringResult(
      type: type ?? this.type,
      value: value ?? this.value,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'value': value,
      'createdAt': createdAt,
    };
  }

  factory ScoringResult.fromMap(Map<String, dynamic> map) {
    return ScoringResult(
      type: map['type'] as String,
      value: map['value'] as String,
      createdAt: map['createdAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ScoringResult.fromJson(String source) => ScoringResult.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ScoringResult(type: $type, value: $value, createdAt: $createdAt)';

  @override
  bool operator ==(covariant ScoringResult other) {
    if (identical(this, other)) return true;
  
    return 
      other.type == type &&
      other.value == value &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode => type.hashCode ^ value.hashCode ^ createdAt.hashCode;
}
