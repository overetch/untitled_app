typedef FactoryFunc<T> = T Function(Resolver);
typedef AsyncFactoryFunc<T> = Future<T> Function(Resolver);

abstract class Resolver {
  T get<T>({Object? key});
  Future<T> getAsync<T>({Object? key});
}

class DIContainer implements Resolver {
  factory DIContainer() {
    return _instance;
  }
  DIContainer._internal();
  static final DIContainer _instance = DIContainer._internal();

  final Map<_Key, _Provider> _providers = {};
  final Map<_Key, Object> _singletons = {};
  final Map<_Key, Future<Object>> _asyncInits = {};

  void registerFactory<T>({
    required FactoryFunc<T> create,
    Object? key,
  }) {
    final k = _Key(T, key);
    _providers[k] = _FactoryProvider<T>(create);
  }

  void registerSingleton<T>({
    required T instance,
    Object? key,
  }) {
    final k = _Key(T, key);
    _providers[k] = _SingletonProvider<T>(instance);
    _singletons[k] = instance as Object;
  }

  void registerLazySingleton<T>({
    required FactoryFunc<T> create,
    Object? key,
  }) {
    final k = _Key(T, key);
    _providers[k] = _LazySingletonProvider<T>(create);
  }

  void registerAsyncSingleton<T>({
    required AsyncFactoryFunc<T> create,
    Object? key,
    bool lazy = true,
  }) {
    final k = _Key(T, key);
    final provider = _AsyncSingletonProvider<T>(create);
    _providers[k] = provider;

    if (!lazy) {
      _asyncInits[k] = provider.create(this).then((v) => v as Object);
      _singletons[k] = _AsyncPlaceholder();
    }
  }

  @override
  T get<T>({Object? key}) {
    final k = _Key(T, key);
    final provider = _providers[k];
    if (provider == null) {
      throw StateError('No provider found for $T with key=$key');
    }

    final cached = _singletons[k];
    if (cached != null && cached is! _AsyncPlaceholder) {
      return cached as T;
    }

    if (cached is _AsyncPlaceholder || _asyncInits.containsKey(k)) {
      throw StateError(
        'Async singleton for $T with key=$key is initializing; use getAsync<T>().',
      );
    }

    final value = provider.get(this);
    if (provider is _SingletonProvider<T> || provider is _LazySingletonProvider<T>) {
      _singletons[k] = value as Object;
    }
    return value as T;
  }

  @override
  Future<T> getAsync<T>({Object? key}) async {
    final k = _Key(T, key);
    final provider = _providers[k];
    if (provider == null) {
      throw StateError('No provider found for $T with key=$key');
    }

    final cached = _singletons[k];
    if (cached != null && cached is! _AsyncPlaceholder) {
      return cached as T;
    }

    if (provider is _AsyncSingletonProvider<T>) {
      final pending = _asyncInits[k];
      if (pending != null) {
        final v = await pending;
        _singletons[k] = v;
        return v as T;
      }
      final future = provider.create(this).then((v) => v as Object);
      _asyncInits[k] = future;
      _singletons[k] = _AsyncPlaceholder();
      final value = await future;
      _singletons[k] = value;
      _asyncInits.remove(k);
      return value as T;
    }

    return get<T>(key: key);
  }

  void reset() {
    _providers.clear();
    _singletons.clear();
    _asyncInits.clear();
  }

  bool unregister<T>({Object? key}) {
    final k = _Key(T, key);
    final removedP = _providers.remove(k) != null;
    final removedS = _singletons.remove(k) != null;
    _asyncInits.remove(k);
    return removedP || removedS;
  }

  static T of<T>({Object? key}) => _instance.get<T>(key: key);
}

class _Key {
  final Type type;
  final Object? key;
  const _Key(this.type, this.key);

  @override
  bool operator ==(Object other) =>
      other is _Key && other.type == type && other.key == key;

  @override
  int get hashCode => Object.hash(type, key);
}

abstract class _Provider<T> {
  T get(Resolver r);
}

class _FactoryProvider<T> implements _Provider<T> {
  final FactoryFunc<T> _create;
  _FactoryProvider(this._create);
  @override
  T get(Resolver r) => _create(r);
}

class _SingletonProvider<T> implements _Provider<T> {
  final T _instance;
  _SingletonProvider(this._instance);
  @override
  T get(Resolver r) => _instance;
}

class _LazySingletonProvider<T> implements _Provider<T> {
  final FactoryFunc<T> _create;
  T? _cache;
  _LazySingletonProvider(this._create);

  @override
  T get(Resolver r) {
    return _cache ??= _create(r);
  }
}

class _AsyncSingletonProvider<T> implements _Provider<T> {
  final AsyncFactoryFunc<T> _create;
  _AsyncSingletonProvider(this._create);

  Future<T> create(Resolver r) => _create(r);

  @override
  T get(Resolver r) {
    throw StateError('Use getAsync<T>() for async singleton.');
  }
}

class _AsyncPlaceholder {}
