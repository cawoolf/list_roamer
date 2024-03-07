import 'package:flutter/material.dart';
import 'package:list_roamer/app/pages/lists/markers/markers_bloc.dart';
import 'package:list_roamer/services/database.dart';
import 'package:list_roamer/services/helpers/json_helper.dart';

import '../../../model/user_list.dart';
import '../../../model/user_marker.dart';
import 'json_marker_helper.dart';


class MarkersViewPage extends StatelessWidget {
  final UserList userList;
  final Database database;

  const MarkersViewPage({Key? key, required this.userList, required this.database}) : super(key: key);

  static Future<void> show(BuildContext context, {required UserList userList, required Database database}) async {
    await Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
      builder: (context) => MarkersViewPage(userList: userList, database: database,),
      fullscreenDialog: true,
    ));
  }

  @override
  Widget build(BuildContext context) {

    MarkersBloc bloc = MarkersBloc(database: database, userList: userList);

    return Scaffold(
      appBar: AppBar(
        title: Text("Marker Read Test- ${bloc.getUserList.title}"),
      ),
      body: StreamBuilder<List<UserMarker>>(
        stream: bloc.markerStream(),
        builder: (BuildContext context, AsyncSnapshot<List<UserMarker>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Stack(
            children: [
              ListView(
                children: snapshot.data!.map((UserMarker marker) {
                  return Column(
                    children: bloc.buildMarkerListView(marker),
                  );
                }).toList(),
              ),
              Positioned(
                bottom: 56.0,
                right: 16.0,
                child: FloatingActionButton(
                  onPressed: () {
                    // addMarkersToListTest(userList!);
                  },
                  child: Icon(Icons.add),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

}