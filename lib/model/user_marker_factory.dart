import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'user_marker.dart';

class MarkerFactory {
  static UserMarker createMarker(Map<String, dynamic> data) {
    String name = data['name'];
    String snippet = data['snippet'];

    // Print latitude and longitude before parsing
    double latitude = data['latitude'] != null ? double.tryParse(data['latitude'].toString()) ?? 0.0 : 0.0;
    double longitude = data['longitude'] != null ? double.tryParse(data['longitude'].toString()) ?? 0.0 : 0.0;

    UserMarker userMarker = UserMarker(
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
    
    return userMarker;
  }
}
