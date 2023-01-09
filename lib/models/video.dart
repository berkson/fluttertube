class Video {
  final String id;
  final String title;
  final String thumb;
  final String channel;

  Video(this.id, this.title, this.thumb, this.channel);

  factory Video.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("id")) {
      return Video(
          json['id']['videoId'],
          json['snippet']['title'],
          json['snippet']['thumbnails']['high']['url'],
          json['snippet']['channelTitle']);
    } else {
      return Video(
          json['videoId'], json['title'], json['thumb'], json['channel']);
    }
  }

  Map<String, dynamic> toJson() {
    return {"videoId": id, "title": title, "thumb": thumb, "channel": channel};
  }
}
