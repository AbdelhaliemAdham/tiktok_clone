import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/views/screens/home_screan.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 6000));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.white,
        body: InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      ),
      child: Center(
        child: Container(
          height: 700,
          width: 650,
          child: Lottie.asset(
            'assets/tiktok.json',
            controller: _controller,
            errorBuilder: ((context, error, stackTrace) {
              return LottieBuilder.asset('assets/no_internet.json');
            }),
            alignment: Alignment.center,
            onLoaded: (composition) {
              // Configure the AnimationController with the duration of the
              // Lottie file and start the animation.

              _controller.duration = composition.duration;
            },
          ),
        ),
      ),
    ));
  }
}
