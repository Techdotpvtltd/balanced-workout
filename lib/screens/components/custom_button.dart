import 'package:flutter/material.dart';

import '../../utils/constants/app_theme.dart';
import '../../utils/constants/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.width,
    this.height,
    this.isEnabled = true,
    this.isLoading = false,
    this.onlyBorder = false,
    this.textColor,
    this.backgroundColor,
  });
  final String title;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final bool isEnabled;
  final bool isLoading;
  final bool onlyBorder;
  final Color? textColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? SCREEN_WIDTH,
      height: height ?? 48,
      decoration: BoxDecoration(
        color: onlyBorder
            ? Colors.transparent
            : !isEnabled
                ? Colors.grey[400]
                : AppTheme.primaryColor1,
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        border: Border.all(
          color: onlyBorder && isEnabled
              ? AppTheme.primaryColor1
              : Colors.grey[400]!,
        ),
      ),
      child: ElevatedButton(
        onPressed: !isLoading && isEnabled ? onPressed : null,
        style: const ButtonStyle(
          surfaceTintColor: MaterialStatePropertyAll(Colors.transparent),
          shadowColor: MaterialStatePropertyAll(Colors.transparent),
          backgroundColor: MaterialStatePropertyAll(Colors.transparent),
        ),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: (onlyBorder || !isEnabled)
                      ? AppTheme.primaryColor1
                      : AppTheme.titleDarkColor1,
                ),
              )
            : Text(
                title,
                style: TextStyle(
                  color: !isEnabled && onlyBorder
                      ? Colors.grey[400]
                      : onlyBorder
                          ? AppTheme.primaryColor1
                          : AppTheme.titleDarkColor1,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
      ),
    );
  }
}
