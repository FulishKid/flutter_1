import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'student.dart';

class StudentStorage {
  static const _storageKey = 'studentData';
  Future<void> saveStudent(Student student) async {
    final prefs = await SharedPreferences.getInstance();
    //  Student obj to JSON
    String studentJson = json.encode({
      'firstName': student.firstName,
      'lastName': student.lastName,
      'birthDate': student.birthDate,
      'studyGroup': student.studyGroup,
      'studyYear': student.studyYear,
    });
    // saving
    await prefs.setString(_storageKey, studentJson);
  }

  Future<Student?> loadStudent() async {
    final prefs = await SharedPreferences.getInstance();
    // loading Student JSON
    String? studentJson = prefs.getString(_storageKey);
    // JSON to Student obj
    if (studentJson != null) {
      Map<String, dynamic> jsonMap = json.decode(studentJson);
      Student loadedStudent = Student(
        firstName: jsonMap['firstName'] ?? '',
        lastName: jsonMap['lastName'] ?? '',
        birthDate: jsonMap['birthDate'] ?? '',
        studyGroup: jsonMap['studyGroup'] ?? '',
        studyYear: jsonMap['studyYear'] ?? 1,
      );
      return loadedStudent;
    }

    return null;
  }
}
