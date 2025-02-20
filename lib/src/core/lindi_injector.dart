import 'package:lindi/lindi.dart';
import 'package:lindi/src/utils/lindi_exception.dart';

class LindiInjector {
  static final Map<Type, dynamic> _instances = {};

  /// Register an instance of a LindiViewModel
  static void register<T extends LindiViewModel>(T instance) {
    _instances[T] = instance;
  }

  /// Retrieve an instance of a LindiViewModel
  static T get<T extends LindiViewModel>() {
    final instance = _instances[T];
    if (instance == null) {
      throw LindiException(
          'No instance of type $T found. Did you forget to register it?');
    }
    return instance;
  }

  /// Unregister a specific instance
  static void unregister<T extends LindiViewModel>() {
    if (!_instances.containsKey(T)) {
      throw LindiException('No instance of type $T found to unregister.');
    }
    _instances.remove(T);
  }

  /// Check if an instance exists
  static bool exists<T extends LindiViewModel>() {
    return _instances.containsKey(T);
  }

  /// Clear all instances (optional for testing or cleanup)
  static void clear() {
    _instances.clear();
  }
}
