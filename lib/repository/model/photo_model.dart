class PhotosList {
  final List<PhotoModel> photos;

  PhotosList({
    this.photos,
  });

  factory PhotosList.fromJson(List<dynamic> parsedJson) => PhotosList(
      photos: parsedJson.map((i) => PhotoModel.fromJson(i)).toList(),
    );
}

class PhotoModel {
  PhotoModel({
    this.id,
    this.author,
    this.width,
    this.height,
    this.url,
    this.downloadUrl,
  });

  String id;
  String author;
  int width;
  int height;
  String url;
  String downloadUrl;

  factory PhotoModel.fromJson(Map<String, dynamic> json) => PhotoModel(
    id: json["id"],
    author: json["author"],
    width: json["width"],
    height: json["height"],
    url: json["url"],
    downloadUrl: json["download_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "author": author,
    "width": width,
    "height": height,
    "url": url,
    "download_url": downloadUrl,
  };
}
