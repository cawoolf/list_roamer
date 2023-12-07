import 'dart:async';

import 'package:flutter/material.dart';
import 'package:list_roamer/pages/navigation_page.dart';
import 'package:provider/provider.dart';

import '../services/database.dart';
import 'home_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  WelcomePageState createState() => WelcomePageState();
}

class WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();

    String testUserId = 'testUser';

    // Add a delay and then navigate to the Home Page
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return Provider<Database>(
            create: (_) => FirestoreDatabase(uid: testUserId),
            child: const NavigationPage(),
          );
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'List Roamer',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

