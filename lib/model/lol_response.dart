import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class LolResponse {
  final Map<dynamic, dynamic> data;
  final String format;
  final String type;
  final String version;
  const LolResponse({this.data, this.format, this.type, this.version});

  factory LolResponse.fromJson(Map<String, dynamic> json) {
    return LolResponse(
      data: json['data'],
      format: json['format'],
      type: json['type'],
      version: json['version'],
    );
  }
}
