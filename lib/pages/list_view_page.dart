import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../services/database.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage({super.key});

  @override
  State<StatefulWidget> createState() => ListViewPageState();
}

class ListViewPageState extends State<ListViewPage> {
  @override
  void initState() {
    super.initState();
    fireBaseReadTest();
  }

  @override
  Widget build(BuildContext context) {
    return fireBaseReadTest();
  }

  ListView buildListView(
      String name, String snippet, String latitude, String longitude) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text(name),
        ),
        ListTile(
          title: Text(snippet),
        ),
        ListTile(
          title: Text(latitude),
        ),
        ListTile(
          title: Text(longitude),
        ),
        // Add more ListTiles as needed
      ],
    );
  }

  Scaffold fireBaseReadTest() {
    String locationCollectionPath =
        '/users/testUser/lists/testList_1/location_markers';

    String listCollectionPath =
        '/users/testUser/lists';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase Read Test"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(listCollectionPath)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((document) {
              return Center(child: Text(document['title']));
            }).toList(),
          );
          // return ListView.builder(
          //     itemCount: snapshot.data!.docs.length,
          //     itemBuilder: (context, index) {
          //       var document = snapshot.data!.docs[index];
          //       return buildListView(document['name'], document['snippet'],
          //           document['latitude'], document['longitude']);
          //     });
        },
      ),
    );
  }
}
