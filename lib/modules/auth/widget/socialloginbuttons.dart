import 'package:flutter/material.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialIconButton(iconPath: 'assets/icons/google.jpg', onTap: () {}),
        const SizedBox(width: 25),
        SocialIconButton(iconPath: 'assets/icons/facebook.png', onTap: () {}),
      ],
    );
  }
}

class SocialIconButton extends StatelessWidget {
  final String iconPath;
  final VoidCallback? onTap;

  const SocialIconButton({super.key, required this.iconPath, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 5,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Center(
            child: Image.asset(
              iconPath,
              width: 24,
              height: 24,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
