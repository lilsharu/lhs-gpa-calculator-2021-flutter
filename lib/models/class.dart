import 'package:decimal/decimal.dart';
import 'package:flutter/foundation.dart';

import './class_number.dart';
import './department.dart';

enum ClassLength {
  halfYear,
  fullYear,
}

enum ClassLevel {
  CP,
  Honors,
  AP,
}

class Class {
  String name;
  Decimal credits;
  ClassLevel level;
  Department department;
  ClassLength length;
  ClassNumber classNumber;
  bool isCore;

  Class.empty();

  Class({
    @required this.name,
    @required this.credits,
    @required this.level,
    @required this.department,
    @required this.length,
    @required this.classNumber,
  }) {
    updateCoreStatus();
  }

  void updateCoreStatus() {
    isCore = department.isCore() || level == ClassLevel.AP;
  }
}
