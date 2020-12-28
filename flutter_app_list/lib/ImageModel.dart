class ImageModel {
  String id;
  String author;
  int width;
  int height;
  String url;
  String download_url;

  ImageModel(
      {this.id,
        this.author,
        this.width,
        this.height,
        this.url,
        this.download_url});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'],
      author: json['author'],
      width: json['width'],
      height: json['height'],
      url: json['url'],
      download_url: json['download_url'],
    );
  }
}

