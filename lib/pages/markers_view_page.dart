import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class MarkersViewPage extends StatelessWidget {
  final QueryDocumentSnapshot<Object?> document;

  const MarkersViewPage({Key? key, required this.document}) : super(key: key);

  ListView buildListView(String name, String snippet, String latitude, String longitude) {
    return ListView(
      children: [
        ListTile(
          title: Text('Field 1: ${document['field1']}'),
        ),
        ListTile(
          title: Text('Field 2: ${document['field2']}'),
        ),
        // Add more ListTiles for other fields as needed
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    // Implement the UI to display details of the selected list.
    String documentId = 'testList_1';
    String locationCollectionPath =
        '/users/testUser/lists/$documentId/location_markers';


    return Scaffold(
      appBar: AppBar(
        title: const Text("Marker Read Test"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(locationCollectionPath)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((document) {
              return Center(child: Text(document['name']));
            }).toList(),
          );
        },
      ),
    );
  }
}