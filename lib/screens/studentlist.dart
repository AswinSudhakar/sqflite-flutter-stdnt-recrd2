import 'package:flutter/material.dart';
import 'package:sqflite_studend_records/functions/studentservice.dart';
import 'package:sqflite_studend_records/models/studentmodels.dart';
import 'package:sqflite_studend_records/screens/studentdetails.dart';

class StudentList extends StatelessWidget {
  StudentList({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  final FocusNode focusnode1 = FocusNode();
  final FocusNode focusnode2 = FocusNode();
  final FocusNode focusnode3 = FocusNode();
  final FocusNode focusnode4 = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: students,
      builder: (context, value, child) {
        return ListView.builder(
          itemCount: value.length,
          itemBuilder: (context, index) {
            final student = value[index];
            return Card(
              elevation: 15,
              child: ListTile(
                leading: CircleAvatar(
                  child: Text((index + 1).toString()),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StudentDetails(model: student),
                      ));
                },
                title: Text('${student.name}'),
                subtitle: Text('${student.subject}'),
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            editStudent(student, student.id!, context);
                          },
                          icon: Icon(Icons.edit)),
                      IconButton(
                          onPressed: () {
                            deleteStudent(student.id!);
                          },
                          icon: Icon(Icons.delete))
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> editStudent(
      Studentmodels student, int id, BuildContext context) async {
    nameController.text = student.name!;
    ageController.text = student.age!;
    subjectController.text = student.subject!;
    addressController.text = student.address!;

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
                  student.name = nameController.text;
                  student.age = ageController.text;
                  student.subject = subjectController.text;
                  student.address = addressController.text;

                  updateStudent(student.name!, student.age!, student.subject!,
                      student.address!, id);
                  Navigator.pop(context);

                  nameController.clear();
                  ageController.clear();
                  subjectController.clear();
                  addressController.clear();
                },
                child: Text('Update')),
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
