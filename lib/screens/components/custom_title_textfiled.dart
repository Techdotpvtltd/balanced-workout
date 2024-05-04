import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/constants/app_theme.dart';
import '../../utils/constants/constants.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.titleText,
    required this.hintText,
    this.controller,
    this.suffixWidget,
    this.onTFTap,
    this.errorText,
    this.isReadyOnly = false,
    this.keyboardType,
    this.prefixWidget,
    this.maxLines = 1,
    this.minLines,
    this.fieldId,
    this.errorCode,
    this.onSubmitted,
    this.onChange,
    this.focusNode,
    this.textInputAction,
    this.prefixIcon,
  });
  final String? titleText;
  final String hintText;
  final TextEditingController? controller;
  final Widget? suffixWidget;
  final Widget? prefixWidget;
  final VoidCallback? onTFTap;
  final String? errorText;
  final bool isReadyOnly;
  final TextInputType? keyboardType;
  final int maxLines;
  final int? minLines;
  final int? fieldId;
  final int? errorCode;
  final FocusNode? focusNode;
  final Function(String)? onSubmitted;
  final Function(String)? onChange;
  final TextInputAction? textInputAction;
  final String? prefixIcon;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _isReadOnly;
  bool isFocused = false;
  late final FocusNode textFieldFocus;
  bool isShowPassword = true;

  // IconData? getTextFiledPrefixIcon() {
  //   switch (widget.keyboardType) {
  //     case TextInputType.emailAddress:
  //       return Icons.email_outlined;
  //     case TextInputType.visiblePassword:
  //       return Icons.lock_open_outlined;
  //     case TextInputType.phone:
  //       return Icons.phone_outlined;
  //     case TextInputType.name:
  //       return Icons.person_outline;
  //     default:
  //       return null;
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _isReadOnly = widget.isReadyOnly;
    textFieldFocus = widget.focusNode ?? FocusNode();
    textFieldFocus.addListener(() {
      setState(() {
        isFocused = textFieldFocus.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    textFieldFocus.removeListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: widget.titleText != null,
          child: Text(
            widget.titleText ?? "",
            style: const TextStyle(
              color: AppTheme.titleColor2,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        if (widget.titleText != null) gapH10,
        TextField(
          canRequestFocus: true,
          focusNode: textFieldFocus,
          controller: widget.controller,
          textInputAction: widget.textInputAction,
          obscureText: widget.keyboardType == TextInputType.visiblePassword &&
              isShowPassword,
          onSubmitted: (value) {
            if (widget.onSubmitted != null) {
              widget.onSubmitted!(value);
            }
          },
          onTap: () {
            if (widget.onTFTap != null) {
              widget.onTFTap!();
            }
          },
          keyboardType: widget.keyboardType,
          readOnly: _isReadOnly,
          onChanged: (value) {
            if (widget.onChange != null) {
              widget.onChange!(value);
            }
          },
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          style: const TextStyle(
            color: AppTheme.titleColor1,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 23, vertical: 14),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  (widget.maxLines > 1) ? 12 : 124,
                ),
              ),
              borderSide: const BorderSide(color: Colors.transparent, width: 0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  (widget.maxLines > 1) ? 12 : 124,
                ),
              ),
              borderSide:
                  const BorderSide(color: AppTheme.primaryColor1, width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  (widget.maxLines > 1) ? 12 : 124,
                ),
              ),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  (widget.maxLines > 1) ? 12 : 124,
                ),
              ),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            filled: true,
            fillColor: const Color(0xFF303030),
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: isFocused ? Colors.white : AppTheme.placeholderColor,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
            errorText:
                (widget.fieldId == widget.errorCode && widget.errorText != null)
                    ? widget.errorText
                    : null,
            errorStyle: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            suffixIcon: widget.keyboardType == TextInputType.visiblePassword
                ? IconButton(
                    onPressed: () {
                      setState(
                        () {
                          isShowPassword = !isShowPassword;
                        },
                      );
                    },
                    icon: Icon(
                      isShowPassword ? Icons.visibility : Icons.visibility_off,
                      color:
                          isFocused ? Colors.white : AppTheme.placeholderColor,
                    ),
                  )
                : widget.suffixWidget,
            prefixIcon: widget.prefixWidget ??
                (widget.prefixIcon != null
                    ? SizedBox(
                        width: 16,
                        child: Center(
                          child: SvgPicture.asset(
                            widget.prefixIcon!,
                            colorFilter: ColorFilter.mode(
                              isFocused
                                  ? Colors.white
                                  : AppTheme.placeholderColor,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      )
                    : null),
          ),
        ),
      ],
    );
  }
}
