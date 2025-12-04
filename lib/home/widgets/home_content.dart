import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:pull_refresh/enums/home_menu.dart';
import 'package:pull_refresh/helpers/bottom_clamp_scroll_physics.dart';
import 'package:pull_refresh/helpers/linear_scroll_physics.dart';
import 'package:pull_refresh/helpers/sliver_clip.dart';
import 'package:pull_refresh/home/widgets/menu_widget.dart';
import 'package:pull_refresh/home/widgets/quick_feature_widget.dart';
import 'package:sizer/sizer.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  bool _expanded = false;

  double get _boxHeight => _expanded ? 1000 : 800;

  double get _topPosition => _expanded ? 480 : 280;

  final List<String> _bannerList = [
    'assets/images/banner_one.png',
    'assets/images/banner_two.png',
    'assets/images/banner_three.png',
  ];

  List<HomeMenu> homeMenuList = [
    HomeMenu.sendMoney,
    HomeMenu.mobileRecharge,
    HomeMenu.cashOut,
    HomeMenu.makePayment,

    HomeMenu.addMoney,
    HomeMenu.payBill,
    HomeMenu.savings,
    HomeMenu.loan,

    HomeMenu.tickets,
    HomeMenu.bkashToBank,
    HomeMenu.educationFee,
    HomeMenu.microfinance,

    HomeMenu.toll,
    HomeMenu.requestMoney,
    HomeMenu.remittance,
    HomeMenu.donation,
  ];

  List<HomeMenu> quickFeatureList = [HomeMenu.myOffers, HomeMenu.coupons, HomeMenu.rewards];

  List<HomeMenu> suggestionList = [
    HomeMenu.btcl,
    HomeMenu.akash,
    HomeMenu.ajkelDeal,
    HomeMenu.daraz,
    HomeMenu.styline,
    HomeMenu.metlife,
    HomeMenu.btcl,
    HomeMenu.daraz,
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomScrollView(
        physics: BottomClampScrollPhysics(),
        slivers: [
          SliverClip(
            child: SliverToBoxAdapter(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 400),
                color: Colors.white,
                curve: Curves.easeInOut,
                height: _boxHeight,
                child: Stack(
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 20),
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: homeMenuList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 0.9,
                      ),
                      itemBuilder: (_, index) {
                        return MenuWidget(
                          title: homeMenuList[index].title,
                          image: homeMenuList[index].icon,
                        );
                      },
                    ),

                    AnimatedPositioned(
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                      top: _topPosition - 30,
                      left: 0,
                      right: 0,
                      child: Opacity(
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
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                      top: _topPosition,
                      left: 0,
                      right: 0,
                      child: _buildScrollableSection(),
                    ),
                  ],
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
      onTap: () {
        setState(() => _expanded = !_expanded);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Color(0xFFECECEC)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _expanded ? 'Close' : 'See more',
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500, color: Colors.pink),
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

  Widget _buildScrollableSection() {
    return ColoredBox(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Show more button
          Align(alignment: Alignment.center, child: _buildMoreButton()),

          // Banner
          EasyRefresh(
            child: Padding(
              padding: const EdgeInsets.all(10).add(EdgeInsets.only(top: 10)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CarouselSlider(
                  options: CarouselOptions(height: 120.0, autoPlay: true, viewportFraction: 1),
                  items: _bannerList.map((index) {
                    return Image.asset(index, fit: BoxFit.cover);
                  }).toList(),
                ),
              ),
            ),
          ),

          // Quick Features
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'Quick Features',
              style: TextStyle(fontSize: 16.sp, color: Colors.black),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 10),
            itemCount: quickFeatureList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.2,
              crossAxisSpacing: 10.0,
            ),
            itemBuilder: (_, index) {
              return QuickFeatureWidget(
                title: quickFeatureList[index].title,
                image: quickFeatureList[index].icon,
                color: quickFeatureList[index].color,
              );
            },
          ),

          // Suggestion Title
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Suggestions",
                    style: TextStyle(fontSize: 16.sp, color: Colors.black),
                  ),
                ),
                Text(
                  "See All",
                  style: TextStyle(fontSize: 16.sp, color: Colors.pink),
                ),
              ],
            ),
          ),
          EasyRefresh(
            child: Container(
              height: 12.h,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: suggestionList.length,
                physics: LinearScrollPhysics(),
                itemBuilder: (_, index) {
                  return MenuWidget(
                    title: suggestionList[index].title,
                    image: suggestionList[index].icon,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
