import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserMarker {
  static Marker createMarker(Map<String, dynamic> data) {
    String name = data['name'];
    double snippet = data['snippet'].toStrings();
    double latitude = data['latitude'].toDouble();
    double longitude = data['longitude'].toDouble();

    return Marker(
      markerId: MarkerId(name),
      position: LatLng(latitude, longitude),
      infoWindow: InfoWindow(
        title: name,
        snippet: '$snippet',
      ),
    );
  }
}
