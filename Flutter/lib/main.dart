import 'package:demo/Database.dart';
import 'package:demo/list.dart';
import 'package:flutter/material.dart';

void main() {
  var database = AppDatabase();

  runApp(MyApp(database: database));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.database});

  final AppDatabase database;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: ListPage(itemDao: database.itemsDao),
    );
  }
}
