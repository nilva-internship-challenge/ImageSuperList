import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ImageBLoC.dart';
import 'ImageModel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Lazily Loaded List",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Wonderful Images"),
        ),
        body: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<HomePage> {
  ImageBLoC imageBLoC = ImageBLoC();
  ScrollController controller;

  @override
  void initState() {
    super.initState();
    imageBLoC.fetchImages();
    controller = ScrollController()
      ..addListener(() {
        if (controller.position.pixels == controller.position.maxScrollExtent) {
          imageBLoC.fetchImages();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ImageModel>>(
      stream: imageBLoC.imageStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            controller: controller,
            itemCount: snapshot.data.length+1,
            itemBuilder: (context, index) {
              return (index >= snapshot.data.length)
                  ? showProgress()
                  : showImage(snapshot.data[index].download_url);
            },
          );
        } else {
          return showProgress();
        }
      },
    );
  }

  Widget showProgress() {
    return Center(
      child: Container(
        height: 50,
        width: 50,
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget showImage(String url) {
    return Center(child: Container(
      decoration: BoxDecoration(border: Border.all(width: 3)),
      height: 200,
      width: 200,
      padding: EdgeInsets.all(5),
      child: Image.network(
        url,
        fit: BoxFit.fill,
      ),
    ));
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    imageBLoC.dispose();
  }
}

