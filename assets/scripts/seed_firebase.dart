import 'package:firedart/firedart.dart';

Future<void> main() async {
  Firestore.initialize("listroamer");

  readTest();
  writeTest();

}

void readTest() async {
  var map = await Firestore.instance.collection("users").get();
  print(map.toString());
  var path = '/users/testUser/lists/testList_3/location_markers/Blanca Peak';
  var peak = await Firestore.instance.document(path).get();
  print(peak.toString());
  Firestore.instance.close();
}

void writeTest() async {
  var path = '/users/testUser/lists/scriptTestList/location_markers/Flutter Peak 4';
  Map<String, dynamic> data = {
    "name": "Flutter Peak 4",
    "snippet": "Elevation 15000",
    "latitude": 40,
    "longitude": -74,
  };
  final reference = Firestore.instance.document(path);
  print('$path: $data');
  try {
    await reference.set(data);
  } catch (e) {
    print("Firestore Set Error: $e");
  }
  Firestore.instance.close();

}
