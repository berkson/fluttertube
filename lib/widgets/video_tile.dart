import 'package:flutter/material.dart';

import '../models/video.dart';

class VideoTile extends StatelessWidget {
  final Video video;

  const VideoTile({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
              aspectRatio: 16.0 / 9.0,
              child: Image.network(
                video.thumb,
                fit: BoxFit.cover,
              )),
          Row(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Text(
                      video.title,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    maxLines: 2,),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Text(
                      video.channel,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  )
                ],
              )),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.star_border),
                color: Colors.white,
                iconSize: 30,
              )
            ],
          )
        ],
      ),
    );
  }
}