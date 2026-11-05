import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'pull_refresh/pull_refresh_controller.dart';
import 'pull_refresh/pull_refresh_indicator.dart';
import 'widgets/home_content.dart';
import 'widgets/home_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final _refreshController = PullRefreshController(
    triggerOffset: 30.0,
    maxOverOffset: 32.0,
    onRefresh: _onRefresh,
  );

  Future<void> _onRefresh() async {
    // TODO: call API here. Fake delay for now.
    await Future.delayed(const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _refreshController.dispose();
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
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: PullRefreshIndicator(controller: _refreshController),
            ),
            Column(
              children: [
                const HomeHeader(),
                Expanded(
                  child: HomeContent(refreshController: _refreshController),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
