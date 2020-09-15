class PicturesModel {
  String id;
  String author;
  String width;
  String height;
  String url;
  String download_url;

  String get getId => id;
  String get getAuthor => author;
  String get getWidth => width;
  String get getHeight => height;
  String get getUrl => url;
  String get getDounload_url => "https://picsum.photos/id/$id/200/300";

  PicturesModel(this.id, this.author, this.width, this.height, this.url,
      this.download_url);

  PicturesModel.empty() {
    this.download_url = "";
  }
  factory PicturesModel.fromJson(Map<String, dynamic> parsedJson) {
    return PicturesModel(
        parsedJson['id'],
        parsedJson['author'],
        parsedJson['width'].toString(),
        parsedJson['height'].toString(),
        parsedJson['url'],
        parsedJson['download_url']);
  }
}
