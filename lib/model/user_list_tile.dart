import 'package:flutter/material.dart';
import 'package:list_roamer/model/user_list.dart';

class UserListTile extends StatelessWidget {
  const UserListTile({super.key, required this.list, required this.onTap});
  final UserList? list;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(list!.title),
      onTap: onTap,
      trailing: const Icon(Icons.chevron_right),
    );
  }
}