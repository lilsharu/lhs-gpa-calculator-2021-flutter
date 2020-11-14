import 'package:equatable/equatable.dart';

class Department extends Equatable {
  /// Business Department
  static const BUSINESS_DEPARTMENT = const Department(
    'Business',
  );

  /// English Department
  static const ENGLISH_DEPARTMENT = const Department(
    'English',
  );

  /// FCS Department
  static const FCS_DEPARTMENT = const Department(
    'Family Consumer Science',
  );

  /// Physical Education Department
  static const PE_DEPARTMENT = const Department(
    'Health and Physical Education',
  );

  /// Math Department
  static const MATH_DEPARTMENT = const Department(
    'Mathematics',
  );

  /// Performing Arts Department
  static const PERFORMING_ARTS_DEPARTMENT = const Department(
    'Performing Arts',
  );

  /// Science Department
  static const SCIENCE_DEPARTMENT = const Department(
    'Science',
  );

  /// Social Studies and History Department
  static const SOCIAL_STUDIES_DEPARTMENT = const Department(
    'Social Studies',
  );

  /// Technology Department
  static const TECHNOLOGY_DEPARTMENT = const Department(
    'Technology, Design, and Engineering',
  );

  /// Visual Arts Department
  static const VISUAL_ART_DEPARTMENT = const Department(
    'Visual Arts',
  );

  /// World Language Department
  static const WORLD_LANGUAGE_DEPARTMENT = const Department(
    'World Language',
  );

  /// General 'All' Departments
  static const ALL_DEPARTMENTS = const Department(
    'All',
  );

  /// List of All Deparments
  static const DEPARTMENT_LIST = const [
    BUSINESS_DEPARTMENT,
    ENGLISH_DEPARTMENT,
    FCS_DEPARTMENT,
    PE_DEPARTMENT,
    MATH_DEPARTMENT,
    PERFORMING_ARTS_DEPARTMENT,
    SCIENCE_DEPARTMENT,
    SOCIAL_STUDIES_DEPARTMENT,
    TECHNOLOGY_DEPARTMENT,
    VISUAL_ART_DEPARTMENT,
    WORLD_LANGUAGE_DEPARTMENT,
  ];

  /// List of All Core Deparments
  static const CORE_DEPARTMENT_LIST = const [
    MATH_DEPARTMENT,
    SCIENCE_DEPARTMENT,
    ENGLISH_DEPARTMENT,
    SOCIAL_STUDIES_DEPARTMENT,
    WORLD_LANGUAGE_DEPARTMENT,
  ];

  final String name;

  const Department(this.name);

  /// Allows checking for equality and generating HashCode
  @override
  List<Object> get props => [name];

  /// Checks whether classes in a certain department are considered Core Classes
  ///
  /// Departments which are considered Core include Math, Science, Social Studies,
  /// English, and World Language.
  bool get isCore {
    return this == ENGLISH_DEPARTMENT ||
        this == MATH_DEPARTMENT ||
        this == SCIENCE_DEPARTMENT ||
        this == SOCIAL_STUDIES_DEPARTMENT ||
        this == WORLD_LANGUAGE_DEPARTMENT;
  }

  static List<Department> get getDepartments {
    return [
      BUSINESS_DEPARTMENT,
      ENGLISH_DEPARTMENT,
      FCS_DEPARTMENT,
      PE_DEPARTMENT,
      MATH_DEPARTMENT,
      PERFORMING_ARTS_DEPARTMENT,
      SCIENCE_DEPARTMENT,
      SOCIAL_STUDIES_DEPARTMENT,
      TECHNOLOGY_DEPARTMENT,
      VISUAL_ART_DEPARTMENT,
      WORLD_LANGUAGE_DEPARTMENT,
    ];
  }

  static List<Department> get getCoreDepartments {
    return [
      MATH_DEPARTMENT,
      SCIENCE_DEPARTMENT,
      ENGLISH_DEPARTMENT,
      SOCIAL_STUDIES_DEPARTMENT,
      WORLD_LANGUAGE_DEPARTMENT,
    ];
  }
}
