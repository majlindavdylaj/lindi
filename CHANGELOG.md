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
