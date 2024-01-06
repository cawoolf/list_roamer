
import 'package:flutter/src/widgets/gesture_detector.dart';

class UserList {
  UserList({required this.title, required this.id, required this.category});
  final String id;
  final String title;
  final String category;

  factory UserList.fromMap(Map<String, dynamic> data, String documentId) {
    String title = data['title'];
    String category = data['category'];
    // print(documentId);
    return UserList(title: title, id: documentId, category: category);
  }

  Map<String, dynamic> toMap() {
    return {'title': title, 'category': category};
  }


}

