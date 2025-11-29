import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  final String title;
  final String image;

  const MenuWidget({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(image, scale: 2.0),
        SizedBox(height: 5.0),
        Text(
          title,
          style: const TextStyle(fontSize: 12, color: Colors.black),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
