import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Player extends StatefulWidget {
  const Player({Key? key, required this.videoId}) : super(key: key);

  final String videoId;

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  @override
  Widget build(BuildContext context) {
    YoutubePlayerController controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    return YoutubePlayer(
      controller: controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.blue,
      progressColors: const ProgressBarColors(
        playedColor: Colors.blueAccent,
        handleColor: Colors.blue,
      ),
    );
  }
}
