// Common API class for keeping track of FireStore Paths. Best practice
class APIPath {

  // /users/testUser/lists/testList_1/location_markers/test_location_1
  static String locationMarkers({required String listId}) => 'users/testUser/list/$listId/location_markers/'; // Returns all location Markers for the list
  static String location({required String listId, required String locationId}) => 'users/testUser/list/$listId/location_markers/$locationId'; // Returns a target location Markers from the list
}