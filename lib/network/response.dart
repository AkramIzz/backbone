import 'package:json_annotation/json_annotation.dart';
import 'package:backbone/json/json.dart';

part 'response.g.dart';

@JsonSerializable()
class BasicResponse {
  BasicResponse(this.status, this.message);

  int status;
  String message;

  factory BasicResponse.fromJson(JsonMap json) => _$BasicResponseFromJson(json);
  JsonMap toJson() => _$BasicResponseToJson(this);
}

@JsonSerializable()
class DataResponse<T> extends BasicResponse {
  @GenericConverter()
  T dto;

  DataResponse(int status, String message, this.dto) : super(status, message);
  
  factory DataResponse.fromJson(JsonMap json) => _$DataResponseFromJson(json);
  JsonMap toJson() => _$DataResponseToJson(this);
}

class ResponseStatus {
  static const int SUCCESS = 200;
}