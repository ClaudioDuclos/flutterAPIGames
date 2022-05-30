import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freegames/first.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

//Primeiro Bloco
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ConsultaPad',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: FirstPage(),
    );
  }
}

