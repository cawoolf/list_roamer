import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserMarker extends Marker {
  const UserMarker({
    required this.name,
    required this.snippet,
    required this.latitude,
    required this.longitude,
    required super.markerId,
    required LatLng position,
    required InfoWindow infoWindow,
  });

  final String name;
  final String snippet;
  final double latitude;
  final double longitude;

  factory UserMarker.fromMap(Map<String, dynamic> data) {
    String name = data['name'];
    String snippet = data['snippet'];
    double latitude = data['latitude'];
    double longitude = data['longitude'];

    return UserMarker(
      name: name,
      snippet: snippet,
      latitude: latitude,
      longitude: longitude,
      markerId: MarkerId(name),
      position: LatLng(latitude, longitude),
      infoWindow: InfoWindow(
        title: name,
        snippet: '$snippet',
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'snippet': snippet,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
