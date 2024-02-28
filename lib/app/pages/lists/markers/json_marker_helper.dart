import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../model/user_marker.dart';




class JsonMarkerHelper {
  static UserMarker createMarker(Map<String, dynamic> jsonData) {
    String name = jsonData['name'];
    String snippet = jsonData['snippet'];
    double latitude = jsonData['coordinates']['latitude'].toDouble();
    double longitude = jsonData['coordinates']['longitude'].toDouble();

    return UserMarker(
      markerId: MarkerId(name),
      position: LatLng(latitude, longitude),
      infoWindow: InfoWindow(
        title: name,
        snippet: snippet,
      ),
      name: name,
      snippet: snippet,
      latitude: latitude,
      longitude: longitude,
    );
  }

  static List<UserMarker> getJsonMarkers({required List<dynamic> jsonData}) {
    List<UserMarker> jsonMarkers = jsonData.map((peak) {
      return JsonMarkerHelper.createMarker(peak);
    }).toList();
    return jsonMarkers;
  }
}
