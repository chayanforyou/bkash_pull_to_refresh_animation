import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pull_refresh/enums/home_menu.dart';
import 'package:pull_refresh/home/widgets/menu_widget.dart';
import 'package:pull_refresh/home/widgets/quick_feature_widget.dart';
import 'package:sizer/sizer.dart';

import '../../pull_refresh/pull_refresh_controller.dart';
import '../../pull_refresh/pull_refresh_scroll_view.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key, required this.refreshController});

  final PullRefreshController refreshController;

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  static const _topRadius = BorderRadius.vertical(top: Radius.circular(20));
  static const _banners = [
    'assets/images/banner_one.png',
    'assets/images/banner_two.png',
    'assets/images/banner_three.png',
  ];

  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: _topRadius,
      child: PullRefreshScrollView(
        controller: widget.refreshController,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: _topRadius,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMenuGrid(),
              Center(child: _buildMoreButton()),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 120,
                      autoPlay: true,
                      viewportFraction: 1,
                    ),
                    items: _banners
                        .map((p) => Image.asset(p, fit: BoxFit.cover))
                        .toList(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Quick Features',
                  style: TextStyle(fontSize: 16.sp, color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  spacing: 10,
                  children: [
                    for (final item in HomeMenu.quickFeatures)
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1.2,
                          child: QuickFeatureWidget(
                            title: item.title,
                            image: item.icon,
                            color: item.color,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Suggestions',
                      style: TextStyle(fontSize: 16.sp, color: Colors.black),
                    ),
                    Text(
                      'See All',
                      style: TextStyle(fontSize: 16.sp, color: Colors.pink),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12.h,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  itemCount: HomeMenu.suggestions.length,
                  itemBuilder: (_, index) {
                    final item = HomeMenu.suggestions[index];
                    return MenuWidget(title: item.title, image: item.icon);
                  },
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuGrid() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.fastOutSlowIn,
      height: _expanded ? 440 : 280,
      child: Stack(
        children: [
          GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 20),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: HomeMenu.mainMenus.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 0.9,
            ),
            itemBuilder: (_, index) {
              final item = HomeMenu.mainMenus[index];
              return MenuWidget(title: item.title, image: item.icon);
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 400),
              curve: Curves.fastOutSlowIn,
              opacity: _expanded ? 0 : 1,
              child: Container(
                height: 30,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0x80FFFFFF), Color(0xFFFFFFFF)],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoreButton() {
    return InkWell(
      onTap: () => setState(() => _expanded = !_expanded),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.grey.withAlpha(45)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _expanded ? 'Close' : 'See more',
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: Colors.pink,
              ),
            ),
            Icon(
              _expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: Colors.pink,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
