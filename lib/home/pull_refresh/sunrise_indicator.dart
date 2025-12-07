import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:sizer/sizer.dart';

class SunriseIndicator extends StatefulWidget {
  final IndicatorState state;
  final bool reverse;

  const SunriseIndicator({super.key, required this.state, required this.reverse});

  @override
  State<SunriseIndicator> createState() => _SunriseIndicatorState();
}

class _SunriseIndicatorState extends State<SunriseIndicator> {
  SMINumber? pull;
  SMITrigger? loading;
  SMITrigger? finish;
  StateMachineController? controller;

  double get _offset => widget.state.offset;

  double get _actualTriggerOffset => widget.state.actualTriggerOffset;

  @override
  void initState() {
    super.initState();
    widget.state.notifier.addModeChangeListener(_onModeChange);
    _loadRiveFile();
  }

  RiveFile? _riveFile;

  void _loadRiveFile() {
    rootBundle.load('assets/rive/pull_refresh.riv').then((data) async {
      // Load the RiveFile from the binary data.
      setState(() {
        _riveFile = RiveFile.import(data);
      });
    });
  }

  @override
  void dispose() {
    widget.state.notifier.removeModeChangeListener(_onModeChange);
    controller?.dispose();
    super.dispose();
  }

  void _onModeChange(IndicatorMode mode, double offset) {
    switch (mode) {
      case IndicatorMode.ready:
        loading?.fire();
      case IndicatorMode.processed:
        finish?.fire();
      case IndicatorMode.done:
        pull?.value = 0;
      default:
        break;
    }
  }

  @override
  void didUpdateWidget(covariant SunriseIndicator oldWidget) {
    if (pull != null) {
      if (_offset < _actualTriggerOffset) {
        pull?.value = _offset / _actualTriggerOffset * 100;
      } else {
        pull?.value = 100;
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 27.h,
      width: 100.w,
      child: _riveFile != null
          ? RiveAnimation.direct(
        _riveFile!,
        artboard: 'Artboard',
        fit: BoxFit.fitWidth,
        onInit: (artboard) {
          controller = StateMachineController.fromArtboard(artboard, 'Main')!;
          controller?.isActive = true;
          if (controller == null) {
            throw Exception('Unable to initialize state machine controller');
          }
          artboard.addController(controller!);
          pull = controller!.findInput<double>('pullAmount') as SMINumber;
          loading = controller!.findInput<bool>('loadingTrigger') as SMITrigger;
          finish = controller!.findInput<bool>('finishTrigger') as SMITrigger;
        },
      )
          : const SizedBox.shrink(),
    );
  }
}