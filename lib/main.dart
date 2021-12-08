import 'package:flutter/material.dart';
import 'api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Next Level',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var api = Api();
  List<dynamic> championList = [];

  @override
  void initState() {
    super.initState();
    // api
    //     .getAllLolChampions("11.23.1", "es_ES")
    //     .then((value) => {championList = value});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("NextLevel"),
        ),
        body: Container()
        // body: (!championList.isNotEmpty)
        //     ? Column(
        //         mainAxisSize: MainAxisSize.max,
        //         mainAxisAlignment: MainAxisAlignment.start,
        //         children: <Widget>[
        //             Expanded(
        //                 child: ListView.builder(
        //                     scrollDirection: Axis.horizontal,
        //                     itemCount: 50,
        //                     itemBuilder: (context, index) {
        //                       print(championList[index].name);
        //                       return Column(
        //                         children: [Text(championList[index].name)],
        //                       );
        //                     })),
        //           ])
        //     : Container()
        );
  }
}
