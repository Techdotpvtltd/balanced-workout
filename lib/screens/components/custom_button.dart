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
    this.isSmallText = false,
    this.subTitle,
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
  final bool isSmallText;
  final String? subTitle;

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
                : backgroundColor ?? AppTheme.primaryColor1,
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        border: Border.all(
          color: onlyBorder && isEnabled
              ? AppTheme.primaryColor1
              : backgroundColor ?? Colors.grey[400]!,
        ),
      ),
      child: ElevatedButton(
        onPressed: !isLoading && isEnabled ? onPressed : null,
        style: const ButtonStyle(
          surfaceTintColor: WidgetStatePropertyAll(Colors.transparent),
          shadowColor: WidgetStatePropertyAll(Colors.transparent),
          backgroundColor: WidgetStatePropertyAll(Colors.transparent),
        ),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: (onlyBorder || !isEnabled)
                      ? AppTheme.primaryColor1
                      : AppTheme.titleDarkColor1,
                ),
              )
            : Text.rich(
                TextSpan(
                  text: title,
                  children: [
                    if (subTitle != null && subTitle != "")
                      TextSpan(
                        text: "\n$subTitle",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                  ],
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: !isEnabled && onlyBorder
                      ? Colors.grey[400]
                      : onlyBorder
                          ? AppTheme.primaryColor1
                          : textColor ?? AppTheme.titleDarkColor1,
                  fontSize: isSmallText ? 14 : 16,
                  fontWeight: isSmallText ? FontWeight.w500 : FontWeight.w700,
                ),
              ),
      ),
    );
  }
}
