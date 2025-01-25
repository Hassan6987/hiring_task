import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hiring_task/resources/app_images.dart';

import '../resources/app_vectors.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5),(){
      context.pushNamed('/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get screen height and width for responsiveness
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Center logo
            Center(
              child: Image.asset(
                    AppImages.logo, // Add your logo here
                    height: screenHeight * 0.2,// 20% of screen height
                    width: screenWidth *0.8, // 80% of screen width
                    fit: BoxFit.contain,
                  ),
            ),
            // Loading animation at the bottom
            Positioned(
              bottom: screenHeight * 0.1, // 10% above bottom
              left: 0,
              right: 0,
              child: Center(
                child: SvgPicture.asset(
                  AppVectors.loading, // Add your SVG asset here
                  // Adjust size as needed
                  height: screenHeight * 0.08,
                  width: screenHeight * 0.08,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

