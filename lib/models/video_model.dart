class Video {
  final String? id;
  final String? url;

  Video({this.id, this.url});

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
        id: json['id'],
        url: json['url']);
  }
}
