
import 'package:flutter/src/widgets/gesture_detector.dart';

class UserList {
  UserList(this.title, this.id);
  final String id;
  final String title;

  factory UserList.fromMap(Map<String, dynamic> data, String documentId) {
    String title = data['title'];
    // print(documentId);
    return UserList(title, documentId);
  }


}

