import 'dart:math' as math;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pull_refresh/enums/home_menu.dart';
import 'package:pull_refresh/home/widgets/home_menu_widget.dart';
import 'package:pull_refresh/home/widgets/sliver_clip.dart';

class HomeContent2 extends StatefulWidget {
  const HomeContent2({super.key});

  @override
  State<HomeContent2> createState() => _HomeContent2State();
}

class _HomeContent2State extends State<HomeContent2> {
  final List<String> _bannerList = [
    'assets/images/banner_one.png',
    'assets/images/banner_two.png',
    'assets/images/banner_three.png',
  ];

  List<HomeMenu> homeMenuList = [
    HomeMenu.sendMoney,
    HomeMenu.topUp,
    HomeMenu.cashOut,
    HomeMenu.payment,

    HomeMenu.addMoney,
    HomeMenu.payBill,
    HomeMenu.tickets,
    HomeMenu.more,
  ];

  List<HomeMenu> mybKashList = [
    HomeMenu.topUp,
    HomeMenu.shwapno,
    HomeMenu.internet,
    HomeMenu.card,
    HomeMenu.account,
  ];

  List<HomeMenu> suggestionList = [
    HomeMenu.btcl,
    HomeMenu.akash,
    HomeMenu.ajkelDeal,
    HomeMenu.daraz,
    HomeMenu.styline,
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: CustomScrollPhysics(),
      slivers: [
        SliverClip(
          child: SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 4,
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    children: List.generate(homeMenuList.length, (index) {
                      return Center(
                        child: MenuWidget(
                          title: homeMenuList[index].title,
                          image: homeMenuList[index].icon,
                        ),
                      );
                    }),
                  ),
                  _buildImageSlider(),
                  ...List.generate(50, (index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Widget $index'),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageSlider() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 120.0,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        disableCenter: true,
        viewportFraction: 1,
        enlargeCenterPage: true,
      ),
      items: _bannerList.map((i) {
        return Image.asset(i, height: 120, fit: BoxFit.cover);
      }).toList(),
    );
  }
}

class CustomScrollPhysics extends ScrollPhysics {
  const CustomScrollPhysics({this.decelerationRate = ScrollDecelerationRate.normal, super.parent});

  final ScrollDecelerationRate decelerationRate;

  @override
  CustomScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomScrollPhysics(parent: buildParent(ancestor), decelerationRate: decelerationRate);
  }

  // ──────────────────────────────
  // Reduce bottom bounce significantly
  // ──────────────────────────────
  double frictionFactor(double overscrollFraction) {
    return 0.01; // flat ultra-low resistance
  }

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    if (!position.outOfRange) return offset;

    final double overscrollPastStart = math.max(position.minScrollExtent - position.pixels, 0.0);
    final double overscrollPastEnd = math.max(position.pixels - position.maxScrollExtent, 0.0);

    // TOP: completely disable bounce
    if (overscrollPastStart > 0.0 && offset < 0.0) {
      return 0.0; // hard stop at top
    }

    // BOTTOM: allow bounce, but heavily reduced via friction
    final double overscrollPast = math.max(overscrollPastStart, overscrollPastEnd);
    final bool easing = (overscrollPastEnd > 0.0 && offset > 0.0);

    final double fraction = overscrollPast / position.viewportDimension;
    final double friction = easing
        ? frictionFactor((overscrollPast - offset.abs()) / position.viewportDimension)
        : frictionFactor(fraction);

    final double direction = offset.sign;
    return direction * _applyFriction(overscrollPast, offset.abs(), friction);
  }

  // Keep top clamped, bottom allowed to go outOfRange (so bounce works)
  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    if (value < position.minScrollExtent) {
      return value - position.minScrollExtent; // hard clamp top
    }
    return 0.0; // bottom can overscroll → bounce allowed
  }

  // Keep original iOS BouncingScrollSimulation (full glow + snap)
  @override
  Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
    final tolerance = toleranceFor(position);
    if (velocity.abs() >= tolerance.velocity || position.outOfRange) {
      return BouncingScrollSimulation(
        spring: spring,
        position: position.pixels,
        velocity: velocity,
        leadingExtent: position.minScrollExtent,
        trailingExtent: position.maxScrollExtent,
        tolerance: tolerance,
        constantDeceleration: 0,
      );
    }
    return null;
  }

  static double _applyFriction(double extentOutside, double absDelta, double gamma) {
    double total = 0.0;
    if (extentOutside > 0 && gamma > 0) {
      final double deltaToLimit = extentOutside / gamma;
      if (absDelta < deltaToLimit) {
        return absDelta * gamma;
      }
      total += extentOutside;
      absDelta -= deltaToLimit;
    }
    return total + absDelta;
  }

  // Keep all your nice iOS enhancements
  @override
  double get minFlingVelocity => kMinFlingVelocity;

  @override
  double get dragStartDistanceMotionThreshold => 3.5;

  @override
  double carriedMomentum(double existingVelocity) {
    return existingVelocity.sign *
        math.min(0.000816 * math.pow(existingVelocity.abs(), 1.967), 40000.0);
  }

  @override
  double get maxFlingVelocity => decelerationRate == ScrollDecelerationRate.fast
      ? kMaxFlingVelocity * 8.0
      : super.maxFlingVelocity;

  @override
  SpringDescription get spring => switch (decelerationRate) {
    ScrollDecelerationRate.fast => SpringDescription.withDampingRatio(
      mass: 1.0,
      stiffness: 180,
      ratio: 1.3,
    ),
    ScrollDecelerationRate.normal => SpringDescription.withDampingRatio(
      mass: 1.0,
      stiffness: 220,
      ratio: 1.4,
    ),
  };
}