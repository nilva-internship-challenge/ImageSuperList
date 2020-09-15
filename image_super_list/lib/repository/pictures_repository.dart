import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_super_list/model/pictures_model.dart';

class PicturesRepository {
  final _url = "https://picsum.photos/v2/list?";

  Future<List<PicturesModel>> fetchPictures(int page, int limit) async {
    final result = await http.get(_url + "page=$page&limit=$limit");
    if (result.statusCode == 200) {
      return parsedJson(result.body);
    } else {
      throw Exception("pictures repository problem!");
    }
  }

  List<PicturesModel> parsedJson(final response) {
    List<PicturesModel> list = new List<PicturesModel>();

    var jsonDecoded = json.decode(response);

    // var jsonMain = jsonDecoded['main'];
    jsonDecoded.forEach((row) => {list.add(PicturesModel.fromJson(row))});
    return list;
  }
}
