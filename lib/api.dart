import 'dart:convert';
import 'package:newnextlevel/model/lol_champion.dart';
import 'package:newnextlevel/model/lol_response.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class Api {
  List<LolChampion> champions = [];
  String baseUrlDDragon = "http://ddragon.leagueoflegends.com/cdn/";

  Future<List<LolChampion>> getAllLolChampions(
      var version, var language) async {
    final response = await http
        .get(baseUrlDDragon + version + "/data/" + language + "/champion.json");
    if (response.statusCode == 200) {
      var data = LolResponse.fromJson(jsonDecode(response.body));
      var champions = getChampions(data);
      return champions;
    } else {
      throw Exception('Failed to load post');
    }
  }

  List<LolChampion> getChampions(LolResponse response) {
    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    var keysChampions = response.data.keys.toList();
    for (var value in keysChampions) {
      String str = encoder.convert(response.data[value]);
      var champion = LolChampion.fromJson(jsonDecode(str));
      champions.add(champion);
    }
    return champions;
  }
}
