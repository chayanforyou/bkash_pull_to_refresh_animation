import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SliverClip extends SingleChildRenderObjectWidget {
  const SliverClip({super.key, required Widget super.child});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderSliverClip();
  }
}

class _RenderSliverClip extends RenderProxySliver {
  Rect? _clipRect;

  Rect _calculateClipRect() {
    return Rect.fromLTWH(
      0,
      geometry!.paintOrigin,
      constraints.crossAxisExtent,
      geometry!.paintExtent,
    );
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child == null) return;

    _clipRect = _calculateClipRect();

    layer = context.pushClipRRect(
      needsCompositing,
      offset,
      _clipRect!,
      RRect.fromRectAndCorners(
        _clipRect!,
        topLeft: const Radius.circular(20),
        topRight: const Radius.circular(20),
      ),
      super.paint,
      oldLayer: layer as ClipRRectLayer?,
    );
  }
}