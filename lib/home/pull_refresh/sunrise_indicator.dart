import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class SunriseIndicator extends StatefulWidget {
  final IndicatorController controller;

  const SunriseIndicator({super.key, required this.controller});

  @override
  State<SunriseIndicator> createState() => _SunriseIndicatorState();
}

class _SunriseIndicatorState extends State<SunriseIndicator> {
  SMINumber? pull;
  SMITrigger? loading;
  SMITrigger? finish;
  StateMachineController? riveController;
  RiveFile? _riveFile;

  IndicatorState get _state => widget.controller.state;

  @override
  void initState() {
    super.initState();
    _loadRiveFile();
    widget.controller.addListener(_onControllerChange);
  }

  void _loadRiveFile() {
    rootBundle.load('assets/rive/pull_refresh.riv').then((data) async {
      setState(() {
        _riveFile = RiveFile.import(data);
      });
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerChange);
    riveController?.dispose();
    super.dispose();
  }

  void _onControllerChange() {
    switch (_state) {
      case IndicatorState.settling:
        loading?.fire();
        break;
      case IndicatorState.finalizing:
        finish?.fire();
        break;
      case IndicatorState.idle:
        pull?.value = 0;
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // if (_state == IndicatorState.dragging || _state == IndicatorState.armed) {
    //   final value = (widget.controller.value * 100).clamp(0.0, 100.0);
    //   pull?.value = value;
    // }
    if (pull != null) {
      final value = (widget.controller.value * 100).clamp(0.0, 100.0);
      pull?.value = value;
    }

    final height = MediaQuery.sizeOf(context).height * 0.3;

    return SizedBox(
      height: height,
      width: double.infinity,
      child: _riveFile != null
          ? RiveAnimation.direct(
              _riveFile!,
              artboard: 'Artboard',
              fit: BoxFit.cover,
              onInit: (artboard) {
                riveController = StateMachineController.fromArtboard(artboard, 'Main')!;
                riveController?.isActive = true;
                if (riveController == null) {
                  throw Exception('Unable to initialize state machine controller');
                }
                artboard.addController(riveController!);
                pull = riveController!.findInput<double>('pullAmount') as SMINumber;
                loading = riveController!.findInput<bool>('loadingTrigger') as SMITrigger;
                finish = riveController!.findInput<bool>('finishTrigger') as SMITrigger;
              },
            )
          : const SizedBox.shrink(),
    );
  }
}
