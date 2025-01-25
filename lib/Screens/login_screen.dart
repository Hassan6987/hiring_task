import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hiring_task/resources/app_colors.dart';


import '../BusinessLogic/Auth/auth_bloc.dart';
import '../resources/app_images.dart';
import '../resources/app_strings.dart';
import '../resources/dimensions_resource.dart';
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});


  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  _login(BuildContext context) async {
    if (_emailController.text == AppStrings.dummyEmail &&
        _passwordController.text == AppStrings.dummyPassword) {
      context.read<AuthBloc>().add(LoginRequested());

      // Listen for state changes and navigate after fetching the user
      final authBloc = context.read<AuthBloc>();
      authBloc.stream.listen((state) {
        if (!state.isLoading && state.user != null) {
          GoRouter.of(context).go('/home', extra: state.user);
        } else if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error ?? 'An error occurred')),
          );
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.invalidCredentials)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(backgroundColor: AppColors.backgroundColor,),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo and Title
                  SizedBox(height: screenHeight * 0.01),
                  Image.asset(
                    AppImages.logo, // Add your logo asset path
                    height: screenHeight * 0.13,
                    width: screenHeight * 0.8,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    AppStrings.welcomeBack,
                    style: TextStyle(
                      fontSize: screenWidth * 0.08,
                      fontFamily: AppStrings.urbanistMedium,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),

                  // Email TextField
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email, color: AppColors.secondary),
                      hintText: AppStrings.email,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dim.D_12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: AppColors.textField,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.fieldEmpty;
                      } else if (!EmailValidator.validate(value)) {
                        return AppStrings.invalidEmail;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Password TextField
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return TextFormField(
                        controller: _passwordController,
                        obscureText: state.obscureText,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock, color: AppColors.secondary),
                          suffixIcon: IconButton(
                            icon: Icon(state.obscureText ? Icons.visibility_off : Icons.visibility,color: AppColors.secondary,),
                            onPressed: () {
                              context.read<AuthBloc>().add(ToggleObscure());
                            },
                          ),
                          hintText: AppStrings.password,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dim.D_12),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: AppColors.textField,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.fieldEmpty;
                          }
                          return null;
                          },
                      );
                      },
                  ),
                  SizedBox(height: screenHeight * 0.01),

                  // Checkbox (Remember Me)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return Checkbox(
                            value: state.checkBox,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dim.D_6)),
                            onChanged: (bool? value) {
                              context.read<AuthBloc>().add(ToggleCheck());
                            },
                            activeColor:AppColors.primary,
                            side: const BorderSide(
                              color: AppColors.primary,
                              width: Dim.D_2,
                            ),
                      );
                          },
                      ),
                      const Text(AppStrings.rememberMe,style: TextStyle(
                        fontFamily: AppStrings.urbanistSemiBold,
                        fontSize: Dim.FONT_SIZE_SMALL
                      ),),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.01),

                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    height: screenHeight * 0.055,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          _login(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Dim.D_12),
                        ),
                      ),
                      child: Text(
                        AppStrings.login,
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontFamily: AppStrings.urbanistBold,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Forgot Password
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      AppStrings.forgetPassword,
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: screenWidth * 0.04,
                        fontFamily: AppStrings.urbanistSemiBold,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  // Divider with Text
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          thickness: 1.0,
                          color: AppColors.greyTextBold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dim.PADDING_SIZE_SMALL),
                        child: Text(
                          AppStrings.continueWith,
                          style: TextStyle(
                            color: AppColors.greyTextBold,
                            fontSize: screenWidth * 0.035,
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Divider(
                          thickness: 1.0,
                          color: AppColors.greyTextBold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Social Media Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Facebook Button
                      Container(
                        width: screenWidth * 0.25,
                        height: screenHeight * 0.06,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(Dim.RADIUS_DEFAULT)),
                          color: AppColors.white,
                        ),
                        child: Center(
                          child: Image.asset(AppImages.facebookIcon),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.05),

                      // Google Button
                      Container(
                        width: screenWidth * 0.25,
                        height: screenHeight * 0.06,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(Dim.RADIUS_DEFAULT)),
                          color: AppColors.white,
                        ),
                        child: Center(child: Image.asset(AppImages.googleIcon))
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.05),

                  // Signup Text line
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [


                      Text(AppStrings.signupDialogue,style: TextStyle(color: AppColors.greyTextBold,fontFamily: AppStrings.urbanistMedium,fontSize: screenWidth * 0.04,),),
                      GestureDetector(
                        onTap: (){

                          context.pushNamed('signUp');

                        },
                          child: Text(AppStrings.signUp,style: TextStyle(color: AppColors.primary,fontFamily: AppStrings.urbanistBold,fontSize: screenWidth * 0.04,),),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
