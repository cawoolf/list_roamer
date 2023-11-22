import 'package:google_maps_flutter/google_maps_flutter.dart';

class PeakMarker {
  static Marker createMarker(Map<String, dynamic> peakData) {
    String name = peakData['name'];
    double elevation = peakData['elevation'].toDouble();
    double latitude = peakData['coordinates']['latitude'].toDouble();
    double longitude = peakData['coordinates']['longitude'].toDouble();

    return Marker(
      markerId: MarkerId(name),
      position: LatLng(latitude, longitude),
      infoWindow: InfoWindow(
        title: name,
        snippet: 'Elevation: $elevation meters',
      ),
    );
  }
}