// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Value _$ValueFromJson(Map<String, dynamic> json) {
  return Value(
    json['text'] as String,
    json['id'] as int,
    json['favorite'] as bool,
  );
}

Map<String, dynamic> _$ValueToJson(Value instance) => <String, dynamic>{
      'id': instance.id,
      'favorite': instance.favorite,
      'text': instance.text,
    };
