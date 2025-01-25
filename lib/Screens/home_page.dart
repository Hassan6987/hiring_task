import 'package:flutter/material.dart';
import 'package:hiring_task/resources/app_colors.dart';
import 'package:hiring_task/resources/app_strings.dart';
import 'package:hiring_task/resources/dimensions_resource.dart';

import '../Model/User.dart';
import '../resources/app_images.dart';
class HomePage extends StatelessWidget {
  final User user;
  const HomePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Red background
            Container(
              height: screenHeight * 0.43,
              padding: const EdgeInsets.symmetric(horizontal: Dim.PADDING_SIZE_DEFAULT, vertical: Dim.PADDING_SIZE_EXTRA_LARGE),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dim.RADIUS_DEFAULT),
                color: AppColors.red
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.02,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Hello! ',
                              style: TextStyle(
                                fontFamily: AppStrings.urbanistBold,
                                color: AppColors.white,
                                fontSize: Dim.FONT_SIZE_LARGE,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${user.data.firstName} ${user.data.lastName} ',
                              style: const TextStyle(
                                fontFamily: AppStrings.urbanistBold,
                                color: AppColors.white,
                                fontSize: Dim.FONT_SIZE_4X_EXTRA_MEDIUM,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Align(
                        alignment: Alignment.topRight,
                        child: CircleAvatar(
                          foregroundImage: AssetImage(AppImages.avatar3),
                          radius: Dim.RADIUS_EXTRA_LARGE,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Stack(
                    children: [
                      Image.asset(AppImages.rectangle5978),
                      Positioned(
                        bottom: Dim.D_0,
                        left: Dim.D_0,
                        child: Image.asset(AppImages.vector660),
                      ),
                      Positioned(
                        bottom: Dim.D_10,
                        right: Dim.D_16,
                        child: Image.asset(AppImages.treasureIcon),
                      ),
                      Positioned(
                        top: Dim.D_16,
                        left: Dim.D_25,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              AppStrings.myEarnings,
                              style: TextStyle(
                                color: AppColors.black,
                                fontFamily: AppStrings.urbanistBold,
                                fontSize: Dim.FONT_SIZE_4X_EXTRA_MEDIUM,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '\$${user.data.earnings}',
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontFamily: AppStrings.urbanistBold,
                                fontSize: Dim.FONT_SIZE_4X_EXTRA_LARGE,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: Dim.D_12,
                        left: Dim.D_16,
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle details action
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD6EBFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(Dim.RADIUS_DEFAULT),
                            ),
                          ),
                          child: const Text(AppStrings.details),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.01,),
            // Friends avatars
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
              child: Wrap(
                spacing: 50,
                alignment: WrapAlignment.center,
                children: List.generate(7, (index) {
                  return CircleAvatar(
                    radius: index <= 3 ? 20 : 25,
                    foregroundImage: AssetImage(AppImages.listOFAvatars[index],),
                    backgroundColor: Colors.red,
                    child: const Icon(Icons.person, color: Colors.grey),
                  );
                }),
              ),
            ),
            SizedBox(height: screenHeight * 0.01,),
            // Invite text
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
              child: const Text(
                AppStrings.inviteFriendsLine,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Dim.FONT_SIZE_2X_EXTRA_LARGE,
                  fontFamily: AppStrings.urbanistBold,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.01,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
              child: const Text(
                AppStrings.inviteFriendsLine2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: AppStrings.urbanistMedium,
                  fontSize: Dim.FONT_SIZE_SMALL,
                  color: AppColors.black,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.01,),
            // Copy referral link button
            SizedBox(
              width: screenWidth * 0.7,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Action for copying referral link
                },
                icon: const Icon(Icons.library_books_outlined, color: AppColors.white),
                label: const Text(AppStrings.copyReferralLink,style: TextStyle(fontSize: Dim.FONT_SIZE_MEDIUM,fontFamily: AppStrings.urbanistBold),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.red,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(horizontal: Dim.D_20, vertical: Dim.D_12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dim.RADIUS_DEFAULT),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.01,),
            const Text(AppStrings.sendTo, style: TextStyle(fontFamily: AppStrings.urbanistBold, fontSize: Dim.FONT_SIZE_1X_EXTRA_MEDIUM,fontWeight: FontWeight.bold),),
            SizedBox(height: screenHeight * 0.01,),
            // Send referral link button
            SizedBox(
              width: screenWidth * 0.7,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Action for sending referral link
                },
                icon: const Icon(Icons.send),
                label: const Text(AppStrings.sendReferralLink,style: TextStyle(fontSize: Dim.FONT_SIZE_MEDIUM,fontFamily: AppStrings.urbanistBold),),
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColors.red,
                  backgroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: AppColors.red) ,
                    borderRadius: BorderRadius.circular(Dim.RADIUS_DEFAULT),
                  ),
                ),
              ),
            ),



          ],
        ),
      ),
    );
  }
}






