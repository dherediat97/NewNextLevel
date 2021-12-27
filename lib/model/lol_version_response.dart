import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class LolVersionResponse {
  final String v;
  const LolVersionResponse({this.v});

  factory LolVersionResponse.fromJson(Map<String, dynamic> json) {
    return LolVersionResponse(v: json['v']);
  }
}
