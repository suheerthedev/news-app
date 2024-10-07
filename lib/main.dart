import 'package:flutter/material.dart';
import 'package:news_app/screens/home_page_screen.dart';
import 'package:news_app/screens/splash_screen.dart';
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
        primaryColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        
          brightness: Brightness.light,
          fontFamily: 'Montserrat',
          textTheme: const TextTheme(
              titleSmall: TextStyle(color: Colors.black,fontSize: 18, fontWeight: FontWeight.bold)),
          appBarTheme:
              AppBarTheme(color: AppColors.primaryColor, centerTitle: true)),
      home: const SplashScreen(),
      routes: {
        '/homescreen' : (context) => const HomePage(),
        'splashscreen' : (context) => const SplashScreen()
      }, 
    );
  }
}
