// ignore_for_file: unnecessary_getters_setters

class Person {
  String _firstName;
  String _lastName;
  String _birthDate;

  Person({
    String firstName = '',
    String lastName = '',
    String birthDate = '',
  })  : _firstName = firstName,
        _lastName = lastName,
        _birthDate = birthDate;

  String get firstName => _firstName;
  set firstName(String value) => _firstName = value;

  String get lastName => _lastName;
  set lastName(String value) => _lastName = value;

  String get birthDate => _birthDate;
  set birthDate(String value) => _birthDate = value;
}
