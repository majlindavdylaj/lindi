import 'package:flutter/material.dart';
import 'package:lindi/lindi.dart';

/// A widget that listens to a list of `LindiViewModel`s and rebuilds
/// whenever any of the view models change, calling the provided builder function.
class LindiMultiBuilder extends StatefulWidget {
  /// A list of view models that this widget listens to for changes.
  final List<LindiViewModel> viewModels;

  /// The builder function that defines how the UI should be built.
  final Widget Function(BuildContext context) builder;

  const LindiMultiBuilder({
    super.key,
    required this.viewModels,
    required this.builder,
  });

  @override
  State<LindiMultiBuilder> createState() => _LindiMultiBuilderState();
}

class _LindiMultiBuilderState extends State<LindiMultiBuilder> {
  @override
  void initState() {
    super.initState();
    // Adds listeners to each view model in the list to trigger a rebuild
    // when any of them change.
    for (var viewModel in widget.viewModels) {
      viewModel.addListener(_onViewModelChanged);
    }
  }

  @override
  void didUpdateWidget(covariant LindiMultiBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);

    // If the list of view models has changed, remove listeners from
    // the old view models and add them to the new ones.
    if (oldWidget.viewModels != widget.viewModels) {
      for (var viewModel in oldWidget.viewModels) {
        viewModel.removeListener(_onViewModelChanged);
      }
      for (var viewModel in widget.viewModels) {
        viewModel.addListener(_onViewModelChanged);
      }
    }
  }

  @override
  void dispose() {
    // Removes listeners from all view models when the widget is disposed
    // to prevent memory leaks.
    for (var viewModel in widget.viewModels) {
      viewModel.removeListener(_onViewModelChanged);
    }
    super.dispose();
  }

  /// Callback triggered when any of the `viewModels` changes.
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
