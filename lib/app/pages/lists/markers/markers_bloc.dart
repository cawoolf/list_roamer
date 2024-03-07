import 'package:firedart/auth/user_gateway.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../services/database.dart';
import '../../../../services/helpers/json_helper.dart';
import '../../../model/user_list.dart';
import '../../../model/user_marker.dart';
import 'json_marker_helper.dart';


// Need to study BLoCs again. Not sure why time_tracker use it with a Provider
class MarkersBloc {
  MarkersBloc({required this.database, required this.userList});
  final Database database;
  final UserList userList;

  UserList get getUserList => (userList);

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
    String peaksAssetRoute = 'assets/json_data/peak_location.json'; // Peak data\
    String peaksDataName = 'peaks';

    String sushiAssetRoute = 'assets/json_data/sushi_location.json';
    String sushiDataName = 'sushi';

    String cragAssetRoute = 'assets/json_data/mountain_project_crags.json'; // MP Data
    String cragDataName = 'crags';


    // List<UserMarker> jsonMarkers = await createMarkersFromJson(sushiAssetRoute, sushiDataName);

    List<UserMarker> jsonMarkers = await createMarkersFromJson(cragAssetRoute, cragDataName);
    // List<UserMarker> jsonMarkers = await createMarkersFromJson(peaksAssetRoute, peaksDataName);
    // print(jsonMarkers);
    // Write those Markers to the correct list in Firebase
    writePeaksMarkersToFirebase(jsonMarkers);
  }

  Future<List<UserMarker>> createMarkersFromJson(String assetRoute, String dataName) async {
    Future<List<dynamic>> jsonData = JSONHelper.loadJsonData(assetRoute: assetRoute, dataName: dataName);
    List<dynamic> data = await jsonData;
    List<UserMarker> jsonMarkers = JsonMarkerHelper.getJsonMarkers(jsonData: data);
    return jsonMarkers;
  }

  void writePeaksMarkersToFirebase(List<UserMarker> jsonMarkers) {
    jsonMarkers.forEach((marker) {
      database.setUserMarker(marker, userList, marker.markerId);
    });
  }

  Stream<List<UserMarker>> markerStream() {
    return database.markerStream(listId: userList!.id);
  }
}