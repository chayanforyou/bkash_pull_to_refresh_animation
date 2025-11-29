import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pull_refresh/enums/home_menu.dart';
import 'package:pull_refresh/home/widgets/home_menu_widget.dart';
import 'package:pull_refresh/home/widgets/sliver_clip.dart';

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
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      decoration: BoxDecoration(
          color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )
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
        return  Image.asset(i, height: 120, fit: BoxFit.cover);
      }).toList(),
    );
  }
}
