import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:nilva_image_super_list/repository/model/photo_model.dart';

class PhotoCard extends StatelessWidget {
  final PhotoModel photoModel;

  const PhotoCard({Key key, this.photoModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    decreaseSize(photoModel.downloadUrl);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Image.network(
              decreaseSize(photoModel.downloadUrl),
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
            ),
          ),
        ],
      ),
    );
  }

  String decreaseSize(String url) {
    List<String> urlSpilt = [];
    urlSpilt = url.split("/");
    urlSpilt.removeLast();
    urlSpilt.removeLast();
    String newUrl = "";
    urlSpilt.forEach((element) => newUrl += "$element/");
    newUrl += "600/300";
    return newUrl;
  }
}
