import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:screening_tools_android/app/exceptions/handler.dart';
import 'package:screening_tools_android/app/utils/utils.dart';

part 'patient_controller.dart';

class Patient {
  String id;
  String name;
  String age;
  String gender;
  String phone;
  String responsiblePerson;
  String createdAt;
  Patient({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.phone,
    required this.responsiblePerson,
    required this.createdAt,
  });

  Patient copyWith({
    String? id,
    String? name,
    String? age,
    String? gender,
    String? phone,
    String? responsiblePerson,
    String? createdAt,
  }) {
    return Patient(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
      responsiblePerson: responsiblePerson ?? this.responsiblePerson,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'gender': gender,
      'phone': phone,
      'responsible_person': responsiblePerson,
      'created_at': createdAt,
    };
  }

  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      age: map['age'] ?? '',
      gender: map['gender'] ?? '',
      phone: map['phone'],
      responsiblePerson: map['responsible_person'] ?? '',
      createdAt: map['created_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Patient.fromJson(String source) => Patient.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Patient(id: $id, name: $name, age: $age, gender: $gender, phone: $phone, responsiblePerson: $responsiblePerson, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Patient && other.id == id && other.name == name && other.age == age && other.gender == gender && other.phone == phone && other.responsiblePerson == responsiblePerson && other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ age.hashCode ^ gender.hashCode ^ phone.hashCode ^ responsiblePerson.hashCode ^ createdAt.hashCode;
  }
}
