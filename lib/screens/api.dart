import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/video.dart';


class Api {
  static const apiKey = "AIzaSyDyXaGidclgs6Oly6HbZjAm5WFS5nAAGJo";

  void search(String search) async {
    http.Response response = await http.get(Uri.parse(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$apiKey&maxResults=10"));
    decode(response);
  }

  List<Video> decode(http.Response response) {
    if (response.statusCode == 200) {
      var decoded = jsonDecode(response.body);
      return decoded['items'].map<Video>((value) {
        return Video.fromJson(value);
      }).toList();
    } else {
      throw Exception('Failed to load videos');
    }
  }
}
