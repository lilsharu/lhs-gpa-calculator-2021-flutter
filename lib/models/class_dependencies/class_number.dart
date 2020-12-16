import 'package:equatable/equatable.dart';

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
