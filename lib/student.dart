// ignore_for_file: non_constant_identifier_names, unnecessary_getters_setters

import 'package:project0/person.dart';

class Student extends Person {
  String _studyGroup;
  int _studyYear;

  Student({
    String firstName = '',
    String lastName = '',
    String birthDate = '',
    String studyGroup = '',
    int studyYear = 1,
  })  : _studyGroup = studyGroup,
        _studyYear = studyYear,
        super(firstName: firstName, lastName: lastName, birthDate: birthDate);

  String get studyGroup => _studyGroup;
  set studyGroup(String value) => _studyGroup = value;

  int get studyYear => _studyYear;
  set studyYear(int value) => _studyYear = value;
}
