
abstract class DataState<T> {
  final T? data;
  final String? error;
  const DataState(this.data, this.error);
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data, null);
}

class DataError<T> extends DataState<T> {
  DataError(dynamic error) : super(null, error);
}
