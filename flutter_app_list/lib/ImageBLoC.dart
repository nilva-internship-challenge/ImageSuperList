import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'ImageModel.dart';

class ImageBLoC {
  List<ImageModel> showedImages = List();
  Set randomNumbers = Set();  //create a set to prevent adding duplicate random numbers
  final StreamController<List<ImageModel>> _imageController =
  StreamController<List<ImageModel>>();
  Stream<List<ImageModel>> get imageStream => _imageController.stream;

  void fetchImages() async {
    randomNumbers.add(Random().nextInt(100)+1);
    List<ImageModel> packOfNewImages = await fetchNewPack(randomNumbers.last);
    showedImages.addAll(packOfNewImages);
    _imageController.sink.add(showedImages);
  }

  Future<List<ImageModel>> fetchNewPack(int page) async {
    final result = await http
        .get("https://picsum.photos/v2/list?" + "page=$page&limit=10");
    if (result.statusCode == 200) {
      return parsedJson(result.body);
    } else {
      throw Exception("Oh, a problem happened!");
    }
  }

  List<ImageModel> parsedJson(final response) {
    List<ImageModel> list = new List<ImageModel>();
    var jsonDecoded = json.decode(response);
    jsonDecoded.forEach((row) => {list.add(ImageModel.fromJson(row))});
    return list;
  }

  void dispose() {
    _imageController.close();
    showedImages.clear();
  }
}
