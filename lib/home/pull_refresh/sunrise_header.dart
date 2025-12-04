import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/widgets.dart';

import 'sunrise_indicator.dart';

class SunriseHeader extends Header {
  const SunriseHeader({
    super.clamping = false,
    super.triggerOffset = 42,
    super.maxOverOffset,
    super.position = IndicatorPosition.above,
    super.processedDuration = Duration.zero,
    super.springRebound = false,
    super.hapticFeedback = false,
    super.safeArea = false,
    super.spring,
    super.readySpringBuilder,
    super.frictionFactor,
    super.infiniteOffset,
    super.hitOver,
    super.infiniteHitOver,
  });

  @override
  Widget build(BuildContext context, IndicatorState state) {
    return SunriseIndicator(state: state, reverse: state.reverse);
  }
}