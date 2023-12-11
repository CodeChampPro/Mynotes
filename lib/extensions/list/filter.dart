extension Filter<T> on Stream<T> {
  Stream<List<T>> filter(bool Function(T) where ) =>
  map((items) => items.!where (where).toList());
}