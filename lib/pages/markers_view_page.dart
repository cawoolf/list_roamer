import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MarkersViewPage extends StatelessWidget {
  final QueryDocumentSnapshot<Object?> document;

  const MarkersViewPage({Key? key, required this.document}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Implement the UI to display details of the selected list.
    String documentId = document.id;
    String locationCollectionPath =
        '/users/testUser/lists/$documentId/location_markers';

    print(document.id);
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
              return Column(
                children: buildMarkerListView(document),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  List<Widget> buildMarkerListView(QueryDocumentSnapshot<Object?> document) {
    return [
      ListTile(title: Text(document['name'])),
      ListTile(title: Text(document['snippet'])),
      ListTile(title: Text(document['latitude'])),
      ListTile(title: Text(document['longitude'])),
    ];
  }
}
