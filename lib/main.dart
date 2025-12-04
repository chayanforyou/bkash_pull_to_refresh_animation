import 'package:flutter/material.dart';
import 'package:pull_refresh/home/home_page.dart';
import 'package:sizer/sizer.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          darkTheme: ThemeData.dark(useMaterial3: true),
          home: const HomePage(),
        );
      },
    );
  }
}