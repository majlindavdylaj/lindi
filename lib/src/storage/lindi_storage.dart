import 'package:hive_ce/hive.dart';
import 'package:lindi/lindi.dart';
import 'package:lindi/src/storage/storage.dart';

/// A utility class that handles data storage using Hive and a custom
/// serialization/deserialization strategy via the [Storage] interface.
class LindiStorage {
  /// Hive box instance used for reading/writing data.
  static Box? box;

  /// Saves a value of type [D] into the Hive box using the given [key].
  ///
  /// [value] is serialized using the [storage] strategy before storing.
  static void save<D, E>(String key, D? value, Storage storage) {
    if (box == null) throw LindiException("Lindi is not initialized.");
    // Serialize the value using the provided Storage implementation and save it
    box!.put(key, storage.toJson(value));
  }

  /// Reads a value of type [D] from the Hive box using the given [key].
  ///
  /// The raw stored data is deserialized using the provided [storage] strategy.
  static D? read<D, E>(String key, Storage<D, E> storage) {
    if (box == null) throw LindiException("Lindi is not initialized.");
    final data = box!.get(key);

    if (data != null) {
      // Cast the raw data to a JSON-like Map before deserialization
      final castedData = data.cast<String, dynamic>();
      return storage.fromJson(castedData);
    }

    // Return null if no data is found
    return null;
  }
}
