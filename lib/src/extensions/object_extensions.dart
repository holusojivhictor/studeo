extension ObjectExtensions<T> on T {
  /// Transforms this, through the [Function] [f], to [E].
  E let<E>(E Function(T t) f) => f(this);

  /// Whether this is `null`.
  bool get isNull => this == null;

  /// Whether this is not `null`.
  bool get isNotNull => this != null;
}
