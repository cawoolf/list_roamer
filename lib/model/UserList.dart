
class UserList {
  UserList(this.title);
  final String title;

  factory UserList.fromMap(Map<String, dynamic> data) {
    String title = data['title'];
    return UserList(title);
  }
}

