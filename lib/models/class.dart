import 'package:decimal/decimal.dart';

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
}
