import 'package:flutter/material.dart';
import 'package:sqflite_studend_records/functions/studentservice.dart';
import 'package:sqflite_studend_records/screens/homescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await innitializeDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
