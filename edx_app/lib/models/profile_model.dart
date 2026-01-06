import 'package:flutter/material.dart';

class ProfileModel {
  final String fullName;
  final String email;
  final String phone;
  final String address;
  final String birthDate;
  final String studentId;
  final String major;
  final String academicYear;
  final String group;
  final String gpa;
  final String credits;
  final String yearLevel;

  ProfileModel({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.address,
    required this.birthDate,
    required this.studentId,
    required this.major,
    required this.academicYear,
    required this.group,
    required this.gpa,
    required this.credits,
    required this.yearLevel,
  });
}