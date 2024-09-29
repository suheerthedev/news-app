import 'package:flutter/material.dart';
import 'package:news_app/screens/home_page_screen.dart';
import 'package:news_app/utils/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
          fontFamily: 'Montserrat',
          appBarTheme: AppBarTheme(color: AppColors.primaryColor)),
      home: const HomePage(title: 'News App'),
    );
  }
}
