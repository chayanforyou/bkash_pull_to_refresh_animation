import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import 'pull_refresh_controller.dart';

class PullRefreshPhysics extends ScrollPhysics {
  const PullRefreshPhysics({
    required this.controller,
    super.parent = const ClampingScrollPhysics(),
  });

  final PullRefreshController controller;

  /// How far content moves per pixel of finger drag while pulling.
  /// Lower = slower, heavier pull.
  static const _pullFactor = 0.2;

  /// Max px the content moves past the top per drag update.
  /// Caps speed so a fast, hard pull still comes down slowly.
  static const _maxPullStep = 2.0;

  static final _spring = SpringDescription.withDampingRatio(
    mass: 0.5,
    stiffness: 100.0,
    ratio: 1.1,
  );

  @override
  PullRefreshPhysics applyTo(ScrollPhysics? ancestor) =>
      PullRefreshPhysics(controller: controller, parent: buildParent(ancestor));

  @override
  bool shouldAcceptUserOffset(ScrollMetrics position) => true;

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    controller.isDragging = true;
    final overscroll = position.minScrollExtent - position.pixels;

    if (offset > 0) {
      // Pulling down: scroll freely up to the top, resist only past it.
      // Splitting matters for fast pulls, where one frame's delta is large.
      final toTop = math.max(0.0, -overscroll);
      if (offset <= toTop) return offset;
      // No new pull while the finish animation plays.
      if (controller.mode == PullRefreshMode.finishing) return toTop;
      return toTop + math.min((offset - toTop) * _pullFactor, _maxPullStep);
    }

    // Pushing back up.
    if (overscroll <= 0) return offset;
    return offset * _pullFactor;
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    final min = position.minScrollExtent;
    final max = position.maxScrollExtent;

    if (value > max) return value - math.max(position.pixels, max);

    if (value < min) {
      final limit = controller.isDragging
          ? min - controller.maxOverOffset
          : math.min(position.pixels, min - controller.restOffset);
      if (value < limit) return value - limit;
    }
    return 0.0;
  }

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    final wasDragging = controller.isDragging;
    controller.isDragging = false;

    final tolerance = toleranceFor(position);
    final min = position.minScrollExtent;
    final overscroll = min - position.pixels;

    if (overscroll > 0) {
      if (wasDragging && overscroll >= controller.triggerOffset) {
        controller.startRefresh();
      }
      final target = min - controller.restOffset;
      final distance = target - position.pixels;
      if (distance.abs() < tolerance.distance) return null;
      return ScrollSpringSimulation(
        _spring,
        position.pixels,
        target,
        velocity.sign == distance.sign ? velocity : 0.0,
        tolerance: tolerance,
      );
    }

    return super.createBallisticSimulation(position, velocity);
  }
}
