import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:list_roamer/services/database.dart';
import 'package:list_roamer/services/helpers/json_helper.dart';
import 'package:list_roamer/services/helpers/peak_marker_helper.dart';

import '../model/user_list.dart';
import '../model/user_marker.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: const Text("Marker Read Test"),
      ),
      body: StreamBuilder<List<UserMarker>>(
        stream: database.markerStream(listId: listId),
        builder: (BuildContext context, AsyncSnapshot<List<UserMarker>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Stack(
            children: [
              ListView(
                children: snapshot.data!.map((UserMarker marker) {
                  return Column(
                    children: buildMarkerListView(marker),
                  );
                }).toList(),
              ),
              Positioned(
                bottom: 56.0,
                right: 16.0,
                child: FloatingActionButton(
                  onPressed: () {
                    addMarkersToListTest();
                  },
                  child: Icon(Icons.add),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // Need to create a UserMarker class just like for UserLists
  List<Widget> buildMarkerListView(UserMarker marker) {
    return [
      ListTile(title: Text(marker.name)), // Assuming 'name' is a property of your Marker class
      ListTile(title: Text(marker.snippet)),
      ListTile(title: Text(marker.latitude.toString())),
      ListTile(title: Text(marker.longitude.toString())),
    ];
  }

  void addMarkersToListTest() async {
    print('Add button tapped in MarkersViewPage');
    // Read the JSON Data and turn it into Markers
     List<UserMarker> peakMarkers = await createMarkersFromJson();
     print(peakMarkers);
    // Write those Markers to the correct list in Firebase
    writePeaksMarkersToFirebase();
  }

  Future<List<UserMarker>> createMarkersFromJson() async {
    Future<List<dynamic>> peakJsonData = JSONHelper.loadJsonData(assetRoute: 'assets/json_data/peak_location.json', dataName: 'peaks');
    List<dynamic> peaks = await peakJsonData;
    List<UserMarker> peaksMarkers = PeakMarkerHelper.getPeakMarkers(peaks: peaks);
    return peaksMarkers;
  }

  void writePeaksMarkersToFirebase() {}
}