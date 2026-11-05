import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:sizer/sizer.dart';

import 'pull_refresh_controller.dart';

class PullRefreshIndicator extends StatefulWidget {
  final PullRefreshController controller;

  const PullRefreshIndicator({super.key, required this.controller});

  @override
  State<PullRefreshIndicator> createState() => _PullRefreshIndicatorState();
}

class _PullRefreshIndicatorState extends State<PullRefreshIndicator> {
  late final FileLoader _fileLoader = FileLoader.fromAsset(
    'assets/rive/pull_refresh.riv',
    riveFactory: Factory.flutter,
  );

  NumberInput? _pullAmount;
  TriggerInput? _loadingTrigger;
  TriggerInput? _finishTrigger;

  late PullRefreshMode _mode = widget.controller.mode;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onChanged);
    _fileLoader.dispose();
    super.dispose();
  }

  void _onLoaded(RiveLoaded state) {
    final sm = state.controller.stateMachine;
    _pullAmount = sm.number('pullAmount');
    _loadingTrigger = sm.trigger('loadingTrigger');
    _finishTrigger = sm.trigger('finishTrigger');
  }

  void _onChanged() {
    final controller = widget.controller;

    if (controller.mode != _mode) {
      _mode = controller.mode;
      switch (_mode) {
        case PullRefreshMode.refreshing:
          _loadingTrigger?.fire();
          break;
        case PullRefreshMode.finishing:
          _finishTrigger?.fire();
          break;
        case PullRefreshMode.idle:
          _pullAmount?.value = 0;
          return;
      }
    }

    final progress = controller.offset / controller.triggerOffset * 100;
    _pullAmount?.value = progress.clamp(0.0, 100.0);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 27.h,
      child: RiveWidgetBuilder(
        fileLoader: _fileLoader,
        artboardSelector: ArtboardSelector.byName('Artboard'),
        stateMachineSelector: StateMachineSelector.byName('Main'),
        onLoaded: _onLoaded,
        builder: (_, state) => switch (state) {
          RiveLoading() => const SizedBox.shrink(),
          RiveFailed() => ErrorWidget.withDetails(
            message: state.error.toString(),
            error: FlutterError(state.error.toString()),
          ),
          RiveLoaded() => RiveWidget(
            controller: state.controller,
            fit: Fit.fitWidth,
          ),
        },
      ),
    );
  }
}
