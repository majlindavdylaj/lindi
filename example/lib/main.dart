import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lindi/lindi.dart';

void main() {
  // Register the LindiViewModels globally
  LindiInjector.register(CounterLindiViewModel());
  LindiInjector.register(ApiLindiViewModel()..fetchData());
  runApp(const MyApp());
}

// Example App
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lindi Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CounterScreen(),
    );
  }
}

// Counter ViewModel
class CounterLindiViewModel extends LindiViewModel {
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

/// A ViewModel for handling API calls using the Lindi.
///
/// This class extends `LindiViewModel<String, String>`, meaning it manages:
/// - **Data (`String`)**: The fetched API response.
/// - **Error (`String`)**: Error messages related to the API request.
class ApiLindiViewModel extends LindiViewModel<String, String> {
  void fetchData() async {
    if(isLoading) return;
    setLoading();
    await Future.delayed(Duration(seconds: 4));
    if(Random().nextBool()){
      setData('Fetch');
    } else {
      setError('Timeout!');
    }
  }
}

// Counter Screen
class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve LindiViewModels from the injector
    final counterViewModel = LindiInjector.get<CounterLindiViewModel>();
    final apiViewModel = LindiInjector.get<ApiLindiViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Lindi Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LindiBuilder(
                    viewModel: counterViewModel,
                    builder: (context) {
                      return Text(
                        'Counter: ${counterViewModel.counter}',
                        style: const TextStyle(fontSize: 24),
                      );
                    }),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: counterViewModel.increment,
                  child: const Text('Increment'),
                ),
                ElevatedButton(
                  onPressed: counterViewModel.decrement,
                  child: const Text('Decrement'),
                ),
              ],
            ),
            Column(
              children: [
                LindiBuilder(
                  viewModel: apiViewModel,
                  builder: (context) {
                    if (apiViewModel.isLoading) {
                      return CircularProgressIndicator();
                    }
                    if (apiViewModel.hasError) {
                      return Text(
                        apiViewModel.error!,
                        style: TextStyle(color: Colors.red),
                      );
                    }
                    return Text(
                      apiViewModel.data!,
                      style: TextStyle(color: Colors.green),
                    );
                  },
                ),
                const SizedBox(height: 20),
                LindiBuilder(
                  viewModel: apiViewModel,
                  builder: (context) {
                    return ElevatedButton(
                      onPressed: apiViewModel.fetchData,
                      child: const Text('Refresh'),
                    );
                  }
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
