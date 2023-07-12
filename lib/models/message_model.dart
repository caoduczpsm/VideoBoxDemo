class Message {
  final String? id;
  final String? message;
  final String? description;
  final String? imageUrl;

  Message({this.id, this.message, this.description, this.imageUrl});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        id: json['id'],
        message: json['message'],
        description: json['description'],
        imageUrl: json['imageUrl']);
  }
}
