import 'package:decimal/decimal.dart';
import 'package:flutter/foundation.dart';

import './class_number.dart';
import './department.dart';

class Class {
  String _name;
  Decimal _credits;
  ClassLevel _level;
  Department _department;
  ClassLength _length;
  ClassNumber _classNumber;
  bool _isCore;
  bool _isElective;

  Class({
    @required name,
    @required credits,
    @required level,
    @required department,
    @required length,
    @required classNumber,
    isElective,
  })  : _name = name,
        _credits = credits,
        _level = level,
        _department = department,
        _length = length,
        _classNumber = classNumber,
        _isElective = isElective ?? false {
    updateCoreStatus();
  }

  Class.empty();

  ClassNumber get getClassNumber => _classNumber;

  Decimal get getCredits => _credits;

  Department get getDepartment => _department;

  bool get getIsCore => _isCore;

  bool get getIsElective => _isElective;

  ClassLength get getLength => _length;

  ClassLevel get getLevel => _level;

  String get getName => _name;

  set setClassNumber(ClassNumber classNumber) =>
      this._classNumber = classNumber;

  set setCredits(Decimal credits) => this._credits = credits;

  set setDepartment(Department department) => this._department = department;

  set setIsCore(bool isCore) {
    this._isCore = isCore;
    updateCoreStatus();
  }

  set setIsElective(bool isElective) {
    this._isElective = isElective;
    updateCoreStatus();
  }

  set setLength(ClassLength length) => this._length = length;

  set setLevel(ClassLevel level) {
    this._level = level;
    updateCoreStatus();
  }

  set setName(String name) => this._name = name;

  @override
  String toString() {
    return this._name;
  }

  void updateCoreStatus() {
    _isCore = _department.isCore() && !_isElective || _level == ClassLevel.AP;
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
