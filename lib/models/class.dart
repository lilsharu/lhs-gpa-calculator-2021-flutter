import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:gpa_calculator/models/gpa.dart';

import './department.dart';
import './grade.dart';

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
      : _name = "",
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
    return "$_name ($_classNumber)";
  }

  void updateCoreStatus() {
    _isCore = _department.isCore && !_isElective || _level == ClassLevel.AP;
  }
}

class StudentClass extends Class {
  Grade _firstSemester;
  Grade? _secondSemester;
  Grade? _finals;

  StudentClass({
    required String name,
    required int credits,
    required ClassLevel level,
    required Department department,
    required ClassLength length,
    required ClassNumber classNumber,
    bool? isElective,
    required Grade firstSemester,
    Grade? secondSemester,
    Grade? finals,
  })  : this._firstSemester = firstSemester,
        this._secondSemester = secondSemester,
        this._finals = finals,
        super(
          name: name,
          credits: credits,
          level: level,
          department: department,
          length: length,
          classNumber: classNumber,
        );

  StudentClass.withClass({
    required Class theClass,
    required Grade firstSemester,
    Grade? secondSemester,
    Grade? finals,
  })  : this._firstSemester = firstSemester,
        this._secondSemester = secondSemester,
        this._finals = finals,
        super.withClass(theClass);

  Grade get getFirstSemester => _firstSemester;

  Grade? get getSecondSemester => _secondSemester;

  Grade? get getFinals => _finals;

  Grade get getGrade => Grade.average(
      firstSemester: _firstSemester,
      secondSemester: _secondSemester,
      finals: _finals);

  GPA get getGPA => GPA(grade: this.getGrade, level: super._level);

  GPA get getMaxGPA => GPA(grade: Grade.A, level: super._level);

  get getUnweightedGPA => GPA(grade: this.getGrade);

  Map<String, Decimal> get getFirstSemesterGPAValues {
    var gpaSum =
        GPA(grade: this._firstSemester, level: super._level).calculate() *
            Decimal.fromInt(_credits) /
            Decimal.fromInt(2);
    var credits = Decimal.fromInt(_credits) / Decimal.fromInt(2);

    return {
      'gpa': gpaSum,
      'credits': credits,
    };
  }

  set setFirstSemester(Grade firstSemester) => _firstSemester = firstSemester;

  set setSecondSemester(Grade secondSemester) =>
      _secondSemester = secondSemester;

  set setFinals(Grade finals) => _finals = finals;
}

class StudentClassList {
  static final dp = Decimal.tryParse;

  final List<StudentClass> _studentClassList;

  StudentClassList(this._studentClassList);

  StudentClassList.empty() : _studentClassList = <StudentClass>[];

  StudentClassList.from(StudentClassList classList)
      : _studentClassList = <StudentClass>[] {
    merge(classList);
  }

  StudentClassList.fromAll(List<StudentClassList> classLists)
      : _studentClassList = <StudentClass>[] {
    mergeAll(classLists);
  }

  List<StudentClass> get getClasses => _studentClassList;

  Iterator<StudentClass> get iterator => _studentClassList.iterator;

  Decimal get getAllCourseGPA {
    final allCourseGPAValues = getAllCourseGPAValues;

    Decimal? gpa = allCourseGPAValues['gpa'];
    Decimal? credits = allCourseGPAValues['credits'];

    if (gpa == null || credits == null) {
      throw ArgumentError(
        'The GPA Value Map is Missing Necessary Information',
      );
    }

    return gpa / credits;
  }

  Map<String, Decimal> get getAllCourseGPAValues {
    int credits = 0;
    Decimal gpaSum = Decimal.zero;

    for (var theClass in _studentClassList) {
      credits += theClass.getCredits;
      gpaSum +=
          theClass.getGPA.calculate() * Decimal.fromInt(theClass.getCredits);
    }

    return {
      'gpa': gpaSum,
      'credits': Decimal.fromInt(credits),
    };
  }

  Decimal get getMaxAllCourseGPA {
    final maxAllCourseGPAValues = getMaxAllCourseGPAValues;

    Decimal? gpa = maxAllCourseGPAValues['gpa'];
    Decimal? credits = maxAllCourseGPAValues['credits'];

    if (gpa == null || credits == null) {
      throw ArgumentError(
        'The GPA Value Map is Missing Necessary Information',
      );
    }

    return gpa / credits;
  }

  Map<String, Decimal> get getMaxAllCourseGPAValues {
    int credits = 0;
    Decimal gpaSum = Decimal.zero;

    for (var theClass in _studentClassList) {
      credits += theClass.getCredits;
      gpaSum +=
          theClass.getGPA.calculate() * Decimal.fromInt(theClass.getCredits);
    }

    return {
      'gpa': gpaSum,
      'credits': Decimal.fromInt(credits),
    };
  }

  Decimal get getCoreGPA {
    final coreGPAValues = getCoreGPAValues;

    Decimal? gpa = coreGPAValues['gpa'];
    Decimal? credits = coreGPAValues['credits'];

    if (gpa == null || credits == null) {
      throw ArgumentError(
        'The GPA Value Map is Missing Necessary Information',
      );
    }

    return gpa / credits;
  }

  Map<String, Decimal> get getCoreGPAValues {
    int credits = 0;
    Decimal gpaSum = Decimal.zero;

    var coreDepartments = Department.getCoreDepartments;
    var classNums = [0, 0, 0, 0, 0];

    var studentClassList = [..._studentClassList];
    studentClassList
        .sort((a, b) => a.getGPA.calculate().compareTo(b.getGPA.calculate()));

    for (var theClass in studentClassList) {
      if (theClass.getIsCore) {
        // Since only the best grade in a department is counted
        int index = coreDepartments.indexOf(theClass.getDepartment);
        if (classNums[index] == 0 || theClass.getLevel == ClassLevel.AP) {
          credits += theClass.getCredits;
          gpaSum += theClass.getGPA.calculate() *
              Decimal.fromInt(theClass.getCredits);
          classNums[index]++;
        }
      }
    }

    return {
      'gpa': gpaSum,
      'credits': Decimal.fromInt(credits),
    };
  }

  Decimal get getMaxCoreGPA {
    final maxCoreGPAValues = getMaxCoreGPAValues;

    Decimal? gpa = maxCoreGPAValues['gpa'];
    Decimal? credits = maxCoreGPAValues['credits'];

    if (gpa == null || credits == null) {
      throw ArgumentError(
        'The GPA Value Map is Missing Necessary Information',
      );
    }

    return gpa / credits;
  }

  Map<String, Decimal> get getMaxCoreGPAValues {
    int credits = 0;
    Decimal gpaSum = Decimal.zero;

    var coreDepartments = Department.getCoreDepartments;
    var classNums = [0, 0, 0, 0, 0];

    var studentClassList = [..._studentClassList];
    studentClassList
        .sort((a, b) => a.getGPA.calculate().compareTo(b.getGPA.calculate()));

    for (var theClass in studentClassList) {
      if (theClass.getIsCore) {
        int index = coreDepartments.indexOf(theClass.getDepartment);
        if (classNums[index] == 0 || theClass.getLevel == ClassLevel.AP) {
          credits += theClass.getCredits;
          gpaSum += theClass.getMaxGPA.calculate() *
              Decimal.fromInt(theClass.getCredits);
          classNums[index]++;
        }
      }
    }

    return {
      'gpa': gpaSum,
      'credits': Decimal.fromInt(credits),
    };
  }

  Decimal get getUnweightedGPA {
    final unweightedGPAValues = getUnweightedGPAValues;

    Decimal? gpa = unweightedGPAValues['gpa'];
    Decimal? credits = unweightedGPAValues['credits'];

    if (gpa == null || credits == null) {
      throw ArgumentError(
        'The GPA Value Map is Missing Necessary Information',
      );
    }

    return gpa / credits;
  }

  Map<String, Decimal> get getUnweightedGPAValues {
    int credits = 0;
    Decimal gpaSum = Decimal.zero;

    for (var theClass in _studentClassList) {
      credits += theClass.getCredits;
      gpaSum += theClass.getUnweightedGPA.calculate() *
          Decimal.fromInt(theClass.getCredits);
    }

    return {
      'gpa': gpaSum,
      'credits': Decimal.fromInt(credits),
    };
  }

  Decimal get getMaxUnweightedGPA {
    return Decimal.fromInt(4);
  }

  set setClasses(List<StudentClass> classes) {
    _studentClassList.clear();
    _studentClassList.addAll(classes);
  }

  void addClasses(List<StudentClass> moreClasses) =>
      _studentClassList.addAll(moreClasses);

  void merge(StudentClassList classList) => addClasses(classList.getClasses);

  void mergeAll(List<StudentClassList> classLists) {
    for (var classList in classLists) merge(classList);
  }
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
