// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasicResponse _$BasicResponseFromJson(Map<String, dynamic> json) {
  return $checkedNew('BasicResponse', json, () {
    final val = BasicResponse(
      $checkedConvert(json, 'status', (v) => v as int),
      $checkedConvert(json, 'message', (v) => v as String),
    );
    return val;
  });
}

Map<String, dynamic> _$BasicResponseToJson(BasicResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };

DataResponse<T> _$DataResponseFromJson<T>(Map<String, dynamic> json) {
  return $checkedNew('DataResponse', json, () {
    final val = DataResponse<T>(
      $checkedConvert(json, 'status', (v) => v as int),
      $checkedConvert(json, 'message', (v) => v as String),
      $checkedConvert(
          json, 'dto', (v) => GenericConverter<T>().fromJson(v as Map<String, dynamic>)),
    );
    return val;
  });
}

Map<String, dynamic> _$DataResponseToJson<T>(DataResponse<T> instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'dto': GenericConverter<T>().toJson(instance.dto),
    };
