import 'dart:js';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../services/database.dart';

class ListViewPage extends StatelessWidget {
  const ListViewPage({super.key});


  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    Marker testMarker = database.getTestMarker() as Marker;
    print(testMarker.toString());
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
