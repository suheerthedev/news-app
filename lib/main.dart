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
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          brightness: Brightness.light,
          fontFamily: 'Montserrat',
          textTheme: const TextTheme(
              titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          appBarTheme:
              AppBarTheme(color: AppColors.primaryColor, centerTitle: true)),
      home: const HomePage(title: 'News App'),
    );
  }
}
