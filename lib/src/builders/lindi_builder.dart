import 'package:flutter/material.dart';
import 'package:lindi/lindi.dart';

/// A widget that listens to a list of `LindiViewModel`s and rebuilds
/// whenever any of the view models change, calling the provided builder function.
class LindiBuilder extends StatefulWidget {
  /// A list of view models that this widget listens to for changes.
  final List<LindiViewModel> viewModels;

  /// Callback function executed when the `viewModel` updates.
  final void Function(BuildContext context, LindiViewModel viewModel)? listener;

  /// The builder function that defines how the UI should be built.
  final Widget Function(BuildContext context) builder;

  LindiBuilder({
    super.key,
    required this.viewModels,
    this.listener,
    required this.builder,
  }) : assert(viewModels.isNotEmpty,
            "LindiBuilder requires at least one LindiViewModel");

  @override
  State<LindiBuilder> createState() => _LindiBuilderState();
}

class _LindiBuilderState extends State<LindiBuilder> {
  @override
  void initState() {
    super.initState();
    // Adds listeners to each view model in the list to trigger a rebuild
    // when any of them change.
    _addListeners();
  }

  void _addListeners() {
    for (var viewModel in widget.viewModels) {
      viewModel.addListener(_onViewModelChanged);
    }
  }

  void _removeListeners() {
    for (var viewModel in widget.viewModels) {
      viewModel.removeListener(_onViewModelChanged);
    }
  }

  @override
  void didUpdateWidget(covariant LindiBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);

    // If the list of view models has changed, remove listeners from
    // the old view models and add them to the new ones.
    if (oldWidget.viewModels != widget.viewModels) {
      _removeListeners();
      _addListeners();
    }
  }

  @override
  void dispose() {
    // Removes listeners from all view models when the widget is disposed
    // to prevent memory leaks.
    _removeListeners();
    super.dispose();
  }

  /// Callback triggered when any of the `viewModels` changes.
  void _onViewModelChanged(LindiViewModel viewModel) {
    if (widget.listener != null) {
      widget.listener!(context, viewModel);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Calls the builder function to rebuild the UI.
    return widget.builder(context);
  }
}
