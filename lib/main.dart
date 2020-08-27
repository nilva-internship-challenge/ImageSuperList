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
  int page = 1;
  List<PhotoModel> items = [];
  bool isLoading = true;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getPhotoList(page, 10).then((value) {
        setState(() {
          items.addAll(value.photos);
          isLoading = false;
          page++;
        });
      });
    });
    super.initState();
  }

  _loadData() {
    getPhotoList(page, 10).then((value) {
      setState(() {
        items.addAll(value.photos);
        page++;
        print(page);
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: items.isNotEmpty
            ? Column(
                children: <Widget>[
                  Expanded(
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (!isLoading &&
                            scrollInfo.metrics.pixels ==
                                scrollInfo.metrics.maxScrollExtent) {
                          _loadData();
                          setState(() {
                            isLoading = true;
                          });
                        }
                      },
                      child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return PhotoCard(
                            photoModel: items[index],
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    height: isLoading ? 50.0 : 0,
                    color: Colors.transparent,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              )
            : Container(
                alignment: Alignment.center,
                child: Center(
                  child: SizedBox(
                    height: 45,
                    width: 45,
                    child: CircularProgressIndicator(
                      strokeWidth: 3.0,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
