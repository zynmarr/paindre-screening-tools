// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:screening_tools_android/app/controllers/scoring_result/scoring_result.dart';
import 'package:screening_tools_android/app/utils/utils.dart';

part 'patient_controller.dart';

class Patient {
  String id;
  String name;
  String age;
  String gender;
  String phone;
  String responsiblePerson;
  String userID;
  String diagnostic;
  String createdAt;
  Patient({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.phone,
    required this.responsiblePerson,
    required this.userID,
    required this.diagnostic,
    required this.createdAt,
  });

  Patient copyWith({
    String? id,
    String? name,
    String? age,
    String? gender,
    String? phone,
    String? responsiblePerson,
    String? userID,
    String? diagnostic,
    String? createdAt,
  }) {
    return Patient(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
      responsiblePerson: responsiblePerson ?? this.responsiblePerson,
      userID: userID ?? this.userID,
      diagnostic: diagnostic ?? this.diagnostic,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'age': age,
      'gender': gender,
      'phone': phone,
      'responsible_person': responsiblePerson,
      'user_id': userID,
      'diagnostic': diagnostic,
      'created_at': createdAt,
    };
  }

  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      id: map['id'] as String,
      name: map['name'] as String,
      age: map['age'] as String,
      gender: map['gender'] as String,
      phone: map['phone'] as String,
      responsiblePerson: map['responsible_person'] as String,
      userID: map['user_id'] as String,
      diagnostic: map['diagnostic'] as String,
      createdAt: map['created_at'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Patient.fromJson(String source) => Patient.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Patient(id: $id, name: $name, age: $age, gender: $gender, phone: $phone, responsiblePerson: $responsiblePerson, userID: $userID, diagnostic: $diagnostic, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant Patient other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.age == age &&
        other.gender == gender &&
        other.phone == phone &&
        other.responsiblePerson == responsiblePerson &&
        other.userID == userID &&
        other.diagnostic == diagnostic &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        age.hashCode ^
        gender.hashCode ^
        phone.hashCode ^
        responsiblePerson.hashCode ^
        userID.hashCode ^
        diagnostic.hashCode ^
        createdAt.hashCode;
  }
}
