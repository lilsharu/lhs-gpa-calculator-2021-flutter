import 'package:decimal/decimal.dart';
import 'package:flutter/foundation.dart';

import './class_number.dart';
import './department.dart';

class Class {
  String name;
  Decimal credits;
  ClassLevel level;
  Department department;
  ClassLength length;
  ClassNumber classNumber;
  bool isCore;
  bool isElective;

  Class({
    @required this.name,
    @required this.credits,
    @required this.level,
    @required this.department,
    @required this.length,
    @required this.classNumber,
    this.isElective = false,
  }) {
    updateCoreStatus();
  }

  Class.empty();

  ClassNumber get getClassNumber => classNumber;

  Decimal get getCredits => credits;

  Department get getDepartment => department;

  bool get getIsCore => isCore;

  bool get getIsElective => isElective;

  ClassLength get getLength => length;

  ClassLevel get getLevel => level;

  String get getName => name;

  set setClassNumber(ClassNumber classNumber) => this.classNumber = classNumber;

  set setCredits(Decimal credits) => this.credits = credits;

  set setDepartment(Department department) => this.department = department;

  set setIsCore(bool isCore) {
    this.isCore = isCore;
    updateCoreStatus();
  }

  set setIsElective(bool isElective) {
    this.isElective = isElective;
    updateCoreStatus();
  }

  set setLength(ClassLength length) => this.length = length;

  set setLevel(ClassLevel level) {
    this.level = level;
    updateCoreStatus();
  }

  set setName(String name) => this.name = name;

  @override
  String toString() {
    return this.name;
  }

  void updateCoreStatus() {
    isCore = department.isCore() && !isElective || level == ClassLevel.AP;
  }
}

enum ClassLength {
  halfYear,
  fullYear,
}

enum ClassLevel {
  CP,
  Honors,
  AP,
}
