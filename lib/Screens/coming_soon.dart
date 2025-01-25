import 'package:flutter/material.dart';

import '../Model/User.dart';
import '../resources/app_colors.dart';
import '../resources/app_images.dart';
import '../resources/app_strings.dart';
import '../resources/dimensions_resource.dart';
class ComingSoon extends StatelessWidget {
  final User user;
  const ComingSoon({super.key, required this.user});

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5E7),
      body: Center(
        child: SizedBox(
            height: screenHeight * 0.4,
            width: screenWidth * 0.8,
            child: Image.asset(AppImages.noData),
          )
      )
    );
  }
}
