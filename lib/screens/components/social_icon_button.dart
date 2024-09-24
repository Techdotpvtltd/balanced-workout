import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialIconButton extends StatelessWidget {
  const SocialIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.backgroundColor,
  });
  final VoidCallback onPressed;
  final String icon;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints.expand(width: 47, height: 47),
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          backgroundColor ?? const Color(0xFFF6F6F6),
        ),
      ),
      icon: SvgPicture.asset(
        icon,
        width: 24,
        height: 24,
      ),
    );
  }
}
