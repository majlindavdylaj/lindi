class LindiException implements Exception {
  final String message;
  final int? errorCode;

  LindiException(this.message, [this.errorCode]);

  @override
  String toString() {
    if (errorCode != null) {
      return "LindiException (Code $errorCode): $message";
    }
    return "LindiException: $message";
  }
}
