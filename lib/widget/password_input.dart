import 'package:flutter/material.dart';
import 'package:recipe_app/config/theme/theme_style.dart';

class PasswordInput extends StatefulWidget {
  final String? label;
  final String hintText;
  final TextEditingController textEditingController;

  const PasswordInput({
    this.label,
    required this.textEditingController,
    required this.hintText,
    super.key,
  });

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool pwdVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Text(
            widget.label!,
            style: AppTextStyle.poppinsSmallRegular14(color: AppColors.neutral),
          ),
        const SizedBox(height: 7),
        TextFormField(
          controller: widget.textEditingController,
          obscureText: !pwdVisibility,
          decoration: InputDecoration(
            hintText: widget.hintText,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppColors.neutral.withValues(alpha: 0.5),
              ),
            ),
            hintStyle: AppTextStyle.poppinsSmallerRegular11(
              color: AppColors.neutral.withValues(alpha: 0.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.ratingColor, width: 1.2),
            ),
            suffixIcon: InkWell(
              onTap: () {
                setState(() {
                  pwdVisibility = !pwdVisibility;
                });
              },
              child: Icon(
                pwdVisibility
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: Colors.grey.shade400,
                size: 18,
              ),
            ),
          ),
          validator: (val) {
            if (val == null || val.isEmpty) {
              return 'Required';
            }
            return null;
          },
        ),
      ],
    );
  }
}
