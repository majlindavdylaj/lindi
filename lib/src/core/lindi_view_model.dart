typedef Listener = void Function();

class LindiViewModel<D, E> {
  final List<Listener> _listeners = [];

  D? _data;
  bool _isLoading = false;
  E? _error;

  /// Getters
  D? get data => _data;
  bool get isLoading => _isLoading;
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
      listener();
    }
  }

  /// Set loading state
  void setLoading() {
    _isLoading = true;
    _error = null;
    notify();
  }

  /// Set data state
  void setData(D data) {
    _data = data;
    _isLoading = false;
    _error = null;
    notify();
  }

  /// Set error state
  void setError(E error) {
    _error = error;
    _isLoading = false;
    notify();
  }
}
