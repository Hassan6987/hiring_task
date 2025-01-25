import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';


import '../BusinessLogic/Auth/auth_bloc.dart';
import '../resources/app_colors.dart';
import '../resources/app_images.dart';
import '../resources/app_strings.dart';
import '../resources/app_vectors.dart';
import '../resources/dimensions_resource.dart';
class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _signup(BuildContext context) async {

    // Dummy data for validation
    if (_passwordController.text == _confirmPasswordController.text) {
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
          const SnackBar(content: Text(AppStrings.passNotMatch)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
          AppStrings.createAccount,
          style: TextStyle(color: AppColors.black,fontFamily: AppStrings.urbanistBold),
        ),
        backgroundColor: AppColors.backgroundColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.02),
              // Tab buttons
              Container(
                
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(Dim.RADIUS_DEFAULT),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Center(
                        child: Text(
                          AppStrings.consumer,
                          style: TextStyle(color: AppColors.primary,fontFamily: AppStrings.urbanistBold,fontSize: Dim.FONT_SIZE_MEDIUM),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: screenHeight * 0.06,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(Dim.RADIUS_DEFAULT),
                        ),
                        child: const Center(
                          child: Text(
                            AppStrings.serviceProvider,
                            style: TextStyle(color: AppColors.white,fontFamily: AppStrings.urbanistSemiBold,),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              // Form fields
              _buildTextField(label: AppStrings.firstName),
              SizedBox(height: screenHeight * 0.01),
              _buildTextField(label:  AppStrings.lastName),
              SizedBox(height: screenHeight * 0.01),
              _buildEmailTextField(label:  AppStrings.email, suffixIcon: AppVectors.email),
              SizedBox(height: screenHeight * 0.01),
              _buildDropdownField(label:  AppStrings.gender, suffixIcon: AppVectors.dropDownMenu),
              SizedBox(height: screenHeight * 0.01),
              _buildPhoneNumberField(context),
              SizedBox(height: screenHeight * 0.01),
              _buildPasswordTextField(label:  AppStrings.password, controller: _passwordController),
              SizedBox(height: screenHeight * 0.01),
              _buildPasswordTextField(label:  AppStrings.confirmPassword, controller: _confirmPasswordController),
              SizedBox(height: screenHeight * 0.02),
              // Terms and conditions
              SizedBox(
                width: double.infinity, // Ensures the text respects the available width
                child: RichText(
                  text: const TextSpan(
                    text: "By continuing you agree to our ",
                    style: TextStyle(fontSize: Dim.FONT_SIZE_MEDIUM, color: AppColors.greyTextBold,fontFamily: AppStrings.urbanistBold),
                    children: [
                      TextSpan(
                        text: "Terms of Service ",
                        style: TextStyle(
                          fontSize: Dim.FONT_SIZE_MEDIUM,
                          color: AppColors.secondary,
                          fontFamily: AppStrings.urbanistBold,
                        ),
                      ),
                      TextSpan(
                        text: " and ",
                        style: TextStyle(
                          fontSize: Dim.FONT_SIZE_MEDIUM,
                          color: AppColors.greyTextBold,
                          fontFamily: AppStrings.urbanistBold,
                        ),
                      ),
                      TextSpan(
                        text: "Privacy Policy",
                        style: TextStyle(
                          fontSize: Dim.FONT_SIZE_MEDIUM,
                          color: AppColors.secondary,
                          fontFamily: AppStrings.urbanistBold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              // Sign Up button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _signup(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: Size(double.infinity, screenHeight * 0.06),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dim.RADIUS_LARGE)),
                ),
                child: const Text(AppStrings.signUp, style: TextStyle(color: AppColors.white)),
              ),
              SizedBox(height: screenHeight * 0.01),
              // Log In option
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                      AppStrings.alreadyHaveAccount,
                      style: TextStyle(
                        fontSize: Dim.FONT_SIZE_SMALL,
                        color: AppColors.greyTextLight,
                        fontFamily: AppStrings.urbanistFont,
                      )
                  ),
                  TextButton(
                      onPressed: (){
                        context.pop();
                    },
                      child: const Text(AppStrings.login,style: TextStyle(
                        fontSize: Dim.FONT_SIZE_SMALL,
                        color: AppColors.blueTextLight,
                        fontFamily: AppStrings.urbanistMedium,
                      ),))
                ],
              ),
              SizedBox(height: screenHeight * 0.01),
              // Social Login
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
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                    height: screenHeight * 0.065,
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
                      height: screenHeight * 0.065,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(Dim.RADIUS_DEFAULT)),
                        color: AppColors.white,
                      ),
                      child: Center(child: Image.asset(AppImages.googleIcon))
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required String label,}) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: label,
        hintStyle: const TextStyle(fontFamily: AppStrings.urbanistMedium),
        filled: true,
        fillColor: AppColors.textField,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(Dim.RADIUS_DEFAULT),borderSide: BorderSide.none),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return AppStrings.fieldEmpty;
        }
        return null;
      },
    );
  }

  Widget _buildEmailTextField({ required String label,required String suffixIcon}) {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: const TextStyle(fontFamily: AppStrings.urbanistMedium),
        filled: true,
        fillColor: AppColors.textField,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(Dim.RADIUS_DEFAULT),borderSide: BorderSide.none),
        suffixIcon:  Padding(
          padding: const EdgeInsets.all(Dim.PADDING_SIZE_SMALL),
          child: SvgPicture.asset(
            suffixIcon, // Replace with your SVG file path
            width: Dim.D_20,
            height: Dim.D_20,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return AppStrings.fieldEmpty;
        } else if (!EmailValidator.validate(value)) {
          return AppStrings.invalidEmail;
        }
        return null;
      },
    );
  }

  Widget _buildDropdownField({required String label,required String suffixIcon}) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        hintText: label,
        hintStyle: const TextStyle(fontFamily: AppStrings.urbanistMedium),
        filled: true,
        fillColor: AppColors.textField,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(Dim.RADIUS_DEFAULT),borderSide: BorderSide.none),
        suffixIcon: Padding(
          padding: const EdgeInsets.all(Dim.PADDING_SIZE_SMALL),
          child: SvgPicture.asset(
            suffixIcon, // Replace with your SVG file path
            width: Dim.D_20,
            height: Dim.D_20,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return AppStrings.fieldEmpty;
        }
        return null;
      },
      items: const [
        DropdownMenuItem(value: AppStrings.male, child: Text(AppStrings.male)),
        DropdownMenuItem(value: AppStrings.female, child: Text(AppStrings.female)),
        DropdownMenuItem(value: AppStrings.others, child: Text(AppStrings.others)),
      ],
      onChanged: (value) {},
      icon: const SizedBox.shrink(),
    );
  }

  Widget _buildPhoneNumberField(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: AppStrings.phoneNumber,
        hintStyle: const TextStyle(fontFamily: AppStrings.urbanistMedium),
        filled: true,
        fillColor: AppColors.textField,
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dim.PADDING_SIZE_SMALL),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(AppImages.countryIcon, width: Dim.D_24), // American flag asset
              const SizedBox(width: Dim.D_5),
              SvgPicture.asset(
                AppVectors.countryArrowDown, //blue arrow vector
                width: Dim.D_24,
                height: Dim.D_24,
              ),
            ],
          ),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(Dim.RADIUS_DEFAULT),borderSide: BorderSide.none),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return AppStrings.fieldEmpty;
        }else if(value.length < 10){
          return AppStrings.shortNumber;
        }
        return null;
      },
    );
  }

  Widget _buildPasswordTextField({required String label, required TextEditingController controller, }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: const TextStyle(fontFamily: AppStrings.urbanistMedium),
        filled: true,
        fillColor: AppColors.textField,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(Dim.RADIUS_DEFAULT),borderSide: BorderSide.none),
        suffixIcon:  Padding(
          padding: const EdgeInsets.all(Dim.PADDING_SIZE_SMALL),
          child: SvgPicture.asset(
            AppVectors.lockIcon, // Replace with your SVG file path
            width: Dim.D_20,
            height: Dim.D_20,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return AppStrings.fieldEmpty;
        }else if(value.length < 8){
          return AppStrings.shortPassword;
        }
        return null;
      },
    );
  }

}
