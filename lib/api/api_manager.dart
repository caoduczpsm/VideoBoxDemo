
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'message_model.dart';

class APIManager {
  static const url =
      "https://648a17fb5fa58521cab0cbe6.mockapi.io/api/v1/demo_mqtt";

  Future<List<Message>> getMessages() async {
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return parseMessages(response.body);
    } else {
      throw Exception("Failed to load Message");
    }
  }

  Future<void> submit(String message) async {
    final body = {"message": message};
    final uri = Uri.parse(url);
    final response = await http.post(uri, body: body);

    if (response.statusCode != 201) {
      throw Exception("Failed to submit message");
    }
  }

  List<Message> parseMessages(String response) {
    final parsed = jsonDecode(response).cast<Map<String, dynamic>>();
    return parsed.map<Message>((json) => Message.fromJson(json)).toList();
  }
}
