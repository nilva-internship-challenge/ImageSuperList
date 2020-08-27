import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  PhotosList photosList;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getPhotoList(1, 10).then((value) {
            setState(() {
              photosList = value;
            });
          });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: photosList?.photos?.length ?? 0,
        itemBuilder: (_, int index) {
          return PhotoCard(
            photoModel: photosList.photos[index],
          );
        },
      ),
    );
  }
}
