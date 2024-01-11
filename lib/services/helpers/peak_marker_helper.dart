import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../model/user_marker.dart';

class PeakMarkerHelper {
  static UserMarker createMarker(Map<String, dynamic> peakData) {
    String name = peakData['name'];
    double elevation = peakData['elevation'].toDouble();
    String snippet = 'Elevation: $elevation meters';
    double latitude = peakData['coordinates']['latitude'].toDouble();
    double longitude = peakData['coordinates']['longitude'].toDouble();

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

  static List<UserMarker> getPeakMarkers({required List<dynamic> peaks}) {
    List<UserMarker> peakMarkers = peaks.map((peak) {
      return PeakMarkerHelper.createMarker(peak);
    }).toList();
    return peakMarkers;
  }
}
