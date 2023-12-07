
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:list_roamer/model/UserMarker.dart';

import '../model/UserList.dart';
import 'api_path.dart';
import 'firestore_service.dart';

abstract class Database {
  Stream<UserMarker> getTestMarker();
}

class FirestoreDatabase implements Database {
  FirestoreDatabase({required this.uid});
  
  final String uid;
  final _service = FirestoreService.instance; //Singleton for the service class.

  String testLocationId = 'test_location_1';
  String testListId = 'testList_1';

  @override
  Stream<UserMarker> getTestMarker() => _service.documentStream(
      path: APIPath.location(locationId: testLocationId, listId: testListId),
      builder: (data, documentId) => UserMarker.createMarker(data!) as UserMarker,
  );

  // /users/testUser/lists/testList_1/location_markers/test_location_1

}