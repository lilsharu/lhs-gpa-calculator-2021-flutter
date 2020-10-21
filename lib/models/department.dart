import 'package:equatable/equatable.dart';

class Department extends Equatable {
  final String name;

  const Department(this.name);

  // Allows Comparison of Departments using Equatable
  @override
  List<Object> get props => [name];

  //TODO Make this functional
  bool isCore(Department department) {
    return true;
  }
}
