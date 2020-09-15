import 'package:flutter/material.dart';
import 'package:nilva_image_super_list/repository/bloc/photo_bloc.dart';
import 'package:nilva_image_super_list/repository/model/photo_model.dart';
import 'package:nilva_image_super_list/ui/screens/home/widgets/loader.dart';
import 'package:nilva_image_super_list/ui/screens/home/widgets/photo_card.dart';

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
        },
      ),
    );
  }
}
