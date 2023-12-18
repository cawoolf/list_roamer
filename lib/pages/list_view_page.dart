
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:list_roamer/model/user_list_tile.dart';
import 'package:list_roamer/services/database.dart';
import 'package:provider/provider.dart';
import '../model/user_list.dart';
import '../services/helpers/list_item_builder.dart';
import 'markers_view_page.dart';


class ListViewPage extends StatefulWidget {
  const ListViewPage({Key? key});

  @override
  State<StatefulWidget> createState() => ListViewPageState();
}

class ListViewPageState extends State<ListViewPage> {
  @override
  void initState() {
    super.initState();
    fireBaseReadTest();
  }

  @override
  Widget build(BuildContext context) {
    return fireBaseReadTest();
  }

  Scaffold fireBaseReadTest() {

    final database = Provider.of<Database>(context, listen: false);
    // String locationCollectionPath =
    //     '/users/testUser/lists/testList_1/location_markers';
    //
    // String listCollectionPath =
    //     '/users/testUser/lists';

    return Scaffold(
      appBar: AppBar(
        title: const Text("List Read Test"),
      ),
      body: StreamBuilder<List<UserList?>>(
        stream: database.userListsStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListItemsBuilder(
              snapshot: snapshot,
              itemBuilder: (context, userList) => Dismissible(
                key: Key('userList-${userList?.title}'),
                background: Container(color: Colors.red),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) => (),
                child: UserListTile(list: userList, onTap: () {},),
              ));
        },
      ),
    );
  }
}

