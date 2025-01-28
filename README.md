# Lindi Library

Lindi is a lightweight and reactive state management library for Flutter that simplifies building applications with dynamic UI updates. It enables developers to manage state using `LindiViewModel` and provides powerful widgets like `LindiBuilder` and `MultiLindiBuilder` to listen and react to changes in state.

## Features

- Easy state management with `LindiViewModel`.
- Reactivity using `LindiBuilder` for single state.
- Combine multiple state objects with `LindiMultiBuilder`.
- Global dependency injection with `LindiInjector`.
- Lightweight, intuitive, and easy to integrate.

---

## Installation

[![pub package](https://img.shields.io/pub/v/lindi.svg)](https://pub.dartlang.org/packages/lindi)

Add Lindi to your Flutter project by including it in your `pubspec.yaml`:

```yaml
dependencies:
  lindi: latest_version
```

Then run:

```bash
flutter pub get
```

---

## Getting Started

### 1. Define a `LindiViewModel`

Create a class that extends `LindiViewModel` to manage your state:

```dart
import 'package:lindi/lindi.dart';

class CounterLLindiViewModel extends LindiViewModel {
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
```

### 2. Register Your `LindiViewModel`

Use `LindiInjector` to make the `LindiViewModel` accessible globally:

```dart
void main() {
  LindiInjector.register(CounterLindiViewModel());
  runApp(const MyApp());
}
```

### 3. Use `LindiBuilder`

React to changes in a single `LindiViewModel` with `LindiBuilder`:

```dart
import 'package:flutter/material.dart';
import 'package:lindi/lindi.dart';

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counterViewModel = LindiInjector.get<CounterLindiViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Counter Example')),
      body: Center(
        child: LindiBuilder(
          viewModel: counterViewModel,
          builder: (context) {
            return Text(
              'Counter: ${counterViewModel.counter}',
              style: const TextStyle(fontSize: 24),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: counterViewModel.increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

### 4. Use `LindiMultiBuilder`

Listen to multiple `LindiViewModel` instances simultaneously:

```dart
class ThemeLindiViewModel extends LindiViewModel {
  bool isDarkMode = false;

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notify();
  }
}

class MultiExampleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counterViewModel = LindiInjector.get<CounterLindiViewModel>();
    final themeViewModel = LindiInjector.get<ThemeLindiViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('MultiLindi Example'),
      ),
      body: LindiMultiBuilder(
        viewModels: [counterViewModel, themeViewModel],
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
                child: const Text('Increment Counter'),
              ),
              const SizedBox(height: 40),
              Text(
                'Current Theme: ${themeViewModel.isDarkMode ? "Dark" : "Light"}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              IconButton(
                icon: Icon(
                  themeViewModel.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                ),
                onPressed: themeViewModel.toggleTheme,
              ),
            ],
          );
        },
      ),
    );
  }
}
```

---

## API Reference

### `LindiViewModel`

- Extend this class to define your state management logic.
- Call `notify()` to update listeners when state changes.

### `LindiBuilder`

- Listens to a single `LindiViewModel`.
- Parameters:
    - `viewModel`: The `LindiViewModel` to listen to.
    - `builder`: A function that rebuilds the UI with the updated state.

### `LindiMultiBuilder`

- Listens to multiple `LindiViewModel` instances.
- Parameters:
    - `viewModels`: A list of `LindiViewModel` objects to listen to.
    - `builder`: A function that rebuilds the UI with the updated states.

### `LindiInjector`

- Dependency injection for `LindiViewModel` objects.
- Methods:
    - `register<T>(T instance)`: Registers a `LindiViewModel`.
    - `get<T>()`: Retrieves a registered `LindiViewModel` instance.
    - `exists<T>()`: Check if an instance exists.
    - `clear()`: Clear all instances (optional for testing or cleanup).

---

## Example Project

For a complete example, check out the [example folder](https://github.com/majlindavdylaj/lindi/example) in the repository.

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## Contributing

We welcome contributions! Feel free to submit issues or pull requests to improve Lindi.

---

Happy coding with **Lindi**! 🚀

