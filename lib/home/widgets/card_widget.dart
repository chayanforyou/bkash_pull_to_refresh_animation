import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final String image;

  const CardWidget({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      height: 80,
      child: Column(
        children: [
          SizedBox(height: 50, child: Image.asset(image)),
          const SizedBox(height: 5.0),
          Text(
            title,
            style: const TextStyle(fontSize: 12, color: Colors.black),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
