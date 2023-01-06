import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';

import '../models/video.dart';
import '../screens/api.dart';

class VideosBloc extends BlocBase {
  late Api api;
  late List<Video> videos;

  //getter para ter acesso a saída do stream do bloc de vídeos
  Stream get outVideos => _videosController.stream;
  final StreamController _videosController = StreamController<List<Video>>();

  //getter para ter acesso a entrada do stream do bloc para consulta
  Sink get inSearch => _searchController.sink;
  final StreamController _searchController = StreamController<String>();

  VideosBloc() {
    api = Api();
    _searchController.stream.listen((event) {
      _search(event);
    });
  }

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
    super.dispose();
  }

  void _search(String search) async {
    videos = await api.search(search);
    _videosController.sink.add(videos);
  }
}
