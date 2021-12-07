import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class LolResponse {
  final Map<dynamic, dynamic> data;
  const LolResponse({this.data});

  factory LolResponse.fromJson(Map<String, dynamic> body) {
    return LolResponse(data: body["data"]);
  }
}
