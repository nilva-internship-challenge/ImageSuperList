import 'dart:async';
import 'package:nilva_image_super_list/repository/model/photo_model.dart';
import 'package:nilva_image_super_list/repository/remote/http.dart';

class PhotoBloc {
  final _photos = <PhotoModel>[];

  final StreamController<List<PhotoModel>> _photosController =
  StreamController<List<PhotoModel>>();

  Stream<List<PhotoModel>> get photosStream => _photosController.stream;

  void fetchPhotos(int page) async {
    final response = await getPhotoList(page, 10);
    _photos.addAll(response.photos);
    _photosController.sink.add(_photos);
  }

  void dispose() {
    _photosController.close();
    _photos.clear();
  }
}
