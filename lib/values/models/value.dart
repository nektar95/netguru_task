import 'package:json_annotation/json_annotation.dart';

part 'value.g.dart';

@JsonSerializable(nullable: false)
class Value {
  Value(this.text, this.id, this.favorite);

  factory Value.fromJson(Map<String, dynamic> json) => _$ValueFromJson(json);

  int id;
  bool favorite;
  String text;

  Map<String, dynamic> toJson() => _$ValueToJson(this);
}
