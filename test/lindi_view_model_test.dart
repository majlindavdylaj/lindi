import 'package:flutter_test/flutter_test.dart';
import 'package:lindi/lindi.dart';

/// A simple test ViewModel extending LindiViewModel
class TestViewModel extends LindiViewModel<int, String> {}

void main() {
  late TestViewModel viewModel;
  late int listenerCallCount;

  setUp(() {
    viewModel = TestViewModel();
    listenerCallCount = 0;
  });

  test('should initialize with default values', () {
    expect(viewModel.hasData, isFalse);
    expect(viewModel.data, isNull);
    expect(viewModel.isLoading, isFalse);
    expect(viewModel.hasError, isFalse);
    expect(viewModel.error, isNull);
  });

  test('should add and remove listeners', () {
    void testListener(LindiViewModel viewModel) {
      listenerCallCount++;
    }

    viewModel.addListener(testListener);
    viewModel.notify();

    expect(listenerCallCount, 1);

    viewModel.removeListener(testListener);
    viewModel.notify();

    expect(listenerCallCount,
        1); // Should not increase since the listener was removed
  });

  test('should update loading state and notify listeners', () {
    viewModel.addListener((viewModel) {
      listenerCallCount++;
    });

    viewModel.setLoading();

    expect(viewModel.isLoading, isTrue);
    expect(viewModel.hasData, isFalse);
    expect(viewModel.data, isNull);
    expect(viewModel.hasError, isFalse);
    expect(viewModel.error, isNull);
    expect(listenerCallCount, 1);
  });

  test('should update data and notify listeners', () {
    viewModel.addListener((viewModel) {
      listenerCallCount++;
    });

    viewModel.setData(42);

    expect(viewModel.data, 42);
    expect(viewModel.hasData, isTrue);
    expect(viewModel.isLoading, isFalse);
    expect(viewModel.hasError, isFalse);
    expect(viewModel.error, isNull);
    expect(listenerCallCount, 1);
  });

  test('should update error state and notify listeners', () {
    viewModel.addListener((viewModel) {
      listenerCallCount++;
    });

    viewModel.setError("Something went wrong");

    expect(viewModel.hasData, isFalse);
    expect(viewModel.data, isNull);
    expect(viewModel.isLoading, isFalse);
    expect(viewModel.hasError, isTrue);
    expect(viewModel.error, "Something went wrong");
    expect(listenerCallCount, 1);
  });
}
