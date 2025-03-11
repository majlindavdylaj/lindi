typedef Listener = void Function(LindiViewModel viewModel);

abstract class LindiViewModel<D, E> {
  final List<Listener> _listeners = [];

  D? _data;
  bool _isLoading = false;
  E? _error;

  /// Getters
  bool get isLoading => _isLoading;
  bool get hasData => _data != null;
  D? get data => _data;
  bool get hasError => _error != null;
  E? get error => _error;

  /// Add a listener
  void addListener(Listener listener) {
    _listeners.add(listener);
  }

  /// Remove a listener
  void removeListener(Listener listener) {
    _listeners.remove(listener);
  }

  /// Notify all listeners
  void notify() {
    for (final listener in _listeners) {
      listener(this);
    }
  }

  /// Set loading state
  void setLoading() {
    _reset();
    _isLoading = true;
    notify();
  }

  /// Set data state
  void setData(D data) {
    _reset();
    _data = data;
    notify();
  }

  /// Set error state
  void setError(E error) {
    _reset();
    _error = error;
    notify();
  }

  /// Reset state
  void _reset() {
    _data = null;
    _isLoading = false;
    _error = null;
  }
}
