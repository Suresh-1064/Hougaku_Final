import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../home/home_screen.dart';

class SplashScreen extends GetView {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
          splash:
              Lottie.asset('assets/animations/splash_screen_animation.json'),
          splashIconSize: 300,
          backgroundColor: Colors.transparent,
          disableNavigation: false,
          nextScreen: HomeScreen()),
    );
  }
}
