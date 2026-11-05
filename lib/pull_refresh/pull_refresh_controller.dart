import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/widgets.dart';

enum PullRefreshMode { idle, refreshing, finishing }

class PullRefreshController extends ChangeNotifier {
  PullRefreshController({
    required this.onRefresh,
    this.triggerOffset = 30.0,
    this.maxOverOffset = 62.0,
    this.finishDuration = const Duration(milliseconds: 1000),
    this.closeDuration = const Duration(milliseconds: 600),
  }) {
    scrollController.addListener(notifyListeners);
  }

  final Future<void> Function() onRefresh;
  final double triggerOffset;
  final double maxOverOffset;
  final Duration finishDuration;

  /// How long the content takes to scroll back up after a refresh.
  final Duration closeDuration;
  final ScrollController scrollController = ScrollController();

  PullRefreshMode mode = PullRefreshMode.idle;
  bool isDragging = false;

  /// Content rest position, held open while refreshing.
  double get restOffset =>
      mode == PullRefreshMode.refreshing ? triggerOffset : 0.0;

  double get offset => scrollController.hasClients
      ? math.max(0.0, -scrollController.offset)
      : 0.0;

  void _setMode(PullRefreshMode value) {
    mode = value;
    notifyListeners();
  }

  void startRefresh() {
    if (mode != PullRefreshMode.idle) return;
    _setMode(PullRefreshMode.refreshing);

    scheduleMicrotask(() async {
      try {
        await onRefresh();
      } finally {
        await _finish();
      }
    });
  }

  Future<void> _finish() async {
    _setMode(PullRefreshMode.finishing);
    // Scroll content back up while finish animation plays.
    await Future.wait([
      if (offset > 0)
        scrollController.animateTo(
          0,
          duration: closeDuration,
          curve: Curves.easeOutCubic,
        ),
      Future<void>.delayed(finishDuration),
    ]);
    _setMode(PullRefreshMode.idle);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
