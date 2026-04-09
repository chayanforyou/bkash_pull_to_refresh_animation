import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:sizer/sizer.dart';

class SunriseIndicator extends StatefulWidget {
  final IndicatorState state;
  final bool reverse;

  const SunriseIndicator({
    super.key,
    required this.state,
    required this.reverse,
  });

  @override
  State<SunriseIndicator> createState() => _SunriseIndicatorState();
}

class _SunriseIndicatorState extends State<SunriseIndicator> {
  late final FileLoader _fileLoader = FileLoader.fromAsset(
    'assets/rive/pull_refresh.riv',
    riveFactory: Factory.flutter,
  );

  NumberInput? _pullAmount;
  TriggerInput? _loadingTrigger;
  TriggerInput? _finishTrigger;

  double get _offset => widget.state.offset;

  double get _actualTriggerOffset => widget.state.actualTriggerOffset;

  @override
  void initState() {
    super.initState();
    widget.state.notifier.addModeChangeListener(_onModeChange);
  }

  @override
  void dispose() {
    widget.state.notifier.removeModeChangeListener(_onModeChange);
    _fileLoader.dispose();
    super.dispose();
  }

  void _onLoaded(RiveLoaded state) {
    // Access inputs via stateMachine
    final sm = state.controller.stateMachine;
    _pullAmount = sm.number('pullAmount');
    _loadingTrigger = sm.trigger('loadingTrigger');
    _finishTrigger = sm.trigger('finishTrigger');
  }

  void _onModeChange(IndicatorMode mode, double offset) {
    switch (mode) {
      case IndicatorMode.ready:
        _loadingTrigger?.fire();
        break;
      case IndicatorMode.processed:
        _finishTrigger?.fire();
        break;
      case IndicatorMode.done:
        _pullAmount?.value = 0;
        break;
      default:
        break;
    }
  }

  @override
  void didUpdateWidget(covariant SunriseIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_pullAmount != null) {
      if (_offset < _actualTriggerOffset) {
        _pullAmount?.value = _offset / _actualTriggerOffset * 100;
      } else {
        _pullAmount?.value = 100;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 27.h,
      width: 100.w,
      child: RiveWidgetBuilder(
        fileLoader: _fileLoader,
        artboardSelector: ArtboardSelector.byName('Artboard'),
        stateMachineSelector: StateMachineSelector.byName('Main'),
        onLoaded: _onLoaded,
        builder: (_, state) => switch (state) {
          RiveLoading() => const Center(child: CircularProgressIndicator()),
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
