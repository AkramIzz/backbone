part of 'json.dart';

class GenericConverter<T> implements JsonConverter<T, JsonMap> {
  const GenericConverter();

  @override
  T fromJson(JsonMap json) {
    // if (T is Task) { return Task.fromJson(json) as T; }
    throw ClassNotProvidedForGenericConverterError();
  }

  @override
  JsonMap toJson(T object) {
    return object as JsonMap;
  }
}

class ClassNotProvidedForGenericConverterError implements Exception {}