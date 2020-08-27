import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nilva_image_super_list/repository/model/photo_model.dart';
import 'package:nilva_image_super_list/repository/remote/http.dart';
import 'package:nilva_image_super_list/ui/photo_card.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController scrollController = ScrollController();
  final photoBloc = PhotoBloc();
  int page = 1;

  @override
  void initState() {
    super.initState();
    photoBloc.fetchPhotos(page);
    page++;
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        photoBloc.fetchPhotos(page);
        page++;
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    photoBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<List<PhotoModel>>(
          stream: photoBloc.photosStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                controller: scrollController,
                itemCount: snapshot.data.length + 1,
                itemBuilder: (context, index) {
                  return index >= snapshot.data.length
                      ? Loader(25, 25) // the reason why snapshot.data.length + 1
                      : PhotoCard(
                          photoModel: snapshot.data[index],
                        );
                },
              );
            } else {
              return Loader(45, 45);
            }
          }),
    );
  }
}

class Loader extends StatelessWidget {
  final double width;
  final double height;

  Loader(this.width, this.height);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: width,
          height: height,
          child: CircularProgressIndicator(
            strokeWidth: 3.0,
          ),
        ),
      ),
    );
  }
}

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
