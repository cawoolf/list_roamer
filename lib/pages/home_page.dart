import 'package:flutter/material.dart';
import 'package:list_roamer/pages/list_view_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top 1/3 of the page - Image view placeholder
            Container(
              height: MediaQuery.of(context).size.height / 3,
              color: Colors.grey, // Placeholder color
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Popular Spots',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            // Bottom 2/3 of the page - List view
            Container(
              height: 2 * MediaQuery.of(context).size.height / 3,
              child: const ListViewPage(),
            ),
          ],
        ),
      ),
    );
  }
}


