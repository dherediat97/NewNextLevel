import 'package:flutter/material.dart';
import 'package:newnextlevel/api.dart';
import 'model/lol_champion.dart';

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
  List<LolChampion> championList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    return Scaffold(
        appBar: AppBar(
          title: const Text("NextLevel"),
        ),
        body: Row(
          children: <Widget>[
            NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                  if (_selectedIndex == 0) {
                    if (championList.isEmpty) getLolChampions();
                  }
                });
              },
              extended: true,
              destinations: const <NavigationRailDestination>[
                NavigationRailDestination(
                  icon: Icon(Icons.gamepad),
                  selectedIcon: Icon(Icons.gamepad_outlined),
                  label: Text('League of Legends'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.phone_android),
                  selectedIcon: Icon(Icons.phone_android),
                  label: Text('TFT'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.bookmark_border),
                  selectedIcon: Icon(Icons.book),
                  label: Text('Legends of Runeterra'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.star_border),
                  selectedIcon: Icon(Icons.star),
                  label: Text('Valorant'),
                ),
              ],
            ),
            const VerticalDivider(thickness: 0.5, width: 1),
            listOfChampions()
          ],
        ));
  }

  Widget championView(LolChampion data) {
    return Row(children: [Image.network(data.image)]);
  }

  Widget listOfChampions() {
    return Expanded(
        child: Center(
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
          Expanded(
            child: ListView.builder(
                itemCount: championList.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.fromLTRB(32, 0, 0, 32),
                    height: 160,
                    width: 160,
                    child: Card(
                      elevation: 20,
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Stack(children: <Widget>[
                          Align(
                            alignment: Alignment.centerRight,
                            child: Stack(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        championView(championList[index]),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ]),
                      ),
                    ),
                  );
                }),
          ),
        ])));
  }

  void getLolChampions() {
    api
        .getAllLolChampions("11.23.1", "es_ES")
        .then((value) => {championList = value});
  }
}
