import 'dart:async';
import 'dart:math';

import 'package:image_super_list/model/pictures_model.dart';
import 'package:image_super_list/repository/pictures_repository.dart';

class PicturesBloc {
  PicturesRepository _repository = new PicturesRepository();
  int randomNumber = Random().nextInt(99) + 1;

  List<PicturesModel> _picturesModel;
  StreamController<List<PicturesModel>> _picturesController =
      StreamController<List<PicturesModel>>.broadcast();
  Sink<List<PicturesModel>> get _sinkPictures => _picturesController.sink;
  Stream<List<PicturesModel>> get streamPictures => _picturesController.stream;

  StreamController<List<PicturesModel>> _updatePicturesController =
      StreamController();
  Sink<List<PicturesModel>> get updatePictures =>
      _updatePicturesController.sink;

  StreamController<List<String>> _updateDownload_urlController =
      StreamController();
  Sink<List<String>> get updateDownload_url =>
      _updateDownload_urlController.sink;

  PicturesBloc() {
    fetchPictures(randomNumber);
    _updatePicturesController.stream.listen(_updatePictures);
  }

  fetchPictures(int page) async {
    List<PicturesModel> list = await _repository.fetchPictures(page, 10);
    print("PictureBloc: listData : ${list[0].getDounload_url}");

    _picturesModel = list;
    _sinkPictures.add(_picturesModel);
  }

  dispose() {
    _picturesController.close();
    _updatePicturesController.close();
    _updateDownload_urlController.close();
  }

  void _updatePictures(List<PicturesModel> model) {
    _picturesModel = model;
    _sinkPictures.add(_picturesModel);
  }

  void addItemsToPictures() async {
    int page = Random().nextInt(99) + 1; 
    List<PicturesModel> list = await _repository.fetchPictures(page, 10);
    print("PictureBloc: addItemsTolistData : ${list[0].getDounload_url}");

    _picturesModel = _picturesModel + list;
    _sinkPictures.add(_picturesModel);
  }
}
