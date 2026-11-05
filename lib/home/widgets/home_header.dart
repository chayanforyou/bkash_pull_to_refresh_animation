import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  static const _animDuration = Duration(milliseconds: 800);

  bool _showBalance = false;
  bool _animating = false;

  Future<void> _handleTap() async {
    if (_animating) return;
    setState(() {
      _animating = true;
      _showBalance = true;
    });
    await Future.delayed(const Duration(milliseconds: 3800));
    if (!mounted) return;
    setState(() => _showBalance = false);
    await Future.delayed(_animDuration);
    if (mounted) _animating = false;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 22.h,
      width: 100.w,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(1),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const CircleAvatar(
                radius: 24.0,
                backgroundColor: Colors.grey,
                backgroundImage: AssetImage('assets/images/profile.jpg'),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Chayan Mistry',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                _buildBalanceButton(),
              ],
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
              style: IconButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
            ),
            const SizedBox(width: 10),
            Stack(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Image.asset('assets/images/logo.png', height: 18),
                  style: IconButton.styleFrom(backgroundColor: Colors.white),
                ),
                Positioned(
                  bottom: 3,
                  right: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black12),
                    ),
                    padding: const EdgeInsets.all(3),
                    child: const Icon(Icons.menu, size: 10),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceButton() {
    return InkWell(
      onTap: _handleTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 128,
        height: 28,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.black12),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            _fadeText(
              'Tap for balance',
              visible: !_showBalance,
              padding: const EdgeInsets.only(left: 20),
            ),
            _fadeText(
              '৳ 500.00',
              visible: _showBalance,
              padding: const EdgeInsets.only(right: 20),
            ),
            AnimatedPositioned(
              duration: _animDuration,
              curve: Curves.fastOutSlowIn,
              left: _showBalance ? 102 : 4,
              child: Container(
                height: 20,
                width: 20,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '৳',
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _fadeText(
    String text, {
    required bool visible,
    required EdgeInsets padding,
  }) {
    return AnimatedOpacity(
      duration: _animDuration,
      curve: Curves.easeInOutCubic,
      opacity: visible ? 1 : 0,
      child: Padding(
        padding: padding,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14.5.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
