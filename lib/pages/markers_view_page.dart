import 'package:flutter/material.dart';
import 'package:list_roamer/services/database.dart';
import 'package:list_roamer/services/helpers/json_helper.dart';
import 'package:list_roamer/services/helpers/json_marker_helper.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: Text("Marker Read Test- ${userList!.title}"),
      ),
      body: StreamBuilder<List<UserMarker>>(
        stream: database.markerStream(listId: userList!.id),
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
                    addMarkersToListTest(userList!);
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

  void addMarkersToListTest(UserList userList) async {
    print('Add button tapped in MarkersViewPage');
    // Read the JSON Data and turn it into Markers
    String peaksAssetRoute = 'assets/json_data/peak_location.json'; // Peak data\
    String peaksDataName = 'peaks';
    String sushiAssetRoute = 'assets/json_data/sushi_location.json';
    String sushiDataName = 'sushi';

     List<UserMarker> jsonMarkers = await createMarkersFromJson(sushiAssetRoute, sushiDataName);
    // List<UserMarker> jsonMarkers = await createMarkersFromJson(peaksAssetRoute, peaksDataName);
     // print(jsonMarkers);
    // Write those Markers to the correct list in Firebase
    writePeaksMarkersToFirebase(jsonMarkers, userList);
  }

  Future<List<UserMarker>> createMarkersFromJson(String assetRoute, String dataName) async {
    Future<List<dynamic>> jsonData = JSONHelper.loadJsonData(assetRoute: assetRoute, dataName: dataName);
    List<dynamic> data = await jsonData;
    List<UserMarker> jsonMarkers = JsonMarkerHelper.getJsonMarkers(jsonData: data);
    return jsonMarkers;
  }

  void writePeaksMarkersToFirebase(List<UserMarker> jsonMarkers, UserList userList) {
    jsonMarkers.forEach((marker) {
      database.setUserMarker(marker, userList, marker.markerId);
    });
  }
}