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
    setData('error');
  }
}

void main() {
  group('LindiBuilder', () {
    testWidgets('should rebuild when CounterTestLindiViewModel updates with notify()', (tester) async {
      final viewModel = CounterTestLindiViewModel();

      await tester.pumpWidget(
        MaterialApp(
          home: LindiBuilder(
            viewModel: viewModel,
            builder: (context) {
              return Text('${viewModel.counter}', textDirection: TextDirection.ltr);
            },
          ),
        ),
      );

      // Initial state should be 0
      expect(find.text('0'), findsOneWidget);

      // Update view model state
      viewModel.increment();
      await tester.pump();

      // UI should update to reflect new state
      expect(find.text('1'), findsOneWidget);

      // Update view model state
      viewModel.decrement();
      viewModel.decrement();
      await tester.pump();

      // UI should update to reflect new state
      expect(find.text('-1'), findsOneWidget);
    });

    testWidgets('should rebuild when AsyncTestLindiViewModel updates with setLoading, setData, setError', (tester) async {
      final viewModel = AsyncTestLindiViewModel()..testLoading();

      await tester.pumpWidget(
        MaterialApp(
          home: LindiBuilder(
            viewModel: viewModel,
            builder: (context) {
              if(viewModel.isLoading) {
                return Text('loading', textDirection: TextDirection.ltr);
              }
              if(viewModel.hasError) {
                return Text(viewModel.error!, textDirection: TextDirection.ltr);
              }
              return Text(viewModel.data!, textDirection: TextDirection.ltr);
            },
          ),
        ),
      );

      // Initial state should be 0
      expect(find.text('loading'), findsOneWidget);

      // Update view model state
      viewModel.testData();
      await tester.pump();
      // UI should update to reflect new state
      expect(find.text('success'), findsOneWidget);

      // Update view model state
      viewModel.testError();
      await tester.pump();
      // UI should update to reflect new state
      expect(find.text('error'), findsOneWidget);
    });

    
  });
}
