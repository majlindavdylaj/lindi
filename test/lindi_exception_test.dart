import 'package:flutter_test/flutter_test.dart';
import 'package:lindi/src/utils/lindi_exception.dart';

void main() {
  test('should create exception with message only', () {
    final exception = LindiException("Something went wrong");

    expect(exception.message, "Something went wrong");
    expect(exception.errorCode, isNull);
    expect(exception.toString(), "LindiException: Something went wrong");
  });

  test('should create exception with message and error code', () {
    final exception = LindiException("Invalid request", 400);

    expect(exception.message, "Invalid request");
    expect(exception.errorCode, 400);
    expect(exception.toString(), "LindiException (Code 400): Invalid request");
  });
}
