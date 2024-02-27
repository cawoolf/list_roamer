
class UserList {
  UserList({required this.title, required this.category, required this.id});
  final String title;
  final String category;
  final String id;

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

