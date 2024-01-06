
import 'package:flutter/material.dart';
import 'package:list_roamer/model/user_list_tile.dart';
import 'package:list_roamer/services/database.dart';
import 'package:provider/provider.dart';
import '../model/user_list.dart';
import '../services/helpers/list_item_builder.dart';
import 'markers_view_page.dart';

class ListViewPage extends StatelessWidget {
  const ListViewPage({Key? key, required this.onUserListSelected})
      : super(key: key);

  final Function(UserList) onUserListSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Read Test"),
      ),
      body: StreamBuilder<List<UserList?>>(
        stream: Provider.of<Database>(context, listen: false).userListsStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Stack(
            children: [
              ListItemsBuilder(
                snapshot: snapshot,
                itemBuilder: (context, userList) => Dismissible(
                  key: Key('userList-${userList?.title}'),
                  background: Container(color: Colors.red),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) => (),
                  child: UserListTile(
                    list: userList,
                    onTap: () {
                      // Handle the navigation to a new page with the document data.
                      onUserListSelected(userList!);
                    },
                  ),
                ),
              ),
              Positioned(
                bottom: 56.0,
                right: 16.0,
                child: FloatingActionButton(
                  onPressed: () {
                    // Handle the onTap function for the plus icon (Add more lists).
                    // Add your logic here.
                    print('Add more lists tapped!');
                    UserList testWrite = UserList(title: 'Test Write List 1', id: 'testList_3', category: 'testing');
                    Provider.of<Database>(context, listen: false).setUserList(testWrite);

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



