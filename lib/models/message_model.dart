
import 'payload.dart';

class Message {
  final String? id;
  final String? topic;
  final Payload? payload;

  Message({this.id, this.topic, this.payload});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        id: json['id'],
        topic: json['topic'],
        payload: Payload.fromJson(json['payload']));
  }
}
