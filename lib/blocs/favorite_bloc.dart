import 'dart:async';
import 'dart:convert';
import 'package:rxdart/rxdart.dart';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/video.dart';

class FavoriteBloc extends BlocBase {
  Map<String, Video> _favorites = {};
  final _favKey = 'favorites';

  final _favController = BehaviorSubject<Map<String, Video>>();

  Stream<Map<String, Video>> get outFav => _favController.stream;

  FavoriteBloc() {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getKeys().contains(_favKey)) {
        Map<String, dynamic> videoPrefs =
            Map<String, dynamic>.from(jsonDecode(prefs.getString(_favKey)!));

        videoPrefs.forEach((key, value) {
          _favorites[key] = Video.fromJson(value);
        });

        _favController.add(_favorites);
      }
    });
  }

  void toggleFavorite(Video video) {
    if (_favorites.containsKey(video.id)) {
      _favorites.remove(video.id);
    } else {
      _favorites[video.id] = video;
    }

    _favController.add(_favorites);

    _saveFav();
  }

  @override
  void dispose() {
    _favController.close();
    super.dispose();
  }

  void _saveFav() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString(_favKey, jsonEncode(_favorites));
    });
  }
}
