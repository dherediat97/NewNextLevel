import 'package:json_annotation/json_annotation.dart';
import 'package:newnextlevel/util/constants.dart';

@JsonSerializable()
class LolChampion {
  final int version;
  final String name;
  final String title;
  final String image;
  final Map info;
  final Map tag;
  LolChampion({
    this.version,
    this.name,
    this.title,
    this.image,
    this.info,
    this.tag,
  });
  factory LolChampion.fromJson(String version, Map<String, dynamic> json) {
    return LolChampion(
      name: json['name'],
      title: json['title'],
      image: cdnDdragon + version + "/img/champion/" + json['image']['full'],
      info: json['info'],
      tag: json['tag'],
    );
  }
}
