import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:fluttertube/blocs/videos_bloc.dart';
import 'package:fluttertube/delegates/data_search.dart';

import '../widgets/video_tile.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            const Align(
              alignment: Alignment.center,
              child: Text('0'),
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.star)),
            IconButton(
                onPressed: () async {
                  String? result = await showSearch(
                      context: context, delegate: DataSearch());
                  if (result!.isNotEmpty) {
                    BlocProvider.getBloc<VideosBloc>().inSearch.add(result);
                  }
                },
                icon: const Icon(Icons.search))
          ],
        ),
        body: StreamBuilder(
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? Container()
                : ListView.builder(
                    itemBuilder: (context, index) {
                      return VideoTile(video: snapshot.data[index]);
                    },
                    itemCount: snapshot.data.length,
                  );
          },
          stream: BlocProvider.getBloc<VideosBloc>().outVideos,
        ), backgroundColor: Colors.black87,);
  }
}
