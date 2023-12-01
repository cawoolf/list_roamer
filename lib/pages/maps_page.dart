import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';

import '../services/helpers/json_helper.dart';
import '../services/helpers/peak_marker_helper.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  MapPageState createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    loadMarkers();
  }


  Future<void> loadMarkers() async {
    try {
      String peaksJsonAssetRoute = 'assets/json_data/peak_location.json';
      List<dynamic> peaks = await JSONHelper.loadJsonData(assetRoute: peaksJsonAssetRoute);
      List<Marker> peakMarkers = PeakMarkerHelper.getPeakMarkers(peaks: peaks);

      setState(() {

        markers = peakMarkers;
      });

    } catch (e) {
      if (kDebugMode) {
        print('Error loading JSON data: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListRoamer - Colorado Peaks'),
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        initialCameraPosition: const CameraPosition(
          target: LatLng(39.1178, -106.4454), // Initial camera position
          zoom: 6.0,
        ),
        markers: Set<Marker>.of(markers),
      ),
    );
  }
}
