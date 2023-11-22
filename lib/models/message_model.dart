/// id: 101,
//   title: 'foo',
//   body: 'bar',
//   userId: 1

class MessageModel {
  int? id;
  String title;
  String body;
  int userId;

  MessageModel({
    required this.body,
    required this.title,
    required this.userId,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'userId': userId,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'] as int,
      title: map['title'] as String,
      body: map['body'] as String,
      userId: map['userId'] as int,
    );
  }
}
