class News {
  final String? id;
  final String? message;
  final String? description;
  final String? imageUrl;

  News({this.id, this.message, this.description, this.imageUrl});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
        id: json['id'],
        message: json['message'],
        description: json['description'],
        imageUrl: json['imageUrl']);
  }
}
