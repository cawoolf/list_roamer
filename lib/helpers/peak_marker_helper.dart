import 'package:google_maps_flutter/google_maps_flutter.dart';

class PeakMarkerHelper {
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

  static List<Marker> getPeakMarkers({required List<dynamic> peaks}) {
    List<Marker> newMarkers = peaks.map((peak) {
      return Marker(
        markerId: MarkerId(peak['name']),
        position: LatLng(peak['coordinates']['latitude'],
            peak['coordinates']['longitude']),
        infoWindow:
        InfoWindow(title: peak['name'], snippet: '${peak['elevation']} feet'),
      );
    }).toList();

    return newMarkers;
  }
}