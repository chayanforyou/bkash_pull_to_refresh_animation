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
    if (value > position.maxScrollExtent) {
      return value - position.maxScrollExtent;
    }

    // Keep default behavior for everything else
    return super.applyBoundaryConditions(position, value);
  }
}