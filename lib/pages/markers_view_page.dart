import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
    String listId = userList!.id;
    String locationCollectionPath = '/users/testUser/lists/$listId/location_markers';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Marker Read Test"),
      ),
      body: StreamBuilder<List<Marker>>(
        stream: database.markerStream(listId: listId), // Use the new method here
        builder: (BuildContext context, AsyncSnapshot<List<Marker>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data!.map((Marker marker) {
              return Column(
                children: buildMarkerListView(marker),
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


  // Need to create a UserMarker class just like for UserLists
  List<Widget> buildMarkerListView(Marker marker) {
    return [
      ListTile(title: Text(marker.name)), // Assuming 'name' is a property of your Marker class
      ListTile(title: Text(marker.snippet)),
      ListTile(title: Text(marker.latitude)),
      ListTile(title: Text(marker.longitude)),
    ];
  }

  void addMarkersToList() {
    print('Add button tapped in MarkersViewPage');
  }
}