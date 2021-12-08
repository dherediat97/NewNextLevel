import 'package:newnextlevel/model/lol_champion.dart';
import 'package:newnextlevel/model/lol_response.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: false)
class LolChampions {
  List<LolChampion> champions = [];

  List<LolChampion> getChampions(LolResponse response) {
    var keysChampions = response.data.keys.toList();
    for (var value in keysChampions) {
      champions.add(response.data[value]);
    }
    return champions.toList();
  }
}
