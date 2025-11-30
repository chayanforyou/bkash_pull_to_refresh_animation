import 'package:flutter/material.dart';

class LinearScrollPhysics extends ScrollPhysics {
  const LinearScrollPhysics({super.parent});

  @override
  LinearScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return LinearScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    // Trying to go above min
    if (value < position.minScrollExtent) {
      return value - position.minScrollExtent;
    }
    // Trying to go below max
    if (value > position.maxScrollExtent) {
      return value - position.maxScrollExtent;
    }
    return 0.0;
  }

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    if (position.pixels <= position.minScrollExtent ||
        position.pixels >= position.maxScrollExtent) {
      return null;
    }

    final Tolerance t = toleranceFor(position);

    return ClampingScrollSimulation(
      position: position.pixels,
      velocity: velocity,
      tolerance: t,
    );
  }
}
