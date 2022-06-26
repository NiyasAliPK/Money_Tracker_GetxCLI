import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:money_tracker_get_cli/app/modules/navigation/views/navigation_view.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    _navigateToHome();
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFF6DD5ED), Color(0xFF2193B0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SafeArea(
              child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText('MONEY TRACKER',
                      textStyle: const TextStyle(
                          fontFamily: 'ZenDots',
                          fontSize: 30,
                          color: Color.fromARGB(255, 255, 255, 255)),
                      speed: const Duration(milliseconds: 70)),
                ],
                isRepeatingAnimation: true,
              ),
              const SizedBox(
                height: 70,
              ),
              const Image(image: AssetImage('assets/images/MoneyManager.png')),
              const SizedBox(
                height: 40,
              ),
              Lottie.asset(
                  'assets/animations/99281-beezpay-loading-animation.json',
                  height: 150,
                  width: 150)
            ],
          )),
        ),
      ),
    );
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 3500));
    Get.offAll(() => NavigationView());
  }
}
