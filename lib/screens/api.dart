import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/video.dart';

class Api {
  static const apiKey = "AIzaSyDyXaGidclgs6Oly6HbZjAm5WFS5nAAGJo";
  String? _search;
  String _nextToken = '';

  Future<List<Video>> search(String? search) async {
    _search = search;
    http.Response response = await http.get(Uri.parse(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$apiKey&maxResults=10"));
    return decode(response);
  }

  Future<List<Video>> nextPage() async {
    http.Response response = await http.get(Uri.parse(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$apiKey&maxResults=10&pageToken=$_nextToken"));

    return decode(response);
  }

  List<Video> decode(http.Response response) {
    if (response.statusCode == 200) {
      var decoded = jsonDecode(response.body);

      _nextToken = decoded["nextPageToken"];

      return decoded['items'].map<Video>((value) {
        return Video.fromJson(value);
      }).toList();
    } else {
      throw Exception('Failed to load videos');
    }
  }
}
