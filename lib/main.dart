import 'package:bmi_calculator/result.dart';
import 'package:flutter/material.dart';

import 'input_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/':(ctx)=>InputPage(),
        '/result':(ctx)=>ResultPage(),
      },
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21).withOpacity(0.8),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}



