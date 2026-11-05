import 'package:flutter/widgets.dart';

import 'pull_refresh_controller.dart';
import 'pull_refresh_physics.dart';

class PullRefreshScrollView extends StatelessWidget {
  const PullRefreshScrollView({
    super.key,
    required this.controller,
    required this.child,
  });

  final PullRefreshController controller;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // CustomScrollView, not SingleChildScrollView: the latter resets
    // overscroll on relayout, dropping the refresh hold.
    return CustomScrollView(
      controller: controller.scrollController,
      physics: PullRefreshPhysics(controller: controller),
      slivers: [SliverToBoxAdapter(child: child)],
    );
  }
}
