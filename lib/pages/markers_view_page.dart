import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:list_roamer/services/database.dart';

import '../model/user_list.dart';

class MarkersViewPage extends StatelessWidget {
  final UserList? userList;
  final Database database;

  const MarkersViewPage({Key? key, required this.userList, required this.database}) : super(key: key);

  static Future<void> show(BuildContext context, {required UserList? userList, required Database database}) async {
    await Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
      builder: (context) => MarkersViewPage(userList: userList, database: database,),
      fullscreenDialog: true,
    ));
  }

  @override
  Widget build(BuildContext context) {
    String? documentId = userList?.id;
    String locationCollectionPath = '/users/testUser/lists/$documentId/location_markers';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Marker Read Test"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection(locationCollectionPath).snapshots(),
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
      floatingActionButton: Positioned(
        bottom: 56.0,
        right: 16.0,
        child: FloatingActionButton(
          onPressed: () {
            addMarkersToList();
          },
          child: Icon(Icons.add),
        ),
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

  void addMarkersToList() {
    print('Add button tapped in MarkersViewPage');
  }
}