import 'package:flutter/material.dart';
import 'package:recipe_app/config/theme/theme_style.dart';
import 'package:recipe_app/modules/Home/screens/home_screen.dart';
import 'package:recipe_app/modules/auth/login/login_screen.dart';
import 'package:recipe_app/modules/auth/widget/socialloginbuttons.dart';
import 'package:recipe_app/widget/button_custom.dart';
import 'package:recipe_app/widget/text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isChecked = false;
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
          top: 90,
          left: 30,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create an account",
                style: AppTextStyle.poppinsLargeBold(color: AppColors.neutral),
              ),
              SizedBox(height: 7),
              SizedBox(
                width: 200,
                child: Text(
                  "Let's help you set up your account, it won't take long.",
                  style: AppTextStyle.poppinsSmallerRegular(
                    color: AppColors.neutral,
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 200,
          left: 30,
          right: 30,
          child: Column(
            children: [
              CustomTextField(label: 'Name', hintText: 'Enter your name'),
              SizedBox(height: 25),
              CustomTextField(label: 'Email', hintText: 'Enter email'),
              SizedBox(height: 25),
              CustomTextField(
                label: 'Enter Password',
                hintText: 'Enter Password',
                obscureText: true,
              ),
              SizedBox(height: 25),
              CustomTextField(
                label: 'Confirm Password',
                hintText: 'Confirm Password',
                obscureText: true,
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            isChecked
                                ? Icons.check_box_rounded
                                : Icons.check_box_outline_blank,
                            color: AppColors.ratingColor,
                          ),
                          onPressed: () {
                            setState(() {
                              isChecked = !isChecked;
                            });
                          },
                        ),
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isChecked = !isChecked;
                            });
                          },
                          child: Text(
                            'Accept terms & Condition',
                            style: AppTextStyle.poppinsSmallerRegular(
                              color: AppColors.ratingColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 26),
                    NavButton(
                      context,
                      label: 'Sign in',
                      icon: Icons.chevron_right,
                      width: 400,
                      height: 60,
                      textStyle: AppTextStyle.poppinsSmallBold(),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      },
                    ),
                    SizedBox(height: 14),
                    _buildOrDivider(),
                    SizedBox(height: 20),
                    SocialLoginButtons(),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account",
                    style: AppTextStyle.poppinsSmallerBold(
                      color: AppColors.neutral,
                    ),
                  ),
                  SizedBox(width: 4),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'sign in',
                      style: AppTextStyle.poppinsSmallerBold(
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
            style: AppTextStyle.poppinsSmallRegular(
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
