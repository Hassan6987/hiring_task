import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hiring_task/resources/app_colors.dart';
import 'package:hiring_task/resources/app_strings.dart';
import 'package:hiring_task/resources/dimensions_resource.dart';

import '../Model/User.dart';
import '../resources/app_images.dart';
import '../resources/app_vectors.dart';

class ProfilePage extends StatelessWidget {
  final User user;
  const ProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
          AppStrings.myProfile,
          style: TextStyle(
            color: AppColors.black,
            fontFamily: AppStrings.urbanistBold,
            fontSize: Dim.FONT_SIZE_3X_EXTRA_MEDIUM,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: AppColors.black),
            onPressed: () {},
          ),
        ],
        backgroundColor: AppColors.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.02),
            // Profile Picture and Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dim.D_35),
              child: Stack(
                children: [
                  Image.asset(AppImages.redDots),
                  Positioned(
                    top: Dim.D_16,
                    left: Dim.D_100,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: Dim.D_50,
                          backgroundImage: NetworkImage(user.data.avatar), // Replace with your asset path
                        ),
                        Positioned(
                            bottom: -3,
                            right: -1,
                            child: Image.asset(AppImages.editSquare)
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '${user.data.firstName} ${user.data.lastName}',
              style: const TextStyle(
                fontFamily: AppStrings.urbanistBold,
                fontSize: Dim.FONT_SIZE_LARGE,
              ),
            ),
            Text(
              user.data.email,
              style: const TextStyle(
                fontFamily: AppStrings.urbanistMedium,
                fontSize: Dim.FONT_SIZE_SMALL,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            // Earnings and Ratings
           Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ProfileCard(title: AppStrings.earnings, value: '\$${user.data.earnings}'),
                ProfileCard(
                  title: AppStrings.ratings,
                  value: '⭐ ${user.data.ratings}',
                  isRating: true,
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            // About Me Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    AppStrings.aboutMe,
                    style: TextStyle(
                      fontFamily: AppStrings.urbanistFont,
                      fontSize: Dim.FONT_SIZE_2X_EXTRA_MEDIUM,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  RichText(text: TextSpan(
                    children: [
                      TextSpan(
                        text: user.data.bio,
                        style: const TextStyle(
                          fontFamily: AppStrings.urbanistMedium,
                          fontSize: Dim.FONT_SIZE_SMALL,
                          color: Color(0xFF424242),
                        ),
                      ),
                      const TextSpan(
                        text: AppStrings.viewMore,
                        style: TextStyle(
                          fontFamily: AppStrings.urbanistBold,
                          fontSize: Dim.FONT_SIZE_SMALL,
                          color: AppColors.red,
                        ),
                      ),
                    ],
                  )),
                  SizedBox(height: screenHeight * 0.02),
                  Divider(height: screenHeight * 0.01),
                  // List Items
                  const ProfileListItem(
                    icon: AppVectors.locationIcon,
                    title: AppStrings.businessLocation,
                  ),
                  Divider(height: screenHeight * 0.01),
                  const ProfileListItem(
                    icon: AppVectors.bookingsIcon,
                    title: AppStrings.bookings,
                  ),
                  Divider(height: screenHeight * 0.01),
                  const ProfileListItem(
                    icon: AppVectors.servicesIcon,
                    title: AppStrings.myServices,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String title;
  final String value;
  final bool isRating;

  const ProfileCard({
    super.key,
    required this.title,
    required this.value,
    this.isRating = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.42,
      padding: const EdgeInsets.all(Dim.PADDING_SIZE_LARGE),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(Dim.RADIUS_DEFAULT),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: Dim.D_2,
            blurRadius: Dim.D_5,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: Dim.FONT_SIZE_SMALL,
              fontFamily: AppStrings.urbanistSemiBold,
              color: Color(0xFF757575),
            ),
          ),

          Text(
            value,
            style: TextStyle(
              fontSize: Dim.FONT_SIZE_1X_EXTRA_MEDIUM,
              fontFamily: AppStrings.urbanistBold,
              color: isRating ? Colors.amber : AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileListItem extends StatelessWidget {
  final String icon;
  final String title;

  const ProfileListItem({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(icon),
      title: Text(
        title,
        style: const TextStyle(fontSize: Dim.FONT_SIZE_1X_EXTRA_MEDIUM,fontFamily: AppStrings.urbanistSemiBold, fontWeight: FontWeight.w500),
      ),
      trailing: SvgPicture.asset(AppVectors.arrowRight),
      onTap: () {},
    );
  }
}

