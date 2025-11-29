import 'package:flutter/material.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _slideAnimation;
  late final Animation<double> _fadeOutTapText;
  late final Animation<double> _fadeInBalance;

  bool _showBalance = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);

    _slideAnimation = Tween<double>(begin: 5, end: 100).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    );

    _fadeOutTapText = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _fadeInBalance = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) {
            _controller.reverse().then((_) {
              if (mounted) setState(() => _showBalance = false);
            });
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (_controller.isAnimating) return;
    setState(() => _showBalance = true);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 0.23;

    return SizedBox(
      height: height,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top: 18, left: 16, right: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 24.0,
              backgroundColor: Colors.grey,
              backgroundImage: AssetImage('assets/images/profile.jpg'),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Chayan Mistry',
                  style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 5),
                InkWell(
                  onTap: _handleTap,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 125,
                    height: 28,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // "Tap for balance" text (fades out)
                        AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            return Opacity(
                              opacity: _fadeOutTapText.value,
                              child: child!,
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              'Tap for balance',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),

                        // Actual balance (fades in)
                        AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            return Opacity(
                              opacity: _fadeInBalance.value,
                              child: child!,
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Text(
                              '৳ 500.00',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),

                        // Sliding ৳ circle
                        AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            return Positioned(
                              left: _showBalance ? _slideAnimation.value : 5,
                              child: child!,
                            );
                          },
                          child: Container(
                            height: 20,
                            width: 20,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.pink,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              '৳',
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            _roundIcon(icon: Icons.search),
            const SizedBox(width: 10),
            _roundIcon(icon: Icons.more_horiz),
          ],
        ),
      ),
    );
  }

  Widget _roundIcon({required IconData icon}) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      padding: const EdgeInsets.all(10),
      child: Icon(icon, size: 22, color: Colors.black87),
    );
  }
}
