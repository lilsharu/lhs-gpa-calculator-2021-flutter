import 'package:decimal/decimal.dart';

import '../class_data/class.dart';
import 'grade.dart';

class GPA {
  static final dp = Decimal.tryParse;

  final Grade _grade;
  final ClassLevel _level;

  const GPA({Grade grade = Grade.F, ClassLevel level = ClassLevel.CP})
      : this._grade = grade,
        this._level = level;

  Grade get getGrade => _grade;

  ClassLevel get getLevel => _level;

  Decimal calculate() {
    if (_grade == Grade.F) {
      return Decimal.fromInt(0);
    } else {
      return _grade.getGPAValue +
          (_level == ClassLevel.CP
              ? Decimal.zero
              : _level == ClassLevel.Honors
                  ? dp('0.5')!
                  : Decimal.one);
    }
  }

  @override
  String toString() {
    return calculate().toStringAsPrecision(3);
  }
}
