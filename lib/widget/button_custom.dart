import 'package:flutter/material.dart';
import 'package:recipe_app/config/theme/theme_style.dart';

class NavButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final TextStyle? textStyle;

  const NavButton(
    BuildContext context, {
    super.key,
    required this.label,
    this.icon,
    this.onPressed,
    this.width,
    this.height,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.neutral[100],
          textStyle: textStyle ?? AppTextStyle.poppinsSmallRegular14(),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label),
            if (icon != null) ...[
              const SizedBox(width: 9),
              Icon(icon, color: AppColors.neutral[100], size: 24),
            ],
          ],
        ),
      ),
    );
  }
}
