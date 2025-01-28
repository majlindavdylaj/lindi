import 'package:flutter/material.dart';
import 'package:lindi/lindi.dart';

void main() {
  // Register the CounterLindiViewModel globally
  LindiInjector.register(CounterLindiViewModel());
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

// Counter Screen
class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the CounterLindiViewModel from the injector
    final counterViewModel = LindiInjector.get<CounterLindiViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Lindi Counter Example')),
      body: Center(
        child: LindiBuilder(
          viewModel: counterViewModel,
          builder: (context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Counter: ${counterViewModel.counter}',
                  style: const TextStyle(fontSize: 24),
                ),
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
            );
          },
        ),
      ),
    );
  }
}
