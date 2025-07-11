import 'package:hive_ce/hive.dart';
import 'package:lindi/lindi.dart';
import 'package:lindi/src/storage/lindi_storage.dart';
import 'package:path_provider/path_provider.dart';

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

  /// Initializes the storage system with the provided [storagePath].
  static init({String? storagePath}) async {
    String path = storagePath ?? (await getTemporaryDirectory()).path;
    Hive.init(path);
    if (LindiStorage.box == null || !LindiStorage.box!.isOpen) {
      LindiStorage.box = await Hive.openBox('lindi_box');
    }
  }
}
