typedef Listener = void Function();

class LindiViewModel {
  final List<Listener> _listeners = [];

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
}
