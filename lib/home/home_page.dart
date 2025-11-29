import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pull_refresh/home/widgets/home_content_2.dart';

import 'pull_refresh/sunrise_indicator.dart';
import 'widgets/home_content.dart';
import 'widgets/home_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomRefreshIndicator(
          offsetToArmed: 200.0,
          trailingScrollIndicatorVisible: false,
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 4));
          },
          durations: const RefreshIndicatorDurations(
            settleDuration: Duration.zero,
            finalizeDuration: Duration(milliseconds: 800),
          ),
          builder: (BuildContext context, Widget child, IndicatorController controller) {
            print(controller.value);
            return Stack(
              children: [
                SunriseIndicator(controller: controller),
                Transform.translate(offset: Offset(0.0, controller.value * 25), child: child),
                HomeHeader(),
              ],
            );
          },
          child: Padding(
            padding: EdgeInsets.only(top: MediaQuery.sizeOf(context).height * 0.23),
            child: HomeContent2(),
          ),
        ),
      ),
    );
  }
}
