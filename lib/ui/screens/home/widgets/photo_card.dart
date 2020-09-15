import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:nilva_image_super_list/repository/model/photo_model.dart';

class PhotoCard extends StatefulWidget {
  final PhotoModel photoModel;

  const PhotoCard({Key key, this.photoModel}) : super(key: key);

  @override
  _PhotoCardState createState() => _PhotoCardState();
}

class _PhotoCardState extends State<PhotoCard> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    decreaseSize(widget.photoModel.downloadUrl);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.3,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                decreaseSize(widget.photoModel.downloadUrl),
                fit: BoxFit.fill,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Opacity(
                  opacity: 0.3,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    color: Colors.black,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        widget.photoModel.author,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            isLiked = !isLiked;
                          });
                        },
                      ),
                      SizedBox(
                        width: 8,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
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
