
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:video_box_demo/models/video_model.dart';
import 'package:video_box_demo/ults/constants.dart';
import 'dart:convert';

import '../models/news_model.dart';

class APIManager {

  Future<List<News>> getMessages() async {
    final uri = Uri.parse(Constants.messageUrl);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return parseMessages(response.body);
    } else {
      throw Exception(response.body);
    }
  }

  Future<List<Video>> getVideos() async {
    final uri = Uri.parse(Constants.videoUrl);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return parseVideos(response.body);
    } else {
      throw Exception(response.body);
    }
  }

  Future<void> submitMessage(String message) async {
    final body = {"message": message};
    final uri = Uri.parse(Constants.messageUrl);
    final response = await http.post(uri, body: body);

    if (response.statusCode != 201) {
      throw Exception("Failed to submit message");
    }
  }

  List<News> parseMessages(String response) {
    final parsed = jsonDecode(response).cast<Map<String, dynamic>>();
    return parsed.map<News>((json) => News.fromJson(json)).toList();
  }

  List<Video> parseVideos(String response) {
    final parsed = jsonDecode(response).cast<Map<String, dynamic>>();
    return parsed.map<Video>((json) => Video.fromJson(json)).toList();
  }
}
