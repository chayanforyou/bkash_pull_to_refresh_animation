import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final String image;

  const CardWidget({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20.w,
      child: Column(
        children: [
          SizedBox(height: 8.h, child: Image.asset(image)),
          const SizedBox(height: 5.0),
          Text(
            title,
            style: TextStyle(fontSize: 14.5.sp, wordSpacing: 0.5, color: Colors.black),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
