
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:list_roamer/model/UserMarker.dart';

import '../model/UserList.dart';
import 'api_path.dart';
import 'firestore_service.dart';

abstract class Database {
  Stream<Marker> getTestMarker();
}

class FirestoreDatabase implements Database {
  FirestoreDatabase({required this.uid});
  
  final String uid;
  final _service = FirestoreService.instance; //Singleton for the service class.

  String testLocationId = 'Qq2al9a0o9mTwX2FPxtm';

  @override
  Stream<Marker> getTestMarker() => _service.documentStream(
      path: APIPath.getTestMarker(locationId: testLocationId),
      builder: (data, documentId) => UserMarker.createMarker(data!)
  );

}