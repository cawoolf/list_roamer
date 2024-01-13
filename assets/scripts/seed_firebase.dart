// Script for seeding the Firebase DB with JSON Data
import 'package:list_roamer/model/user_list.dart';
import 'package:list_roamer/model/user_marker.dart';
import 'package:list_roamer/services/database.dart';
import 'package:list_roamer/services/helpers/json_helper.dart';
import 'package:list_roamer/services/helpers/json_marker_helper.dart';


Future<void> main() async {
  print('seed firebase script running');
  Database database = FirestoreDatabase(uid: 'testUser');
  writeTestList(database);
}

void writeTestList(Database database) {
  print('Add more lists tapped!');
  UserList testWrite = UserList(title: 'Test Script Write',category: 'testing',id: documentIdFromCurrentDate());
  database.setUserList(testWrite);
}


// Methods for Markers
void addMarkersToListTest(UserList userList, Database database) async {
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
  writePeaksMarkersToFirebase(jsonMarkers, userList, database);
}

Future<List<UserMarker>> createMarkersFromJson(String assetRoute, String dataName) async {
  Future<List<dynamic>> jsonData = JSONHelper.loadJsonData(assetRoute: assetRoute, dataName: dataName);
  List<dynamic> data = await jsonData;
  List<UserMarker> jsonMarkers = JsonMarkerHelper.getJsonMarkers(jsonData: data);
  return jsonMarkers;
}

void writePeaksMarkersToFirebase(List<UserMarker> jsonMarkers, UserList userList, Database database) {
  for (var marker in jsonMarkers) {
    database.setUserMarker(marker, userList, marker.markerId);
  }
}