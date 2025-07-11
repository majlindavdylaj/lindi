import 'package:lindi/src/storage/storage.dart';
import 'lindi_view_model.dart';

/// A base class that combines view model logic with storage functionality.
abstract class LindiStorageViewModel<D, E> extends LindiViewModel<D, E>
    implements Storage<D, E> {}
