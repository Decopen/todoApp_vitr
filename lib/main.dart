import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:vite/page/mes_taches.dart';

void main() async {
  // init the hive
  await Hive.initFlutter();

  // open a box
  var box = await Hive.openBox("My box");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MesTaches(),
    );
  }
}
