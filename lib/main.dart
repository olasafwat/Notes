

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'view/HomeScreen.dart';
import 'dart:ui';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.robotoSlabTextTheme(),

      ),
      home: const HomeScreen(),
    );
  }
}


