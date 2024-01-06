
import 'dart:html';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../model/user_list.dart';
import 'api_path.dart';
import 'firestore_service.dart';
import 'marker_factory.dart';

abstract class Database {

  Future<void> setUserList(UserList userList);
  Stream<List<UserList>> userListsStream();
  Stream<List<Marker>> markerStream({required String listId});
}

class FirestoreDatabase implements Database {
  FirestoreDatabase({required this.uid});
  
  final String uid;
  final _service = FirestoreService.instance; //Singleton for the service class.

  // Set date regardless of if it is a new or existing document
  @override
  Future<void> setUserList(UserList userList) =>
      _service.setData(path: APIPath.userList(userId: uid, listId: userList.id), data: userList.toMap());

  @override
  Stream<List<UserList>> userListsStream() {
    return _service.collectionStream(
        path: APIPath.userLists(userId: uid),
        builder: (data, documentId) => UserList.fromMap(data, documentId)); // Still not really sure where the data, and documentId variables come from.
  }

  @override
  Stream<List<Marker>> markerStream({required String listId}) {

    // print(APIPath.locationMarkers(userId: uid, listId: listId));
    return _service.collectionStream(
      path: APIPath.locationMarkers(userId: uid, listId: listId),
      builder: (data, documentId) => MarkerFactory.createMarker(data),
    );
  }


  // /users/testUser/lists/testList_1/location_markers/test_location_1

}