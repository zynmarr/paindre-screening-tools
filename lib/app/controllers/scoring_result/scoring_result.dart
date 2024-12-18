import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:screening_tools_android/app/exceptions/handler.dart';
import 'package:screening_tools_android/app/utils/utils.dart';

part 'scoring_result_controller.dart';
class ScoringResult {
  String id;
  String type;
  String value;
  String idPatient;
  ScoringResult({
    required this.id,
    required this.type,
    required this.value,
    required this.idPatient,
  });

  ScoringResult copyWith({
    String? id,
    String? type,
    String? value,
    String? idPatient,
  }) {
    return ScoringResult(
      id: id ?? this.id,
      type: type ?? this.type,
      value: value ?? this.value,
      idPatient: idPatient ?? this.idPatient,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'value': value,
      'id_patient': idPatient,
    };
  }

  factory ScoringResult.fromMap(Map<String, dynamic> map) {
    return ScoringResult(
      id: map['id'] ?? 0,
      type: map['type'] ?? '',
      value: map['value'] ?? '',
      idPatient: map['id_patient'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ScoringResult.fromJson(String source) => ScoringResult.fromMap(json.decode(source));

  @override
  String toString() => 'ScoringResult(id: $id, type: $type, value: $value, id_patient: $idPatient)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ScoringResult &&
      other.id == id &&
      other.type == type &&
      other.value == value &&
      other.idPatient == idPatient;
  }

  @override
  int get hashCode => id.hashCode ^ type.hashCode ^ value.hashCode ^ idPatient.hashCode;
}
