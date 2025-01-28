import 'package:flutter/material.dart';
import 'package:lindi/lindi.dart';

/// A widget that listens to a `LindiViewModel` and rebuilds
/// whenever the `viewModel` changes, calling the provided builder function.
class LindiBuilder extends StatefulWidget {
  /// The view model that this widget listens to for changes.
  final LindiViewModel viewModel;

  /// The builder function that defines how the UI should be built.
  final Widget Function(BuildContext context) builder;

  const LindiBuilder({
    super.key,
    required this.viewModel,
    required this.builder,
  });

  @override
  State<LindiBuilder> createState() => _LindiBuilderState();
}

class _LindiBuilderState extends State<LindiBuilder> {
  @override
  void initState() {
    super.initState();
    // Adds a listener to the view model to trigger a rebuild when it changes.
    widget.viewModel.addListener(_onViewModelChanged);
  }

  @override
  void didUpdateWidget(covariant LindiBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);

    // If the view model changes, remove the listener from the old view model
    // and add it to the new one.
    if (oldWidget.viewModel != widget.viewModel) {
      oldWidget.viewModel.removeListener(_onViewModelChanged);
      widget.viewModel.addListener(_onViewModelChanged);
    }
  }

  @override
  void dispose() {
    // Removes the listener when the widget is disposed to prevent memory leaks.
    widget.viewModel.removeListener(_onViewModelChanged);
    super.dispose();
  }

  /// Callback triggered when the `viewModel` changes.
  /// This forces the widget to rebuild by calling `setState`.
  void _onViewModelChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Calls the builder function to rebuild the UI.
    return widget.builder(context);
  }
}
