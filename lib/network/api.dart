import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api.g.dart';

@RestApi(baseUrl: '')
abstract class Api {
  factory Api(Dio dio) = _Api;

  // @GET('/posts')
  // Future<DataResponse<Task>> getTasks(@Body() Task task);
}

class MockedApi implements Api {
  
}