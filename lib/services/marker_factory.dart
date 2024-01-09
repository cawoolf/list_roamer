import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../model/user_marker.dart';

class MarkerFactory {
  static UserMarker createMarker(Map<String, dynamic> data) {
    String name = data['name'];
    String snippet = data['snippet'];
    double latitude =
        data['latitude'] != null ? double.parse(data['latitude']) : 0.0;
    double longitude =
        data['longitude'] != null ? double.parse(data['longitude']) : 0.0;

    return UserMarker(
      markerId: MarkerId(name),
      position: LatLng(latitude, longitude),
      infoWindow: InfoWindow(
        title: name,
        snippet: '$snippet',
      ),
      name: name,
      snippet: snippet,
      latitude: latitude,
      longitude: longitude,
    );
  }
}
