import 'package:equatable/equatable.dart';

class ClassNumber extends Equatable {
  final int number;
  final String addition;

  ClassNumber(this.number, [this.addition = '']);

  String get getAddition => addition;

  int get getNumber => number;

  @override
  List<Object> get props => [number, addition];

  @override
  String toString() {
    String numberPortion = number.toString();

    while (numberPortion.length < 3) {
      numberPortion = '0$numberPortion';
    }

    return '$numberPortion$addition';
  }

  static ClassNumber parseNumber(String courseNumber) {
    var number = int.parse(courseNumber.substring(0, 3));
    var addition = '';
    if (courseNumber.length > 3) addition = courseNumber.substring(3);

    return ClassNumber(number, addition);
  }
}
