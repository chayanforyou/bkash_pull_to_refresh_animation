import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class QuickFeatureWidget extends StatelessWidget {
  final String title;
  final String image;
  final Color? color;

  const QuickFeatureWidget({super.key, required this.title, required this.image, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Color(0xFFECECEC)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(image, height: 26),
          SizedBox(height: 20.0),
          Text(
            title,
            style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.w500),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
