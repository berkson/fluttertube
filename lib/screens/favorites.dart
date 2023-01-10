import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:fluttertube/blocs/favorite_bloc.dart';
import 'package:fluttertube/models/video.dart';
import 'package:fluttertube/screens/player.dart';
import 'api.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Favorites extends StatelessWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.getBloc<FavoriteBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favoritos"),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder<Map<String, Video>>(
        initialData: const {},
        stream: bloc.outFav,
        builder: (context, snapshot) {
          return ListView(
              children: snapshot.data!.values.map((video) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Player(videoId: video.id),
                ));
              },
              onLongPress: () {
                bloc.toggleFavorite(video);
              },
              child: Row(
                children: [
                  SizedBox(
                    width: 100,
                    height: 50,
                    child: Image.network(video.thumb),
                  ),
                  Expanded(
                      child: Text(
                    video.title,
                    style: const TextStyle(color: Colors.white70),
                    maxLines: 2,
                  ))
                ],
              ),
            );
          }).toList());
        },
      ),
    );
  }
}
