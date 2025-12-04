import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MenuWidget extends StatelessWidget {
  final String title;
  final String image;

  const MenuWidget({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(image, height: 55),
        const SizedBox(height: 5.0),
        Text(
          title,
          style: TextStyle(fontSize: 14.5.sp, wordSpacing: 0.5, color: Colors.black),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}