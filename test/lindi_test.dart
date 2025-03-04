import 'package:flutter_test/flutter_test.dart';
import 'package:lindi/lindi.dart';
import 'package:lindi/src/utils/lindi_exception.dart';

/// A simple test view model
class TestViewModel1 extends LindiViewModel<int, String> {}

class TestViewModel2 extends LindiViewModel<int, String> {}

void main() {
  group('Lindi', () {
    test('should register and retrieve a view model', () {
      final viewModel = TestViewModel1();
      Lindi.inject([viewModel]);

      final retrievedViewModel = Lindi.get<TestViewModel1>();
      expect(retrievedViewModel, same(viewModel));
    });

    test('should throw an exception when retrieving an unregistered view model',
        () {
      expect(
        () => Lindi.get<TestViewModel2>(),
        throwsA(isA<LindiException>()),
      );
    });
  });
}
