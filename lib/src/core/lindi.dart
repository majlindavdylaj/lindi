import 'package:lindi/lindi.dart';

class Lindi {
  static final Map<Type, dynamic> _instances = {};

  /// Inject instances of a LindiViewModel
  static void inject(List<LindiViewModel> instances) {
    for (var instance in instances) {
      _instances[instance.runtimeType] = instance;
    }
  }

  /// Retrieve an instance of a LindiViewModel
  static T get<T extends LindiViewModel>() {
    final instance = _instances[T];
    if (instance == null) {
      throw LindiException(
          'No instance of type $T found. Did you forget to inject it?');
    }
    return instance;
  }
}
