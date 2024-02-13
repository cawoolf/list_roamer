import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../model/user_list.dart';
import '../model/user_marker.dart';
import '../services/database.dart';
import '../ui_widgets/add_places_modal.dart';

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
            print('Maps Page - Error: ${snapshot.error}');
            return Text('Error: ${snapshot.error}');
          } else {
            List<UserMarker> markers = snapshot.data ?? [];
            return Stack(
              children: [
                GoogleMap(
                  onMapCreated: (GoogleMapController controller) {},
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(39.1178, -106.4454),
                    zoom: 6.0,
                  ),
                  markers: Set<Marker>.of(markers),
                ),
                Positioned(
                  bottom: 54.0,
                  right: 64.0,
                  child: FloatingActionButton(
                    onPressed: () {
                      // Add your onPressed functionality here
                      // triggerAddPlaceModal(context);
                      _showAddPlacesDialog(context);
                    },
                    child: Icon(Icons.add),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  void triggerAddPlaceModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AddPlaceModal();
      },
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