import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/database.dart';

class ListViewPage extends StatelessWidget {
  const ListViewPage({super.key});


  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    database.getTestMarker();
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView Page'),
      ),
      body: buildListView(),
    );
  }

  ListView buildListView() {
    return ListView(
      children: const <Widget>[
        ListTile(
          title: Text('Item 1'),
        ),
        ListTile(
          title: Text('Item 2'),
        ),
        ListTile(
          title: Text('Item 3'),
        ),
        // Add more ListTiles as needed
      ],
    );
  }
}
