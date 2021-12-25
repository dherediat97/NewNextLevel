import 'package:flutter/material.dart';
import 'package:newnextlevel/api.dart';
import 'package:newnextlevel/util/extensions.dart';
import 'model/lol_champion.dart';

void main() {
  runApp(const NextLevelApp());
}

class NextLevelApp extends StatelessWidget {
  const NextLevelApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return mainContent();
  }

  Widget mainContent() {
    return MaterialApp(
      title: 'Next Level',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var api = Api();
  List<LolChampion> championList = [];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Next Level"), actions: <Widget>[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.search),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: PopupMenuButton(
              tooltip: "Cambiar Región",
              icon: const Icon(Icons.more_vert),
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                const PopupMenuItem(
                  child: ListTile(
                    leading: Icon(Icons.language),
                    title: Text('Cambiar Región'),
                  ),
                ),
              ],
            ),
          ),
        ]),
        body: Row(
          children: <Widget>[
            NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
                if (_selectedIndex == 0) {
                  if (championList.isEmpty) {
                    getLolChampions();
                  }
                } else if (_selectedIndex == 1) {
                } else if (_selectedIndex == 2) {
                } else if (_selectedIndex == 3) {}
              },
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
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(
              child: Center(
                child: listOfChampions(_selectedIndex),
              ),
            )
          ],
        ));
  }

  Widget championView(LolChampion champion) {
    return Row(children: [
      Image.network(champion.image),
      Text(champion.name + " - " + champion.title.capitalize())
    ]);
  }

  Widget listOfChampions(int gameSelected) {
    if (gameSelected == 0) {
      return Column(
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
          ]);
    } else {
      return Text("Juego Seleccionado $gameSelected");
    }
  }

  getLolChampions() {
    api.getAllLolChampions("es_ES").then((value) => {championList = value});
  }
}
