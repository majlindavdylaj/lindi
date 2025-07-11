## 0.5.0
- Added `LindiStorageViewModel` to save data to storage
- To use Lindi you now need to call `await Lindi.init()` before using Lindi
- Updated to latest Flutter version

## 0.3.1
- Deleted unused files.
- Make LindiViewModel class abstract.

## 0.3.0
#### Removed
- Removed `LindiInjector`.
#### Added
- Added `Lindi` to `inject` and `get` LindiViewModel instances, simpler and more straightforward
```dart
    Lindi.inject([CounterLindiViewModel()...]);
    .
    .
    final counterViewModel = Lindi.get<CounterLindiViewModel>();
```

## 0.2.0
#### Removed
- Removed `LindiMultiBuilder`, now you can use `LindiBuilder` for single and multiple viewModels.
#### Added
- Added `listeners` to LindiBuilder a callback function that listen when the `viewModel` updates.
- Added `hasData` to check if a viewModel have data.
- Added `unregister<T>()` to unregister a specific instance of `LindiViewModel` from LindiInjector.
#### Changed
- Changed `viewModel` parameter to `viewModels` now can accept list of `LindiViewModel`.

## 0.1.1
#### Added
- Unit tests for `LindiViewModel`, `LindiBuilder`, `LindiMultiBuilder`, `LindiInjector`, `LindiException`.

## 0.1.0
#### Added
- Initial release of `LindiViewModel<D, E>`.
- Implemented `setLoading()`, `setData(D data)`, and `setError(E error)` methods.

## 0.0.1
- Publish
