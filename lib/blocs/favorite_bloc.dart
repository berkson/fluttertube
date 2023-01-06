import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';

import '../models/video.dart';

class FavoriteBloc extends BlocBase {
  Map<String, Video> _favorites = {};

  final _favController = StreamController<Map<String, Video>>();
  Stream<Map<String, Video>> get outFav => _favController.stream;

  void toggleFavorite(Video video){
    if(_favorites.containsKey(video.id)) {
      _favorites.remove(video.id);
    } else {
      _favorites[video.id] = video;
    }

    _favController.add(_favorites);
  }

  @override
  void dispose() {
    _favController.close();
    super.dispose();
  }
}
