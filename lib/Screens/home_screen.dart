import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hiring_task/Screens/coming_soon.dart';
import 'package:hiring_task/Screens/home_page.dart';
import 'package:hiring_task/Screens/profile_page.dart';
import 'package:hiring_task/resources/app_vectors.dart';
import '../BusinessLogic/home bloc/home_bloc.dart';
import '../Model/User.dart';
import '../resources/app_colors.dart';
import '../resources/app_strings.dart';
import '../resources/dimensions_resource.dart';

class HomeScreen extends StatelessWidget {
  final User user;

  const HomeScreen({super.key, required this.user});

  List<Widget> get _widgetOptions => <Widget>[
    HomePage(user: user),
    ComingSoon(user: user),
    ComingSoon(user: user),
    ProfilePage(user: user),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return _widgetOptions.elementAt(state.selectedIndex);
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return BottomNavigationBar(
            backgroundColor: AppColors.secondary,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppVectors.homeIcon,
                  width: Dim.D_20,
                  height: Dim.D_20,
                  colorFilter: ColorFilter.mode(
                    state.selectedIndex == 0
                        ? AppColors.primary
                        : AppColors.grey,
                    BlendMode.srcIn,
                  ),
                ),
                label: AppStrings.home,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppVectors.jobsIcon,
                  width: Dim.D_20,
                  height: Dim.D_20,
                  colorFilter: ColorFilter.mode(
                    state.selectedIndex == 1
                        ? AppColors.primary
                        : AppColors.grey,
                    BlendMode.srcIn,
                  ),
                ),
                label: AppStrings.jobs,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppVectors.earningsIcon,
                  width: Dim.D_20,
                  height: Dim.D_20,
                  colorFilter: ColorFilter.mode(
                    state.selectedIndex == 2
                        ? AppColors.primary
                        : AppColors.grey,
                    BlendMode.srcIn,
                  ),
                ),
                label: AppStrings.earnings,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppVectors.profileIcon,
                  width: Dim.D_20,
                  height: Dim.D_20,
                  colorFilter: ColorFilter.mode(
                    state.selectedIndex == 3
                        ? AppColors.primary
                        : AppColors.grey,
                    BlendMode.srcIn,
                  ),
                ),
                label: AppStrings.profile,
              ),
            ],
            currentIndex: state.selectedIndex,
            unselectedItemColor: AppColors.grey,
            selectedItemColor: AppColors.primary,
            iconSize: 36.0,
            elevation: 0.0,
            onTap: (index) {
              context.read<HomeBloc>().add(ItemTapped(index));
            },
          );
        },
      ),
    );
  }
}
