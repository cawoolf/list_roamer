import 'package:flutter/material.dart';
import 'package:list_roamer/app/model/user_list.dart';


class UserListTile extends StatelessWidget {
  const UserListTile({Key? key, required this.list, required this.onTap, required this.onTrailingTap})
      : super(key: key);

  final UserList? list;
  final VoidCallback onTap;
  final VoidCallback onTrailingTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: onTap,
              child: Text(list!.title),
            ),
          ),
        ],
      ),
      trailing: GestureDetector(
        onTap: onTrailingTap,
        behavior: HitTestBehavior.translucent,
        child: const SizedBox(
          width: 75.0, // Adjust the width according to your preference
          child: Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}