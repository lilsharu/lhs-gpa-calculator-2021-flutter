import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Grade extends Equatable {
  // ignore: non_constant_identifier_names
  static final Grade A = Grade('A');
  // ignore: non_constant_identifier_names
  static final Grade A_MINUS = Grade('A-');
  // ignore: non_constant_identifier_names
  static final Grade B_PLUS = Grade('B+');
  // ignore: non_constant_identifier_names
  static final Grade B = Grade('B');
  // ignore: non_constant_identifier_names
  static final Grade B_MINUS = Grade('B-');
  // ignore: non_constant_identifier_names
  static final Grade C_PLUS = Grade('C+');
  // ignore: non_constant_identifier_names
  static final Grade C = Grade('C');
  // ignore: non_constant_identifier_names
  static final Grade C_MINUS = Grade('C-');
  // ignore: non_constant_identifier_names
  static final Grade D_PLUS = Grade('D+');
  // ignore: non_constant_identifier_names
  static final Grade D = Grade('D');
  // ignore: non_constant_identifier_names
  static final Grade D_MINUS = Grade('D-');
  // ignore: non_constant_identifier_names
  static final Grade F = Grade('F');
  // ignore: non_constant_identifier_names
  static final Grade NONE = Grade('None');

  static final dp = Decimal.tryParse;

  final String grade;
  final Decimal gpaValue;

  String get getGrade => grade;

  Decimal get getGPAValue => gpaValue;

  Grade(this.grade) : gpaValue = _calculateGPAValue(grade);

  Grade.fromGPA(Decimal gpaValue) : this(_getGradeFromGPA(gpaValue));

  @override
  List<Object> get props => [grade];

  /// This implements a toString Method to allow the printing of data
  @override
  String toString() {
    return grade;
  }

  static Grade average({
    @required Grade firstSemester,
    Grade secondSemester,
    Grade finalsGrade,
  }) {
    var val =
        (secondSemester != null ? 1 : 0) + (secondSemester != null ? 2 : 0);
    var averageGPAValue = (val == 0
        ? firstSemester.getGPAValue
        : val == 1
            ? (firstSemester.getGPAValue + secondSemester.getGPAValue) /
                Decimal.fromInt(2)
            : val == 2
                ? firstSemester.getGPAValue * dp('0.90') +
                    finalsGrade.getGPAValue * dp('0.10')
                : firstSemester.getGPAValue * dp('0.45') +
                    secondSemester.getGPAValue * dp('0.45') +
                    finalsGrade.getGPAValue * dp('0.10'));
    return Grade.fromGPA(averageGPAValue);
  }

  /// Using the grade String, this calculates the GPA Value associated
  static Decimal _calculateGPAValue(String grade) {
    switch (grade) {
      case 'A':
        return dp('4.00');
      case 'A-':
        return dp('3.66');
      case 'B+':
        return dp('3.33');
      case 'B':
        return dp('3.00');
      case 'B-':
        return dp('2.66');
      case 'C+':
        return dp('2.33');
      case 'C':
        return dp('2.00');
      case 'C-':
        return dp('1.66');
      case 'D+':
        return dp('1.33');
      case 'D':
        return dp('1.00');
      case 'D-':
        return dp('0.66');
      default:
        return dp('0.00');
    }
  }

  /// Uses GPA Value from Average of Grades to find out which Grade was truly
  /// achieved.
  static String _getGradeFromGPA(Decimal gpaValue) {
    if (gpaValue >= dp('3.825'))
      return 'A';
    else if (gpaValue >= dp('3.495'))
      return 'A-';
    else if (gpaValue >= dp('3.155'))
      return 'B+';
    else if (gpaValue >= dp('2.825'))
      return 'B';
    else if (gpaValue >= dp('2.495'))
      return 'B-';
    else if (gpaValue >= dp('2.155'))
      return 'C+';
    else if (gpaValue >= dp('1.825'))
      return 'C';
    else if (gpaValue >= dp('1.495'))
      return 'C-';
    else if (gpaValue >= dp('1.155'))
      return 'D+';
    else if (gpaValue >= dp('0.825'))
      return 'D';
    else if (gpaValue >= dp('0.495'))
      return 'D-';
    else
      return 'F';
  }
}
