import 'package:equatable/equatable.dart';

class Department extends Equatable {
  /// Business Department
  static const Department BUSINESS_DEPARTMENT = Department(
    "Business",
  );

  /// English Department
  static const Department ENGLISH_DEPARTMENT = Department(
    "English",
  );

  /// FCS Department
  static const Department FCS_DEPARTMENT = Department(
    "Family Consumer Science",
  );

  /// Physical Education Department
  static const Department PE_DEPARTMENT = Department(
    "Health and Physical Education",
  );

  /// Math Department
  static const Department MATH_DEPARTMENT = Department(
    "Mathematics",
  );

  /// Performing Arts Department
  static const Department PERFORMING_ARTS_DEPARTMENT = Department(
    "Performing Arts",
  );

  /// Science Department
  static const Department SCIENCE_DEPARTMENT = Department(
    "Science",
  );

  /// Social Studies and History Department
  static const Department SOCIAL_STUDIES_DEPARTMENT = Department(
    "Social Studies",
  );

  /// Technology Department
  static const Department TECHNOLOGY_DEPARTMENT = Department(
    "Technology, Design, and Engineering",
  );

  /// Visual Arts Department
  static const Department VISUAL_ART_DEPARTMENT = Department(
    "Visual Arts",
  );

  /// World Language Department
  static const Department WORLD_LANGUAGE_DEPARTMENT = Department(
    "World Language",
  );

  /// General "All" Departments
  static const Department ALL_DEPARTMENTS = Department(
    "All",
  );

  final String name;

  const Department(this.name);

  /// Allows checking for equality and generating HashCode
  @override
  List<Object> get props => [name];

  /// Checks whether classes in a certain department are considered Core Classes
  ///
  /// Departments which are considered Core include Math, Science, Social Studies,
  /// English, and World Language.
  bool isCore() {
    return this == ENGLISH_DEPARTMENT ||
        this == MATH_DEPARTMENT ||
        this == SCIENCE_DEPARTMENT ||
        this == SOCIAL_STUDIES_DEPARTMENT ||
        this == WORLD_LANGUAGE_DEPARTMENT;
  }
}
