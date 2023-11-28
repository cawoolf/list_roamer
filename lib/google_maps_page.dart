import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';
import 'package:the_spotz/helpers/json_reader.dart';

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

  Future<String> _loadJsonData() async {
    return await rootBundle.loadString('assets/json_data/peak_location.json');
  }


  Future<List<dynamic>> _loadJsonData2() async {
    String jsonString = await rootBundle.loadString('assets/json_data/peak_location.json');
    Map<String, dynamic> data = json.decode(jsonString);
    List<dynamic> peaks = data['peaks'];
    return peaks;
  }

  Future<void> loadMarkers() async {
    try {

      List<dynamic> peaks = await JSONHelper.loadJsonData();

      List<Marker> newMarkers = peaks.map((peak) {
        return Marker(
          markerId: MarkerId(peak['name']),
          position: LatLng(peak['coordinates']['latitude'],
              peak['coordinates']['longitude']),
          infoWindow:
              InfoWindow(title: peak['name'], snippet: '${peak['elevation']} feet'),
        );
      }).toList();

      setState(() {
        markers = newMarkers;
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
