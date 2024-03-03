// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'student.dart';
import 'student_storage.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 3, 154, 53),
          // ···
          brightness: Brightness.dark,
        ),
      ),
      home: Scaffold(
        body: StudentPage(),
      ),
    );
  }
}

class StudentPage extends StatefulWidget {
  const StudentPage({super.key});

  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  final StudentStorage _storage = StudentStorage();
  Student? _student;
  bool _isEditMode = true;

  @override
  void initState() {
    super.initState();
    _loadStudentData();
  }

  Future<void> _loadStudentData() async {
    var loadedStudent = await _storage.loadStudent();
    setState(() {
      _student = loadedStudent;
      _isEditMode = loadedStudent == null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          _isEditMode ? 'Редагувати студента' : 'Перегляд студента',
          style: TextStyle(
            fontWeight: FontWeight.w500, // Робить текст жирнішим
            fontSize: 20, // Встановлює розмір шрифту
            color: Colors.black, // Встановлює колір тексту

            // Можете додати інші параметри TextStyle за потребою
          ),
        ),
      ),
      body: _isEditMode ? _buildEditForm() : _buildViewData(),
    );
  }

  Widget _buildEditForm() {
    final _firstNameController =
        TextEditingController(text: _student?.firstName ?? '');
    final _lastNameController =
        TextEditingController(text: _student?.lastName ?? '');
    final _birthDateController =
        TextEditingController(text: _student?.birthDate ?? '');
    final _studyGroupController =
        TextEditingController(text: _student?.studyGroup ?? '');
    final _studyYearController =
        TextEditingController(text: _student?.studyYear.toString() ?? '1');

    return Padding(
      padding: const EdgeInsets.only(
        left: 100.0,
        top: 10.0,
        right: 100.0,
        bottom: 10.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment
            .center, // Додано для вирівнювання тексту та кнопки по лівому краю
        mainAxisAlignment: MainAxisAlignment
            .center, // Вирівнювання дочірніх елементів по початку колонки

        children: [
          TextField(
            controller: _firstNameController,
            decoration: InputDecoration(labelText: 'Ім\'я'),
          ),
          TextField(
            controller: _lastNameController,
            decoration: InputDecoration(labelText: 'Прізвище'),
          ),
          TextField(
            controller: _birthDateController,
            decoration: InputDecoration(labelText: 'День народження'),
          ),
          TextField(
            controller: _studyGroupController,
            decoration: InputDecoration(labelText: 'Группа'),
          ),
          TextField(
            controller: _studyYearController,
            decoration: InputDecoration(labelText: 'Рік навчання'),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton.icon(
              onPressed: () async {
                final updatedStudent = Student(
                  firstName: _firstNameController.text,
                  lastName: _lastNameController.text,
                  birthDate: _birthDateController.text,
                  studyGroup: _studyGroupController.text,
                  studyYear: int.tryParse(_studyYearController.text) ?? 1,
                );
                await _storage.saveStudent(updatedStudent);
                setState(() {
                  _student = updatedStudent;
                  _isEditMode = false;
                });
              },
              icon: Icon(Icons.save),
              label: Text('Зберегти'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20), // Налаштовує внутрішні відступи
                textStyle: TextStyle(
                    fontSize: 18), // Опціонально: можна збільшити розмір тексту
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewData() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildInfoField(title: 'Ім\'я', value: _student?.firstName ?? ''),
              _buildInfoField(
                  title: 'Прізвище', value: _student?.lastName ?? ''),
              _buildInfoField(
                  title: 'День народження', value: _student?.birthDate ?? ''),
              _buildInfoField(
                  title: 'Група', value: _student?.studyGroup ?? ''),
              _buildInfoField(
                  title: 'Рік навчання',
                  value: _student?.studyYear.toString() ?? ''),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _isEditMode = true;
                    });
                  },
                  icon: Icon(Icons.edit),
                  label: Text('Редагувати'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoField({required String title, required String value}) {
    return Container(
      width: 400,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border:
            Border.all(width: 0.5, color: Color.fromARGB(255, 255, 255, 255)),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: RichText(
        text: TextSpan(
          text: '$title: ',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
          children: <TextSpan>[
            TextSpan(
              text: value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
