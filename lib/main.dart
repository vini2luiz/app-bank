// lib/main.dart

import 'package:flutter/material.dart';
import 'screens/item_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'app bancario',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ItemList(),
    );
  }
}
