import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../model/user_list.dart';
import '../model/user_marker.dart';
import '../services/database.dart';
import '../ui_widgets/add_places_modal.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key, required this.userList}) : super(key: key);
  final UserList? userList;

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late String listId;
  late String listTitle;

  @override
  void initState() {
    super.initState();
    listId = widget.userList?.id ?? "";
    listTitle = widget.userList?.title ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('ListRoamer - $listTitle'),
      ),
      body: StreamBuilder<List<UserMarker>>(
        stream: database.markerStream(listId: listId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            print('Maps Page - Error: ${snapshot.error}');
            return Text('Error: ${snapshot.error}');
          } else {
            List<UserMarker> markers = snapshot.data ?? [];
            return _buildMapWithMarkers(markers);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddPlacesDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildMapWithMarkers(List<UserMarker> markers) {
    return GoogleMap(
      onMapCreated: (GoogleMapController controller) {},
      initialCameraPosition: const CameraPosition(
        target: LatLng(39.1178, -106.4454),
        zoom: 6.0,
      ),
      markers: Set<Marker>.of(markers),
    );
  }

  void _showAddPlacesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Dialog(
          child: AddPlaceModal(),
        );
      },
    );
  }
}

