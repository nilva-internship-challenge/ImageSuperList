import 'package:flutter/material.dart';
import 'package:image_super_list/bloc/pictures_bloc.dart';
import 'package:image_super_list/model/pictures_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
  final _bloc = PicturesBloc();
  ScrollController _controller = new ScrollController();
  bool progress = true; //CircularIndicator progress visibility

  @override
  void initState() {
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        print('end');
        progress = false;
        _bloc.addItemsToPictures();

        if (_controller.position.pixels == 0.0) {
          print('first');
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        controller: _controller,
        child: Column(
          children: [
            StreamBuilder<List<PicturesModel>>(
                stream: _bloc.streamPictures,
                initialData: List<PicturesModel>.empty(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Container(
                              child: Column(
                                children: [
                                  Image.network(
                                    "${snapshot.data[index].getDounload_url}",
                                    width: 200,
                                    height: 300,
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  } else {
                    return Container();
                  }
                }),
            progress == true ? CircularProgressIndicator() : Container(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
