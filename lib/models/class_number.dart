import 'package:equatable/equatable.dart';

// TODO Implement ClassNumber
class ClassNumber extends Equatable {
  final int number;
  final String addition;

  ClassNumber(this.number, [this.addition = '']);

  @override
  List<Object> get props => [number, addition];

  static ClassNumber parseNumber(String courseNumber) {
    var number = int.parse(courseNumber.substring(0, 3));
    var addition = '';
    if (courseNumber.length > 3) addition = courseNumber.substring(3);

    return ClassNumber(number, addition);
  }
}
