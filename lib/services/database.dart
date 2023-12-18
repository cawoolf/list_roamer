
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../model/user_list.dart';
import '../model/user_marker.dart';
import 'api_path.dart';
import 'firestore_service.dart';

abstract class Database {
  Stream<UserMarker> getTestMarker();
  Stream<List<UserList>> userListsStream();
  Stream<UserMarker> markerStream();
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

  @override
  Stream<List<UserList>> userListsStream() {
    return _service.collectionStream(
        path: APIPath.userLists(userId: uid),
        builder: (data, documentId) => UserList.fromMap(data, documentId)); // Still not really sure where the data, and documentId variables come from.
  }

  @override
  Stream<UserMarker> markerStream() {
    // TODO: implement markerStream
    throw UnimplementedError();
  }

  // /users/testUser/lists/testList_1/location_markers/test_location_1

}