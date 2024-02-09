import 'package:flutter/material.dart';
import 'package:list_roamer/model/user_list_tile.dart';
import 'package:list_roamer/services/database.dart';
import 'package:list_roamer/services/helpers/json_helper.dart';
import 'package:provider/provider.dart';
import '../model/user_list.dart';
import '../services/helpers/list_item_builder.dart';
import '../ui_widgets/create_list_modal.dart';
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
                      // Call to back the navigationPage, which causes the MapPage to load the data from the selected List
                      onUserListSelected(userList!);
                    }, onTrailingTap: () {
                      // Handle the navigation to a new page with the document data.
                    //I need to implement this first before I can load lists from JS
                    editList(context, userList!);
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
                    // writeTestList(context);
                    triggerCreateListModal(context);
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

  void editList(BuildContext context, UserList userList) {

     MarkersViewPage.show(context, userList: userList, database: Provider.of<Database>(context, listen: false));

  }
  void writeTestList(BuildContext context) {
    print('Add more lists tapped!');
    UserList testWrite = UserList(title: 'Test Write List 1',category: 'testing',id: documentIdFromCurrentDate());
    Provider.of<Database>(context, listen: false).setUserList(testWrite);
  }

  void triggerCreateListModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return CreateListModal(
          closeModal: () {
            Navigator.of(context).pop(); // Close the modal when needed
          },
        );
      },
    );
  }
}



