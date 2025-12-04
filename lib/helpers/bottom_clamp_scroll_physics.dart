import 'package:flutter/material.dart';

class BottomClampScrollPhysics extends ScrollPhysics {
  const BottomClampScrollPhysics({super.parent});

  @override
  BottomClampScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return BottomClampScrollPhysics(parent: ancestor);
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    // Hard clamp bottom (no overscroll)
    if (position.maxScrollExtent <= position.pixels && position.pixels < value) {
      // Overscroll.
      return value - position.pixels;
    }

    if (position.pixels < position.maxScrollExtent && position.maxScrollExtent < value) {
      // Hit bottom edge.
      return value - position.maxScrollExtent;
    }

    // Keep default behavior for everything else
    return super.applyBoundaryConditions(position, value);
  }
}