abstract class OrError<V, E> {
  OrError._();

  factory OrError.value(V value) => _Value<V>._(value);
  factory OrError.error(E error) => _Error<E>._(error);

  bool get isError;
  bool get isValue;

  OrError<V, E> ifError(void then(E e)) {
    if (this.isError) {
      then((this as _Error<E>).error);
    }
    return this;
  }

  OrError<V, E> ifValue(void then(V v)) {
    if (this.isValue) {
      then((this as _Value<V>).value);
    }
    return this;
  }
}

class _Value<V> extends OrError<V, Null> {
  _Value._(this.value) : super._();

  final V value;

  @override
  bool get isError => false;

  @override
  bool get isValue => true;
}

class _Error<E> extends OrError<Null, E> {
  _Error._(this.error) : super._();

  final E error;

  @override
  bool get isError => true;

  @override
  bool get isValue => false;
}
