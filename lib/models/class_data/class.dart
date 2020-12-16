library class_data;

import '../class_dependencies/class_dependencies.dart';

export 'package:decimal/decimal.dart';
export '../class_dependencies/class_dependencies.dart';
export 'student_class.dart';

class Class {
  String _name;
  int _credits;
  ClassLevel _level;
  Department _department;
  ClassLength _length;
  ClassNumber _classNumber;
  bool _isCore = false;
  bool _isElective = false;

  Class({
    required String name,
    required int credits,
    required ClassLevel level,
    required Department department,
    required ClassLength length,
    required ClassNumber classNumber,
    bool? isElective,
  })  : _name = name,
        _credits = credits,
        _level = level,
        _department = department,
        _length = length,
        _classNumber = classNumber,
        _isElective = isElective ?? false {
    updateCoreStatus();
  }

  Class.withClass(Class theClass)
      : this(
          name: theClass.getName,
          credits: theClass.getCredits,
          level: theClass.getLevel,
          department: theClass.getDepartment,
          length: theClass.getLength,
          classNumber: theClass.getClassNumber,
          isElective: theClass.getIsElective,
        );

  Class.empty()
      : _name = '',
        _credits = 0,
        _level = ClassLevel.CP,
        _department = Department.ALL_DEPARTMENTS,
        _length = ClassLength.fullYear,
        _classNumber = ClassNumber(0);

  ClassNumber get getClassNumber => _classNumber;

  int get getCredits => _credits;

  Department get getDepartment => _department;

  bool get getIsCore => _isCore;

  bool get getIsElective => _isElective;

  ClassLength get getLength => _length;

  ClassLevel get getLevel => _level;

  String get getName => _name;

  Class get getClass => this;

  set setClassNumber(ClassNumber classNumber) =>
      this._classNumber = classNumber;

  set setCredits(int credits) => this._credits = credits;

  set setDepartment(Department department) {
    this._department = department;
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
    return '$_name ($_classNumber)';
  }

  void updateCoreStatus() {
    _isCore = _department.isCore && !_isElective || _level == ClassLevel.AP;
  }
}
