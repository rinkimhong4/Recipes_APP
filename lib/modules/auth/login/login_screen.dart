import 'package:flutter/material.dart';
import 'package:recipe_app/config/theme/theme_style.dart';
import 'package:recipe_app/modules/Home/screens/bottom_tab_screen.dart';
import 'package:recipe_app/modules/auth/signup/signup.dart';
import 'package:recipe_app/modules/auth/widget/socialloginbuttons.dart';
import 'package:recipe_app/widget/button_custom.dart';
import 'package:recipe_app/widget/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Container(color: Colors.white, child: _buildBody()),
      ),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        Positioned(
          top: 150,
          left: 30,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello,",
                style: AppTextStyle.poppinsHeaderBold30(
                  color: AppColors.neutral,
                ),
              ),
              Text(
                "Welcome Back!",
                style: AppTextStyle.poppinsLargeRegular20(
                  color: AppColors.neutral,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 280,
          left: 30,
          right: 30,
          child: Column(
            children: [
              CustomTextField(label: 'Email', hintText: 'Enter email'),
              SizedBox(height: 30),
              CustomTextField(
                label: 'Enter Password',
                hintText: 'Enter Password',
                obscureText: true,
              ),

              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'forgot password',
                        style: AppTextStyle.poppinsSmallRegular14(
                          color: AppColors.ratingColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    NavButton(
                      context,
                      label: 'Sign in',
                      icon: Icons.chevron_right,
                      width: 400,
                      height: 60,
                      textStyle: AppTextStyle.poppinsSmallBold14(),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    _buildOrDivider(),
                    SizedBox(height: 20),
                    SocialLoginButtons(),
                  ],
                ),
              ),
              SizedBox(height: 55),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account",
                    style: AppTextStyle.poppinsSmallerBold11(
                      color: AppColors.neutral,
                    ),
                  ),
                  SizedBox(width: 4),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupScreen()),
                      );
                    },
                    child: Text(
                      'sign up',
                      style: AppTextStyle.poppinsSmallerBold11(
                        color: AppColors.ratingColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOrDivider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 1,
          color: AppColors.neutral.withValues(alpha: 0.3),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Or Sign in With",
            style: AppTextStyle.poppinsSmallRegular14(
              color: AppColors.neutral.withValues(alpha: 0.5),
            ),
          ),
        ),
        Container(
          width: 50,
          height: 1,
          color: AppColors.neutral.withValues(alpha: 0.3),
        ),
      ],
    );
  }
}
