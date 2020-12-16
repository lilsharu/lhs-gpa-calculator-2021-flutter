import 'package:decimal/decimal.dart';

import 'class.dart';

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

  GPA get getGPA => GPA(grade: this.getGrade, level: super.getLevel);

  GPA get getMaxGPA => GPA(grade: Grade.A, level: super.getLevel);

  GPA get getUnweightedGPA => GPA(grade: this.getGrade);

  Decimal get getFirstSemesterGPA {
    var firstSemesterGPAValues = getFirstSemesterGPAValues;

    Decimal? gpa = firstSemesterGPAValues['gpa'];
    Decimal? credits = firstSemesterGPAValues['credits'];

    if (gpa == null || credits == null)
      throw ArgumentError(
        'The GPA Value Map is Missing Necessary Information',
      );

    return gpa / credits;
  }

  Map<String, Decimal> get getFirstSemesterGPAValues {
    var gpaSum =
        GPA(grade: this._firstSemester, level: super.getLevel).calculate() *
            Decimal.fromInt(super.getCredits) /
            Decimal.fromInt(2);
    var credits = Decimal.fromInt(super.getCredits) / Decimal.fromInt(2);

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
