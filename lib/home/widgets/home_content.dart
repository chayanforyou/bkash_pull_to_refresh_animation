import 'package:flutter/material.dart';

import 'skeleton_item.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomScrollView(
        slivers: [
          DecoratedSliver(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            sliver: SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return const SkeletonItem();
                }, childCount: 50),
              ),
              // sliver: SliverGrid(
              //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //     crossAxisCount: 4,
              //     mainAxisSpacing: 8,
              //     crossAxisSpacing: 8,
              //     childAspectRatio: 1,
              //   ),
              //   delegate: SliverChildBuilderDelegate((context, index) {
              //     return const SkeletonItem();
              //   }, childCount: 10),
              // ),
            ),
          ),
        ],
      ),
    );
  }
}

