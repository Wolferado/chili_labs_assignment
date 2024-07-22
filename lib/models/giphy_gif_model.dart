class GiphyGif {
  final String url;
  final String title;
  final String username;
  final String createdDate;
  final String downsizedVideoUrl;
  final String originalVideoUrl;

  GiphyGif(this.url, this.title, this.username, this.createdDate,
      this.downsizedVideoUrl, this.originalVideoUrl);

  factory GiphyGif.fromJson(dynamic json) {
    return GiphyGif(
        json["url"] == "" ? "Unknown" : json["url"],
        json["title"] == "" ? "No Title" : json["title"],
        json["username"] == "" ? "No Author" : json["username"],
        json["import_datetime"] == "" ? "Unknown" : json["import_datetime"],
        json["images"]["downsized"]["url"] ?? "Unknown",
        json["images"]["original"]["url"] ?? "Unknown");
  }
}
