import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:pull_refresh/enums/home_menu.dart';
import 'package:pull_refresh/helpers/bottom_clamp_scroll_physics.dart';
import 'package:pull_refresh/helpers/linear_scroll_physics.dart';
import 'package:pull_refresh/helpers/sliver_clip.dart';
import 'package:pull_refresh/home/widgets/card_widget.dart';
import 'package:pull_refresh/home/widgets/home_menu_widget.dart';
import 'package:pull_refresh/home/widgets/skeleton_item.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
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
    HomeMenu.ajkelDeal,
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
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 12,
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
                    EasyRefresh(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CarouselSlider(
                          options: CarouselOptions(
                            height: 120.0,
                            autoPlay: true,
                            disableCenter: true,
                            viewportFraction: 1,
                          ),
                          items: _bannerList.map((index) {
                            return Image.asset(
                              index,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Expanded(child: Text('Suggestions')),
                          InkWell(child: Text('See All'), onTap: () {}),
                        ],
                      ),
                    ),
                    EasyRefresh(
                      child: SizedBox(
                        height: 80,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: LinearScrollPhysics(),
                          itemCount: suggestionList.length,
                          itemBuilder: (context, index) {
                            return CardWidget(
                              title: suggestionList[index].title,
                              image: suggestionList[index].icon,
                            );
                          },
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: 3,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return SkeletonItem();
                      },
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
}
