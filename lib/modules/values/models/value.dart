import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'value.g.dart';

@JsonSerializable()
class Value extends Equatable {
  Value(this.text, this.id, this.favorite);

  factory Value.fromJson(Map<String, dynamic> json) => _$ValueFromJson(json);

  final int id;
  final String text;
  bool favorite;

  Map<String, dynamic> toJson() => _$ValueToJson(this);

  @override
  List<Object> get props => [id, text, favorite];
}
