import 'package:decimal/decimal.dart';

import './class.dart';
import './grade.dart';

class GPA {
  static final dp = Decimal.tryParse;

  Grade _grade;
  ClassLevel _level;

  GPA({Grade grade = Grade.F, ClassLevel level = ClassLevel.CP})
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
              ? dp('0')
              : _level == ClassLevel.Honors
                  ? dp('0.5')
                  : dp('1'));
    }
  }

  @override
  String toString() {
    return calculate().toStringAsPrecision(3);
  }
}
