part of 'json.dart';

class GenericConverter<T> implements JsonConverter<T, Map<String, dynamic>> {
  const GenericConverter();

  @override
  T fromJson(Map<String, dynamic> json) {
    // if (T is Task) { return Task.fromJson(json) as T; }
    throw ClassNotProvidedForGenericConverterError();
  }

  @override
  Map<String, dynamic> toJson(T object) {
    return object as Map<String, dynamic>;
  }
}

class ClassNotProvidedForGenericConverterError implements Exception {}