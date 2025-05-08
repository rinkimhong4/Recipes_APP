import 'package:flutter/material.dart';
import 'package:recipe_app/config/theme/theme_style.dart';

class CustomTextField extends StatelessWidget {
  final IconData? icon;
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;

  const CustomTextField({
    super.key,
    this.icon,
    required this.label,
    required this.hintText,
    this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.poppinsSmallRegular14(color: AppColors.neutral),
        ),
        const SizedBox(height: 7),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyle.poppinsSmallerRegular11(
              color: AppColors.neutral.withValues(alpha: 0.5),
            ),
            prefixIcon:
                icon != null
                    ? Icon(
                      icon,
                      color: AppColors.neutral.withValues(alpha: 0.7),
                    )
                    : null,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppColors.neutral.withValues(alpha: 0.5),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.ratingColor, width: 1),
            ),
          ),
        ),
      ],
    );
  }
}
