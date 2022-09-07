import 'package:flutter/material.dart';
import 'package:newnextlevel/api.dart';
import 'model/lol_champion.dart';

void main() {
  runApp(const NextLevelApp());
}

class NextLevelApp extends StatelessWidget {
  const NextLevelApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Next Level',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            colorScheme:
                ColorScheme.fromSwatch(primarySwatch: Colors.deepOrange)),
        home: MainPage());
  }
}

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class MainPage extends StatefulWidget {
  final _drawerItems = [
    DrawerItem("Pagina Principal", Icons.house),
    DrawerItem("Campeones", Icons.chalet),
    DrawerItem("Ajustes", Icons.settings_outlined)
  ];

  MainPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DrawerActivityState();
  }
}

class DrawerActivityState extends State<MainPage> {
  int _selectedIndex = 0;

  String picsUrl =
      "https://www.animationmagazine.net/wordpress/wp-content/uploads/wheres-waldo-post-510x451.jpg";

  var api = Api();
  List<LolChampion> championList = [];

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 1:
        getLolChampions();
        return listOfChampionsLol();
      default:
        return const Text("Otra Pagina");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedIndex = index);
    Navigator.of(context).pop();
  }

  var isDarkMode = true;
  @override
  Widget build(BuildContext context) {
    List<Widget> drawerOpts = [];
    for (var i = 0; i < widget._drawerItems.length; i++) {
      var d = widget._drawerItems[i];
      drawerOpts.add(ListTile(
          leading: Icon(d.icon),
          title: Text(d.title),
          selected: i == _selectedIndex,
          onTap: () => _onSelectItem(i)));
    }

    return Scaffold(
        appBar: AppBar(
            title: Text(widget._drawerItems[_selectedIndex].title),
            backgroundColor: Colors.deepOrange,
            foregroundColor: Colors.white),
        drawer: Drawer(
            child: Column(children: <Widget>[
          UserAccountsDrawerHeader(
              accountEmail: const Text("dherediat@nextlevel.com",
                  style: TextStyle(fontSize: 18)),
              accountName: const Text("David", style: TextStyle(fontSize: 16)),
              currentAccountPicture: GestureDetector(
                  child: CircleAvatar(backgroundImage: NetworkImage(picsUrl)),
                  onTap: () => print(""))),
          Column(children: drawerOpts)
        ])),
        body: _getDrawerItemWidget(_selectedIndex));
  }

  Widget listOfChampionsLol() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 1,
            crossAxisSpacing: 50,
            mainAxisSpacing: 50),
        itemCount: championList.length,
        itemBuilder: (BuildContext ctx, index) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 70,
            child: Card(
                color: Colors.white,
                elevation: 16,
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: NetworkImage(championList[index].image),
                            fit: BoxFit.fitWidth)),
                    child: Center(
                        child: Text(championList[index].name,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white))))),
          );
        });
  }

  getLolChampions() {
    api.getAllLolChampions("es_ES").then((value) => {championList = value});
  }
}
