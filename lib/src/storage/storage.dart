abstract class Storage<D, E> {
  /// Converts a JSON-like map [json] into a domain object of type [D].
  ///
  /// This method is typically used when reading data from persistent storage.
  D fromJson(Map<String, dynamic> json);

  /// Converts a domain object [d] into a JSON-like map.
  ///
  /// This method is typically used before saving data to persistent storage.
  Map<String, dynamic> toJson(D d);
}
