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
  }) : super(
    position: position,
    infoWindow: infoWindow,
  );

  final String name;
  final String snippet;
  final double latitude;
  final double longitude;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'snippet': snippet,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
