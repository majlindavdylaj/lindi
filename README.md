<p align="center">
	<a href="https://pub.dartlang.org/packages/lindi"><img src="https://img.shields.io/pub/v/lindi?color=blue" alt="Pub dev"></a>
	<a href="https://github.com/majlindavdylaj/lindi/actions"><img src="https://github.com/majlindavdylaj/lindi/workflows/Build/badge.svg" alt="Build Status"></a>
	<a href="https://discord.gg/CYMhKYht"><img src="https://img.shields.io/discord/1347558525962027009?logo=discord&color=blue" alt="Discord"></a>
</p>


# Lindi

Lindi is a lightweight and reactive state management library for Flutter that simplifies building applications with dynamic UI updates. It enables developers to manage state using `LindiViewModel` and provides powerful widgets like `LindiBuilder` to listen and react to changes in state.

## Features

- Easy state management with `LindiViewModel`.
- Reactivity using `LindiBuilder` for single and multiple states.
- Global dependency injection.
- Lightweight, intuitive, and easy to integrate.

---

## Installation

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
```

Create a class that extends `LindiViewModel<D, E>` to manage your state:

```dart
class ApiLindiViewModel extends LindiViewModel<String, String> {

  void fetchData() async {
    setLoading();
    await Future.delayed(Duration(seconds: 4));
    setData('Fetched');
    await Future.delayed(Duration(seconds: 3));
    setError('Timeout!');
  }
}
```

- `ApiLindiViewModel` inherits from `LindiViewModel<String, String>`, where:
  - `<D>` represents the data type (in this case, API response data as `String`).
  - `<E>` represents the error type (in this case, error as `String`).

### 2. Register Your `LindiViewModel`

Use injector to make the `LindiViewModel` accessible globally:

```dart
Lindi.inject([CounterLindiViewModel(), ApiLindiViewModel()]);
```

### 3. Use `LindiBuilder`

React to changes in a single `LindiViewModel` with `LindiBuilder`:

```dart
class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counterViewModel = Lindi.get<CounterLindiViewModel>();

    return Scaffold(
      body: Center(
        child: LindiBuilder(
          viewModels: [counterViewModel],
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

React to changes in a single `LindiViewModel<D, E>` with `LindiBuilder`:

```dart
class ApiScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final apiViewModel = Lindi.get<ApiLindiViewModel>();

    return Scaffold(
      body: Center(
        child: LindiBuilder(
          viewModels: [apiViewModel],
          builder: (context) {
            if(apiViewModel.isLoading){
              return CircularProgressIndicator();
            }
            if(apiViewModel.hasError){
              return Text(apiViewModel.error!);
            }
            return Text(apiViewModel.data!);
          },
        ),
      ),
    );
  }
}
```

### 4. Use `LindiBuilder`

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
    final counterViewModel = Lindi.get<CounterLindiViewModel>();
    final themeViewModel = Lindi.get<ThemeLindiViewModel>();

    return Scaffold(
      body: LindiBuilder(
        viewModels: [counterViewModel, themeViewModel],
        listener: (context, viewModel) {
          if (viewModel is ThemeLindiViewModel) {
            if(themeViewModel.isDarkMode){
              debugPrint('Theme changed to dark mode');
            } else {
              debugPrint('Theme changed to light mode');
            }
          }
        },
        builder: (context) {
          return Center(
            child: Column(
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
            ),
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
- Call `setLoading()` to mark the LindiViewModel as loading and reset any previous error.
- Call `setData(D data)` to update the LindiViewModel with new data and stops loading.
- Call `setError(E error)` to store an error.

### `LindiBuilder`

- Parameters:
  - `viewModels`: A list of `LindiViewModel` objects to listen to.
  - `listener`: A callback function that listens when the `viewModel` updates.
  - `builder`: A function that rebuilds the UI with the updated state.

### `Lindi`

- Methods:
  - `inject(List<LindiViewModel> instances)`: Inject a list of `LindiViewModel` instances.
  - `T get<T extends LindiViewModel>()`: Retrieves an injected `LindiViewModel` instance.

---

## Example Project

For a complete example, check out the [example folder](https://github.com/majlindavdylaj/lindi/tree/main/example) in the repository.

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## Contributing

We welcome contributions! Feel free to submit issues or pull requests to improve Lindi.

---

Happy coding with **Lindi**! 🚀

