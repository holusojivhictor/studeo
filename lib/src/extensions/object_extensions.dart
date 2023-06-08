extension ObjectExtensions<T> on T {
  /// Transforms this, through the [Function] [f], to [E].
  E let<E>(E Function(T t) f) => f(this);
}
