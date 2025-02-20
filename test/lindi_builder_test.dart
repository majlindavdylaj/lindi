import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lindi/lindi.dart';

/// A simple test view model for testing LindiBuilder
class CounterTestLindiViewModel extends LindiViewModel {
  int counter = 0;

  void increment() {
    counter++;
    notify();
  }

  void decrement() {
    counter--;
    notify();
  }
}

/// A simple test view model for testing LindiBuilder
class AsyncTestLindiViewModel extends LindiViewModel<String, String> {
  void testLoading() async {
    setLoading();
  }

  void testData() {
    setData('success');
  }

  void testError() {
    setError('error');
  }
}

void main() {
  group('LindiBuilder', () {
    testWidgets('should rebuild when LindiViewModels updates', (tester) async {
      final counterViewModel = CounterTestLindiViewModel();
      final asyncViewModel = AsyncTestLindiViewModel();

      bool listenerLoadingCalled = false;
      bool listenerDataCalled = false;
      bool listenerErrorCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: LindiBuilder(
            viewModels: [counterViewModel, asyncViewModel],
            listener: (context, viewModel) {
              if (asyncViewModel.isLoading) {
                listenerLoadingCalled = true;
              }
              if (asyncViewModel.hasError) {
                listenerErrorCalled = true;
              }
              if (asyncViewModel.hasData) {
                listenerDataCalled = true;
              }
            },
            builder: (context) {
              return Column(
                children: [
                  Text('${counterViewModel.counter}',
                      textDirection: TextDirection.ltr),
                  if (asyncViewModel.isLoading)
                    Text('loading', textDirection: TextDirection.ltr),
                  if (asyncViewModel.hasError)
                    Text('${asyncViewModel.error}',
                        textDirection: TextDirection.ltr),
                  if (asyncViewModel.hasData)
                    Text('${asyncViewModel.data}',
                        textDirection: TextDirection.ltr),
                ],
              );
            },
          ),
        ),
      );

      // Initial state should be 0
      expect(find.text('0'), findsOneWidget);
      expect(listenerLoadingCalled, false);

      // Update view model state
      counterViewModel.increment();
      asyncViewModel.testLoading();
      await tester.pump();

      // UI should update to reflect new state
      expect(find.text('1'), findsOneWidget);
      expect(find.text('loading'), findsOneWidget);
      expect(listenerLoadingCalled, true);
      expect(listenerErrorCalled, false);

      // Update view model state
      counterViewModel.decrement();
      counterViewModel.decrement();
      asyncViewModel.testError();
      await tester.pump();

      // UI should update to reflect new state
      expect(find.text('-1'), findsOneWidget);
      expect(find.text('error'), findsOneWidget);
      expect(listenerErrorCalled, true);
      expect(listenerDataCalled, false);

      asyncViewModel.testData();
      await tester.pump();

      expect(find.text('success'), findsOneWidget);
      expect(listenerDataCalled, true);
    });
  });
}
