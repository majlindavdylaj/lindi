import 'package:flutter_test/flutter_test.dart';
import 'package:lindi/lindi.dart';
import 'package:lindi/src/utils/lindi_exception.dart';

/// A simple test view model
class TestViewModel1 extends LindiViewModel<int, String> {}

class TestViewModel2 extends LindiViewModel<int, String> {}

void main() {
  setUp(() {
    // Ensure the injector is cleared before each test
    LindiInjector.clear();
  });

  group('LindiInjector', () {
    test('should register and retrieve a view model', () {
      final viewModel = TestViewModel1();
      LindiInjector.register(viewModel);

      final retrievedViewModel = LindiInjector.get<TestViewModel1>();
      expect(retrievedViewModel, same(viewModel));
    });

    test('should throw an exception when retrieving an unregistered view model',
        () {
      expect(
        () => LindiInjector.get<TestViewModel2>(),
        throwsA(isA<LindiException>()),
      );
    });

    test('should return true if an instance exists', () {
      final viewModel = TestViewModel1();
      LindiInjector.register(viewModel);

      expect(LindiInjector.exists<TestViewModel1>(), isTrue);
    });

    test('should return false if an instance does not exist', () {
      expect(LindiInjector.exists<TestViewModel2>(), isFalse);
    });

    test('should clear all instances', () {
      final viewModel = TestViewModel2();
      LindiInjector.register(viewModel);

      expect(LindiInjector.exists<TestViewModel2>(), isTrue);

      LindiInjector.clear();

      expect(LindiInjector.exists<TestViewModel2>(), isFalse);
    });

    test('should clear an instance', () {
      final viewModel = TestViewModel2();
      LindiInjector.register(viewModel);

      expect(LindiInjector.exists<TestViewModel2>(), isTrue);

      LindiInjector.unregister<TestViewModel2>();

      expect(LindiInjector.exists<TestViewModel2>(), isFalse);
    });
  });
}
