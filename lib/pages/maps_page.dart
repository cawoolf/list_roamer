import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../model/user_list.dart';
import '../model/user_marker.dart';
import '../services/database.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key, required this.userList}) : super(key: key);
  final UserList? userList;


  @override
  Widget build(BuildContext context) {

    final database = Provider.of<Database>(context, listen: false);

    String? listId = userList?.id;
    String? listTitle = userList?.title;

    return Scaffold(
      appBar: AppBar(
        title: Text('ListRoamer - $listTitle'),
      ),
      body: StreamBuilder<List<UserMarker>>(
        stream: database.markerStream(listId: listId as String),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            print('Error: ${snapshot.error}');
            return Text('Error: ${snapshot.error}');
          } else {
            List<UserMarker> markers = snapshot.data ?? [];

            return GoogleMap(
              onMapCreated: (GoogleMapController controller) {
              },
              initialCameraPosition: const CameraPosition(
                target: LatLng(39.1178, -106.4454),
                zoom: 6.0,
              ),
              markers: Set<Marker>.of(markers),
            );
          }
        },
      ),
    );
  }
}
