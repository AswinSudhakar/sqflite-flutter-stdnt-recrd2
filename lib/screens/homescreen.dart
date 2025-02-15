import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sqflite_studend_records/functions/studentservice.dart';
import 'package:sqflite_studend_records/models/studentmodels.dart';
import 'package:sqflite_studend_records/screens/studentlist.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  final FocusNode focusnode1 = FocusNode();
  final FocusNode focusnode2 = FocusNode();
  final FocusNode focusnode3 = FocusNode();
  final FocusNode focusnode4 = FocusNode();
  final FocusNode focusnode5 = FocusNode();

  @override
  Widget build(BuildContext context) {
    getallStudents();
    return SafeArea(
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                floatingbuttonlick(context);
              },
              child: Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
              color: Colors.blue, // Set the amber background color
              shape:
                  CircularNotchedRectangle(), // Notch for the floating action button
              child: SizedBox(height: 60), // Height of the BottomAppBar
            ),
            appBar: AppBar(
              toolbarHeight: 90,
              backgroundColor: Colors.blue,
              centerTitle: true,
              title: Text(
                'Student Details',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
            ),
            body: StudentList()));
  }

  Future<void> onButtonClicked() async {
    final name = nameController.text;
    final age = ageController.text;
    final subject = subjectController.text;
    final address = addressController.text;

    if (name.isEmpty || age.isEmpty || subject.isEmpty || address.isEmpty) {
      return;
    }
    {
      final newstud = Studentmodels(
          name: name, age: age, subject: subject, address: address);
      addStudent(newstud);
    }

    nameController.clear();
    ageController.clear();
    subjectController.clear();
    addressController.clear();
  }

  Future<void> floatingbuttonlick(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Student'),
          content: SizedBox(
            height: 200,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    focusNode: focusnode1,
                    onSubmitted: (_) {
                      FocusScope.of(context).requestFocus(focusnode2);
                    },
                    controller: nameController,
                    decoration: InputDecoration(
                        hintText: 'Name', border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    focusNode: focusnode2,
                    onSubmitted: (_) {
                      FocusScope.of(context).requestFocus(focusnode3);
                    },
                    keyboardType: TextInputType.number,
                    controller: ageController,
                    decoration: InputDecoration(
                        hintText: 'Age', border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    focusNode: focusnode3,
                    onSubmitted: (_) {
                      FocusScope.of(context).requestFocus(focusnode4);
                    },
                    controller: subjectController,
                    decoration: InputDecoration(
                        hintText: 'Subject', border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    focusNode: focusnode4,
                    controller: addressController,
                    decoration: InputDecoration(
                        hintText: 'Address', border: OutlineInputBorder()),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
                onPressed: () async {
                  onButtonClicked();
                  Navigator.pop(context);
                },
                child: Text('Add')),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'))
          ],
        );
      },
    );
  }
}
