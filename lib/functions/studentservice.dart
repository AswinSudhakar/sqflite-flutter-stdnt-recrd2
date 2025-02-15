import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_studend_records/models/studentmodels.dart';

ValueNotifier<List<Studentmodels>> students = ValueNotifier([]);
late Database _db;

Future<void> innitializeDatabase() async {
  _db = await openDatabase(
    'student.db',
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE student (id INTEGER PRIMARY KEY, name TEXT, age TEXT,subject TEXT,address TEXT)');
    },
  );
}

Future<void> addStudent(Studentmodels student) async {
  await _db.rawInsert(
      'INSERT INTO student(name,age,subject,address) VALUES(?,?,?,?)',
      [student.name, student.age, student.subject, student.address]);
  getallStudents();
}

Future<void> getallStudents() async {
  final values = await _db.rawQuery('SELECT * FROM  student');

  students.value.clear();

  for (var map in values) {
    final student = Studentmodels.fromMap(map);
    students.value.add(student);
    students.notifyListeners();
  }
}

Future<void> deleteStudent(int id) async {
  _db.rawDelete('DELETE FROM student WHERE id=?', [id]);
  students.notifyListeners();
  getallStudents();
}

Future<void> updateStudent(
    String name, String age, String subject, String address, int id) async {
  _db.rawUpdate(
      'UPDATE student SET name=? , age=? , subject=? , address=?  WHERE id=?',
      [name, age, subject, address, id]);
  getallStudents();
}
