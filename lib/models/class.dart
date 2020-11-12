import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

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
    @required String name,
    @required Decimal credits,
    @required ClassLevel level,
    @required Department department,
    @required ClassLength length,
    @required ClassNumber classNumber,
    bool isElective,
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
    _isCore = _department.isCore && !_isElective || _level == ClassLevel.AP;
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

class ClassNumber extends Equatable {
  final int _number;
  final String _addition;

  const ClassNumber(this._number, [this._addition = '']);

  String get getAddition => _addition;

  int get getNumber => _number;

  @override
  List<Object> get props => [_number, _addition];

  @override
  String toString() {
    String numberPortion = _number.toString();

    while (numberPortion.length < 3) {
      numberPortion = '0$numberPortion';
    }

    return '$numberPortion$_addition';
  }

  static ClassNumber parseNumber(String courseNumber) {
    var number = int.parse(courseNumber.substring(0, 3));
    var addition = '';
    if (courseNumber.length > 3) addition = courseNumber.substring(3);

    return ClassNumber(number, addition);
  }
}
