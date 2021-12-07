import 'package:newnextlevel/model/lol_champion.dart';
import 'package:newnextlevel/model/lol_response.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  List<LolChampion> champions = [];
  Future<List<LolChampion>> getAllLolChampions(
      var version, var language) async {
    final response = await http.get(Uri.dataFromString(
        "http://ddragon.leagueoflegends.com/cdn/" +
            version +
            "/data/" +
            language +
            "/champion.json"));
    if (response.statusCode == 200) {
      var responseBody = LolResponse.fromJson(json.decode(response.body));
      var champions = getChampions(responseBody);
      return champions;
    } else {
      throw Exception('Failed to load post');
    }
  }

  List<LolChampion> getChampions(LolResponse response) {
    var keysChampions = response.data.keys.toList();
    for (var value in keysChampions) {
      LolChampion champion = LolChampion.fromJson(response.data);
      champions.add(champion);
    }
    return champions;
  }
}
