import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class LolChampion {
  LolChampion(this.name, this.title, this.image, this.info, this.tag);
  String name;
  String title;
  String image;
  String info;
  String tag;

  // factory LolChampion.fromJson(Map<String, dynamic> json) =>
  //     _$LolChampionToJson(json);
  // Map<String, dynamic> toJson() => _$LolChampionToJson(this);
}
