import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class LolChampion {
  final String name;
  final String title;
  final String image;
  final Map info;
  final Map tag;
  LolChampion({
    this.name,
    this.title,
    this.image,
    this.info,
    this.tag,
  });
  factory LolChampion.fromJson(Map<String, dynamic> json) {
    return LolChampion(
      name: json['name'],
      title: json['title'],
      image: "http://ddragon.leagueoflegends.com/cdn/11.24.1/img/champion/" +
          json['image']['full'],
      info: json['info'],
      tag: json['tag'],
    );
  }
}
