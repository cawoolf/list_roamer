import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:the_spotz/helpers/json_reader.dart';

import 'models/peak_marker.dart';

class GoogleMapsPage extends StatefulWidget {
  @override
  State<GoogleMapsPage> createState() => GoogleMapsPageState();
}

class GoogleMapsPageState extends State<GoogleMapsPage> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(37.7749, -122.4194); // San Francisco coordinates

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Maps App'),
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
        markers: _createMarkersFromJSON(),
      ),
    );
  }

  // Set<Marker> _createMarkers() {
  //   // Replace this with your custom list of locations
  //   return {
  //     Marker(
  //       markerId: MarkerId('marker1'),
  //       position: LatLng(37.7749, -122.4194),
  //       infoWindow: InfoWindow(title: 'Burger Restaurant 1',
  //           snippet: 'Mandy gives good head here'),
  //     ),
  //     Marker(
  //       markerId: MarkerId('marker2'),
  //       position: LatLng(37.7849, -122.4294),
  //       infoWindow: InfoWindow(title: 'Burger Restaurant 2'),
  //     ),
  //     // Add more markers as needed
  //   };
  // }

  Set<Marker> _createMarkersFromJSON() {
    // Replace 'your_file_path.json' with the actual path to your JSON file
    String jsonFilePath = 'assets/json_data/peak_location.json';

    // Read JSON file and convert to a list of Map<String, dynamic> objects
    Set<Map<String, dynamic>> peaks = JSONReader.readJsonFile(jsonFilePath);

    // Create Marker objects using PeakMarker.createMarker function
    Set<Marker> markers = peaks.map((peakData) => PeakMarker.createMarker(peakData)).toSet();

    // Now 'markers' is a list of Marker objects that you can use in your Google Maps implementation
    return markers;
  }
}