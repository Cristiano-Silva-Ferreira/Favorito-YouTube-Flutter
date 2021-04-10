class Video {
  final String id;
  final String title;
  final String thumb;
  final String channel;

  Video({
    this.id,
    this.title,
    this.thumb,
    this.channel,
  });

  // Pegando o JSon e transformando e um objeto que contem os dados do JSon
  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json["id"]["videoId"],
      title: json["snippet"]["title"],
      thumb: json["snippet"]["thumbnails"]["high"]["url"],
      channel: json["snippet"]["channelTitle"],
    );
  }
}
