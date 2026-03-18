import 'package:flutter/material.dart';
import 'package:rick_and_morty_info/database/database.dart';
import 'package:rick_and_morty_info/pages/layout.dart';

void main() async {
  await HiveDataBase().initHive();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick and Morty',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Layout(),
    );
  }
}
