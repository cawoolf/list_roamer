import 'package:flutter/material.dart';
import 'package:the_spotz/pages/maps_page.dart';
import 'package:the_spotz/pages/navigation_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NavigationPage(),
    );
  }
}



