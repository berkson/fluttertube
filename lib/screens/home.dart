import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:fluttertube/blocs/favorite_bloc.dart';
import 'package:fluttertube/blocs/videos_bloc.dart';
import 'package:fluttertube/delegates/data_search.dart';
import 'package:fluttertube/screens/favorites.dart';
import '../models/video.dart';

import '../widgets/video_tile.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.getBloc<FavoriteBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          height: 60,
          width: MediaQuery.of(context).size.width / 2,
          child: Image.asset('images/you-ico.png', fit: BoxFit.cover),
        ),
        elevation: 0,
        backgroundColor: Colors.black87,
        actions: [
          Align(
            alignment: Alignment.center,
            child: StreamBuilder<Map<String, Video>>(
                initialData: const {},
                stream: bloc.outFav,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text("${snapshot.data!.length}");
                  }
                  return Container();
                }),
          ),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Favorites()));
              },
              icon: const Icon(Icons.star)),
          IconButton(
              onPressed: () async {
                String? result =
                    await showSearch(context: context, delegate: DataSearch());
                if (result!.isNotEmpty) {
                  BlocProvider.getBloc<VideosBloc>().inSearch.add(result);
                }
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: StreamBuilder(
        initialData: const [],
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? Container()
              : ListView.builder(
                  itemBuilder: (context, index) {
                    // se ele for para o último vídeo passa null e pega a próxima página
                    if (index < snapshot.data!.length) {
                      return VideoTile(video: snapshot.data![index]);
                    } else if (index > 1) {
                      BlocProvider.getBloc<VideosBloc>().inSearch.add(null);
                      return Container(
                        height: 40,
                        width: 40,
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.red)),
                      );
                    } else {
                      return Container();
                    }
                  },
                  itemCount: snapshot.data.length + 1,
                );
        },
        stream: BlocProvider.getBloc<VideosBloc>().outVideos,
      ),
      backgroundColor: Colors.black87,
    );
  }
}
