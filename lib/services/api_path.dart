// Common API class for keeping track of FireStore Paths. Best practice
class APIPath {

  // /users/testUser/lists/testList_1/location_markers/test_location_1
  static String locationMarkers({required String userId, required String listId}) => 'users/$userId/lists/$listId/location_markers/'; // Returns all location Markers for the list
  static String location({required String listId, required String locationId}) => 'users/testUser/lists/$listId/location_markers/$locationId'; // Returns a target location Markers from the list
  static String userLists({required String userId}) => 'users/$userId/lists/';
  static String userList({required String userId, required String listId}) => 'users/$userId/lists/$listId';

}