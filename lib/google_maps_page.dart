import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';
import 'package:the_spotz/helpers/peak_marker_helper.dart';

import 'helpers/json_helper.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

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


  Future<void> loadMarkers() async {
    try {

      List<dynamic> peaks = await JSONHelper.loadJsonData();
      List<Marker> peakMarkers = PeakMarkerHelper.getPeakMarkers(peaks: peaks);

      setState(() async {

        markers = peakMarkers;
      });

    } catch (e) {
      print('Error loading JSON data: $e');
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
