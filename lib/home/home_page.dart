import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'pull_refresh/sunrise_header.dart';
import 'widgets/home_content.dart';
import 'widgets/home_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late EasyRefreshController _controller;

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController(
        controlFinishRefresh: true,
        controlFinishLoad: true
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.pink,
        systemNavigationBarDividerColor: Colors.pink,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: EasyRefresh(
          controller: _controller,
          header: const SunriseHeader(
            position: IndicatorPosition.behind,
            maxOverOffset: 32.0,
            safeArea: false,
          ),
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 3));
            if (!mounted) return;

            _controller.finishRefresh();
          },
          child: Column(
            children: [
              HomeHeader(),
              HomeContent(),
            ],
          ),
        ),
      ),
    );
  }
}