import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';

class Grade extends Equatable {
  static const Grade A = const Grade('A');
  static const Grade A_MINUS = const Grade('A-');
  static const Grade B_PLUS = const Grade('B+');
  static const Grade B = const Grade('B');
  static const Grade B_MINUS = const Grade('B-');
  static const Grade C_PLUS = const Grade('C+');
  static const Grade C = const Grade('C');
  static const Grade C_MINUS = const Grade('C-');
  static const Grade D_PLUS = const Grade('D+');
  static const Grade D = const Grade('D');
  static const Grade D_MINUS = const Grade('D-');
  static const Grade F = const Grade('F');
  static const Grade NONE = const Grade('None');

  static final dp = Decimal.tryParse;

  final String _grade;

  const Grade(this._grade);

  String get getGrade => _grade;

  Decimal get getGPAValue => _calculateGPAValue(_grade);

  @override
  List<Object> get props => [_grade];

  /// This implements a toString Method to allow the printing of data
  @override
  String toString() {
    return _grade;
  }

  static Grade average({
    required Grade firstSemester,
    Grade? secondSemester,
    Grade? finals,
  }) {
    var averageGPAValue = secondSemester == null
        ? finals == null
            ? firstSemester.getGPAValue
            : firstSemester.getGPAValue * dp('0.90')! +
                finals.getGPAValue * dp('0.10')!
        : finals == null
            ? (firstSemester.getGPAValue + secondSemester.getGPAValue) /
                Decimal.fromInt(2)
            : firstSemester.getGPAValue * dp('0.45')! +
                secondSemester.getGPAValue * dp('0.45')! +
                finals.getGPAValue * dp('0.10')!;

    return Grade.fromGPA(averageGPAValue);
  }

  static Grade fromGPA(Decimal gpaValue) {
    if (gpaValue >= dp('3.825')!)
      return Grade.A;
    else if (gpaValue >= dp('3.495')!)
      return Grade.A_MINUS;
    else if (gpaValue >= dp('3.155')!)
      return Grade.B_PLUS;
    else if (gpaValue >= dp('2.825')!)
      return Grade.B;
    else if (gpaValue >= dp('2.495')!)
      return Grade.B_MINUS;
    else if (gpaValue >= dp('2.155')!)
      return Grade.C_PLUS;
    else if (gpaValue >= dp('1.825')!)
      return Grade.C;
    else if (gpaValue >= dp('1.495')!)
      return Grade.C_MINUS;
    else if (gpaValue >= dp('1.155')!)
      return Grade.D_PLUS;
    else if (gpaValue >= dp('0.825')!)
      return Grade.D;
    else if (gpaValue >= dp('0.495')!)
      return Grade.D_MINUS;
    else
      return Grade.F;
  }

  /// Using the grade String, this calculates the GPA Value associated
  static Decimal _calculateGPAValue(String grade) {
    switch (grade) {
      case 'A':
        return dp('4.00')!;
      case 'A-':
        return dp('3.66')!;
      case 'B+':
        return dp('3.33')!;
      case 'B':
        return dp('3.00')!;
      case 'B-':
        return dp('2.66')!;
      case 'C+':
        return dp('2.33')!;
      case 'C':
        return dp('2.00')!;
      case 'C-':
        return dp('1.66')!;
      case 'D+':
        return dp('1.33')!;
      case 'D':
        return dp('1.00')!;
      case 'D-':
        return dp('0.66')!;
      default:
        return dp('0.00')!;
    }
  }

  /// Uses GPA Value from Average of Grades to find out which Grade was truly
  /// achieved.
  static String _getGradeFromGPA(Decimal gpaValue) {
    if (gpaValue >= dp('3.825')!)
      return 'A';
    else if (gpaValue >= dp('3.495')!)
      return 'A-';
    else if (gpaValue >= dp('3.155')!)
      return 'B+';
    else if (gpaValue >= dp('2.825')!)
      return 'B';
    else if (gpaValue >= dp('2.495')!)
      return 'B-';
    else if (gpaValue >= dp('2.155')!)
      return 'C+';
    else if (gpaValue >= dp('1.825')!)
      return 'C';
    else if (gpaValue >= dp('1.495')!)
      return 'C-';
    else if (gpaValue >= dp('1.155')!)
      return 'D+';
    else if (gpaValue >= dp('0.825')!)
      return 'D';
    else if (gpaValue >= dp('0.495')!)
      return 'D-';
    else
      return 'F';
  }
}
