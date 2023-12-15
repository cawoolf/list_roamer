
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'markers_view_page.dart';


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

  Scaffold fireBaseReadTest() {
    String locationCollectionPath =
        '/users/testUser/lists/testList_1/location_markers';

    String listCollectionPath =
        '/users/testUser/lists';

    return Scaffold(
      appBar: AppBar(
        title: const Text("List Read Test"),
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
              return GestureDetector(
                onTap: () {
                  // Handle the navigation to a new page with the document data.
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MarkersViewPage(document: document),
                    ),
                  );
                },
                child: Center(
                  child: Text(document['title']),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
