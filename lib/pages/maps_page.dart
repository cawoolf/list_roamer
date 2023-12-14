import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    // loadMarkers();
    fireBaseReadTest();
  }

  Scaffold fireBaseReadTest() {

    String locationMarkerCollectionPath = '/users/testUser/lists/testList_1/location_markers';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Firebase Read Test"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection(locationMarkerCollectionPath).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((document) {
              return Center(child: Text(document['name']));
            }).toList(),
          );
        },
      ),
    );

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


  // Firebase Read Test Build
  @override
  Widget build(BuildContext context) {
    return fireBaseReadTest();
  }

  // Original build method
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('ListRoamer - Colorado Peaks'),
  //     ),
  //     body: GoogleMap(
  //       onMapCreated: (GoogleMapController controller) {
  //         mapController = controller;
  //       },
  //       initialCameraPosition: const CameraPosition(
  //         target: LatLng(39.1178, -106.4454), // Initial camera position
  //         zoom: 6.0,
  //       ),
  //       markers: Set<Marker>.of(markers),
  //     ),
  //   );
  // }
}
