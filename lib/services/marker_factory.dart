import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../model/user_marker.dart';

class MarkerFactory {
  static UserMarker createMarker(Map<String, dynamic> data) {
    print('MarkerFactory- $data');
    String name = data['name'];
    String snippet = data['snippet'];

    // Print latitude and longitude before parsing
    print('Latitude: ${data['latitude']}, Longitude: ${data['longitude']}');

    double latitude = data['latitude'] != null ? double.tryParse(data['latitude'].toString()) ?? 0.0 : 0.0;
    double longitude = data['longitude'] != null ? double.tryParse(data['longitude'].toString()) ?? 0.0 : 0.0;

    // Print latitude and longitude after parsing
    print('Parsed Latitude: $latitude, Parsed Longitude: $longitude');

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

    print(userMarker.position.toString());
    return userMarker;
  }
}
