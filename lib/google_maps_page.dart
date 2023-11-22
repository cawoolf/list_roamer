import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:the_spotz/helpers/json_reader.dart';

import 'models/peak_marker.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    loadMarkers();
  }

  void loadMarkers() async {
    // Load your JSON data (replace this with your actual file reading logic)
    String jsonString = '''
     {
  "peaks": [
    {
      "name": "Mount Elbert",
      "elevation": 14440,
      "coordinates": {
        "latitude": 39.1178,
        "longitude": -106.4454
      }
    },
    {
      "name": "Mount Massive",
      "elevation": 14421,
      "coordinates": {
        "latitude": 39.1875,
        "longitude": -106.4753
      }
    },
    {
      "name": "Mount Harvard",
      "elevation": 14420,
      "coordinates": {
        "latitude": 38.9244,
        "longitude": -106.3208
      }
    },
    {
      "name": "Blanca Peak",
      "elevation": 14351,
      "coordinates": {
        "latitude": 37.5775,
        "longitude": -105.4856
      }
    },
    {
      "name": "La Plata Peak",
      "elevation": 14336,
      "coordinates": {
        "latitude": 39.0294,
        "longitude": -106.4727
      }
    },
    {
      "name": "Uncompahgre Peak",
      "elevation": 14309,
      "coordinates": {
        "latitude": 38.0717,
        "longitude": -107.4629
      }
    },
    {
      "name": "Crestone Peak",
      "elevation": 14294,
      "coordinates": {
        "latitude": 37.9665,
        "longitude": -105.5858
      }
    },
    {
      "name": "Mount Lincoln",
      "elevation": 14286,
      "coordinates": {
        "latitude": 39.3514,
        "longitude": -106.1111
      }
    },
    {
      "name": "Grays Peak",
      "elevation": 14270,
      "coordinates": {
        "latitude": 39.6339,
        "longitude": -105.8174
      }
    },
    {
      "name": "Mount Antero",
      "elevation": 14269,
      "coordinates": {
        "latitude": 38.6748,
        "longitude": -106.2467
      }
    }
  ]
}
    ''';

    // Parse JSON
    Map<String, dynamic> data = json.decode(jsonString);
    List<dynamic> peaks = data['peaks'];
    print(peaks);

    // Create markers
    List<Marker> newMarkers = peaks.map((peak) {
      return Marker(
        markerId: MarkerId(peak['name']),
        position: LatLng(peak['coordinates']['latitude'], peak['coordinates']['longitude']),
        infoWindow: InfoWindow(title: peak['name']),
      );
    }).toList();

    // Update the markers state
    setState(() {
      markers = newMarkers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: (GoogleMapController controller) {
        mapController = controller;
      },
      initialCameraPosition: CameraPosition(
        target: LatLng(39.1178, -106.4454), // Initial camera position
        zoom: 6.0,
      ),
      markers: Set<Marker>.of(markers),
    );
  }
}