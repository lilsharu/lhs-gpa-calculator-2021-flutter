import 'class.dart';

class StudentClassList {
  static final dp = Decimal.tryParse;

  final List<StudentClass> _studentClassList;

  StudentClassList(this._studentClassList);

  StudentClassList.empty() : _studentClassList = <StudentClass>[];

  StudentClassList.from(StudentClassList classList)
      : _studentClassList = <StudentClass>[] {
    merge(classList);
  }

  StudentClassList.fromAll(List<StudentClassList> classLists)
      : _studentClassList = <StudentClass>[] {
    mergeAll(classLists);
  }

  List<StudentClass> get getClasses => _studentClassList;

  Iterator<StudentClass> get iterator => _studentClassList.iterator;

  Decimal get getAllCourseGPA {
    final allCourseGPAValues = getAllCourseGPAValues;

    Decimal? gpa = allCourseGPAValues['gpa'];
    Decimal? credits = allCourseGPAValues['credits'];

    if (gpa == null || credits == null) {
      throw ArgumentError(
        'The GPA Value Map is Missing Necessary Information',
      );
    }

    return gpa / credits;
  }

  Map<String, Decimal> get getAllCourseGPAValues {
    int credits = 0;
    Decimal gpaSum = Decimal.zero;

    for (var theClass in _studentClassList) {
      credits += theClass.getCredits;
      gpaSum +=
          theClass.getGPA.calculate() * Decimal.fromInt(theClass.getCredits);
    }

    return {
      'gpa': gpaSum,
      'credits': Decimal.fromInt(credits),
    };
  }

  Decimal get getMaxAllCourseGPA {
    final maxAllCourseGPAValues = getMaxAllCourseGPAValues;

    Decimal? gpa = maxAllCourseGPAValues['gpa'];
    Decimal? credits = maxAllCourseGPAValues['credits'];

    if (gpa == null || credits == null) {
      throw ArgumentError(
        'The GPA Value Map is Missing Necessary Information',
      );
    }

    return gpa / credits;
  }

  Map<String, Decimal> get getMaxAllCourseGPAValues {
    int credits = 0;
    Decimal gpaSum = Decimal.zero;

    for (var theClass in _studentClassList) {
      credits += theClass.getCredits;
      gpaSum +=
          theClass.getGPA.calculate() * Decimal.fromInt(theClass.getCredits);
    }

    return {
      'gpa': gpaSum,
      'credits': Decimal.fromInt(credits),
    };
  }

  Decimal get getCoreGPA {
    final coreGPAValues = getCoreGPAValues;

    Decimal? gpa = coreGPAValues['gpa'];
    Decimal? credits = coreGPAValues['credits'];

    if (gpa == null || credits == null) {
      throw ArgumentError(
        'The GPA Value Map is Missing Necessary Information',
      );
    }

    return gpa / credits;
  }

  Map<String, Decimal> get getCoreGPAValues {
    int credits = 0;
    Decimal gpaSum = Decimal.zero;

    var coreDepartments = Department.getCoreDepartments;
    var classNums = [0, 0, 0, 0, 0];

    var studentClassList = [..._studentClassList];
    studentClassList
        .sort((a, b) => a.getGPA.calculate().compareTo(b.getGPA.calculate()));

    for (var theClass in studentClassList) {
      if (theClass.getIsCore) {
        // Since only the best grade in a department is counted
        int index = coreDepartments.indexOf(theClass.getDepartment);
        if (classNums[index] == 0 || theClass.getLevel == ClassLevel.AP) {
          credits += theClass.getCredits;
          gpaSum += theClass.getGPA.calculate() *
              Decimal.fromInt(theClass.getCredits);
          classNums[index]++;
        }
      }
    }

    return {
      'gpa': gpaSum,
      'credits': Decimal.fromInt(credits),
    };
  }

  Decimal get getMaxCoreGPA {
    final maxCoreGPAValues = getMaxCoreGPAValues;

    Decimal? gpa = maxCoreGPAValues['gpa'];
    Decimal? credits = maxCoreGPAValues['credits'];

    if (gpa == null || credits == null) {
      throw ArgumentError(
        'The GPA Value Map is Missing Necessary Information',
      );
    }

    return gpa / credits;
  }

  Map<String, Decimal> get getMaxCoreGPAValues {
    int credits = 0;
    Decimal gpaSum = Decimal.zero;

    var coreDepartments = Department.getCoreDepartments;
    var classNums = [0, 0, 0, 0, 0];

    var studentClassList = [..._studentClassList];
    studentClassList
        .sort((a, b) => a.getGPA.calculate().compareTo(b.getGPA.calculate()));

    for (var theClass in studentClassList) {
      if (theClass.getIsCore) {
        int index = coreDepartments.indexOf(theClass.getDepartment);
        if (classNums[index] == 0 || theClass.getLevel == ClassLevel.AP) {
          credits += theClass.getCredits;
          gpaSum += theClass.getMaxGPA.calculate() *
              Decimal.fromInt(theClass.getCredits);
          classNums[index]++;
        }
      }
    }

    return {
      'gpa': gpaSum,
      'credits': Decimal.fromInt(credits),
    };
  }

  Decimal get getUnweightedGPA {
    final unweightedGPAValues = getUnweightedGPAValues;

    Decimal? gpa = unweightedGPAValues['gpa'];
    Decimal? credits = unweightedGPAValues['credits'];

    if (gpa == null || credits == null) {
      throw ArgumentError(
        'The GPA Value Map is Missing Necessary Information',
      );
    }

    return gpa / credits;
  }

  Map<String, Decimal> get getUnweightedGPAValues {
    int credits = 0;
    Decimal gpaSum = Decimal.zero;

    for (var theClass in _studentClassList) {
      credits += theClass.getCredits;
      gpaSum += theClass.getUnweightedGPA.calculate() *
          Decimal.fromInt(theClass.getCredits);
    }

    return {
      'gpa': gpaSum,
      'credits': Decimal.fromInt(credits),
    };
  }

  Decimal get getMaxUnweightedGPA {
    return Decimal.fromInt(4);
  }

  set setClasses(List<StudentClass> classes) {
    _studentClassList.clear();
    _studentClassList.addAll(classes);
  }

  void addClasses(List<StudentClass> moreClasses) =>
      _studentClassList.addAll(moreClasses);

  void merge(StudentClassList classList) => addClasses(classList.getClasses);

  void mergeAll(List<StudentClassList> classLists) {
    for (var classList in classLists) merge(classList);
  }
}
