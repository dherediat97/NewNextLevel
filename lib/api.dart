import 'dart:convert';
import 'package:newnextlevel/model/lol_champion.dart';
import 'package:newnextlevel/model/lol_response.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:newnextlevel/model/lol_version_response.dart';
import 'package:newnextlevel/util/constants.dart';

class Api {
  List<LolChampion> champions = [];

  Future<String> whichVersionHave(String region) async {
    final response =
        await http.get(baseUrlDDragon + "realms/" + region + ".json");
    if (response.statusCode == 200) {
      var data = LolVersionResponse.fromJson(jsonDecode(response.body));
      return data.v;
    } else {
      throw Exception("Error");
    }
  }

  Future<List<LolChampion>> getAllLolChampions(String language) async {
    var version = await whichVersionHave("euw");
    final response = await http
        .get(cdnDdragon + version + "/data/" + language + "/champion.json");
    if (response.statusCode == 200) {
      var data = LolResponse.fromJson(jsonDecode(response.body));
      var champions = getChampions(data);
      return champions;
    } else {
      throw Exception("Error");
    }
  }

  List<LolChampion> getChampions(LolResponse response) {
    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    var keysChampions = response.data.keys.toList();
    for (var value in keysChampions) {
      String data = encoder.convert(response.data[value]);
      var champion = LolChampion.fromJson(response.version, jsonDecode(data));
      champions.add(champion);
    }
    return champions;
  }
}
