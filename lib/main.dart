import 'package:flutter/material.dart';
import 'package:mentimath/screens/menu_screen.dart';

void main() {
  runApp(const CalculoMentalApp());
}

class CalculoMentalApp extends StatelessWidget {
  const CalculoMentalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MentiMath - Cálculo Mental',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'ComicNeue',
        useMaterial3: true,
      ),
      home: const MenuScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}