// Project: 	   balanced_workout
// File:    	   wheel_value_picker
// Path:    	   lib/screens/onboarding/components/wheel_value_picker.dart
// Author:       Ali Akbar
// Date:        04-05-24 17:07:08 -- Saturday
// Description:

import 'package:flutter/material.dart';
import 'package:wheel_picker/wheel_picker.dart';

import '../../../utils/constants/app_theme.dart';
import '../../../utils/constants/constants.dart';

class WheelValuePicker extends StatefulWidget {
  const WheelValuePicker(
      {super.key,
      required this.data,
      this.onIndexChanged,
      this.unit,
      this.isSmallText = false});
  final List<String> data;
  final Function(int)? onIndexChanged;
  final String? unit;
  final bool isSmallText;
  @override
  State<WheelValuePicker> createState() => _WheelValuePickerState();
}

class _WheelValuePickerState extends State<WheelValuePicker> {
  int selectedIndex = 0;

  late final textStyle = TextStyle(
    fontSize: widget.isSmallText ? 28 : 58.0,
    height: 1.2,
    color: const Color(0xFFAAAAAA),
    fontWeight: FontWeight.w700,
  );
  @override
  Widget build(BuildContext context) {
    return WheelPicker(
      itemCount: widget.data.length,
      style: WheelPickerStyle(
        size: widget.isSmallText ? 300 : 400,
        itemExtent: textStyle.fontSize! * textStyle.height! +
            (widget.isSmallText ? 40 : 0),
        squeeze: 1.5,
        magnification: widget.isSmallText ? 5 : 2.7,
      ),
      onIndexChanged: (index) {
        setState(() {
          selectedIndex = index;
        });
        if (widget.onIndexChanged != null) widget.onIndexChanged!(index);
      },
      builder: (context, index) {
        final String strValue = widget.data[index];
        return Column(
          children: [
            if (selectedIndex == index && widget.data.length > 4)
              const Divider(
                color: AppTheme.primaryColor1,
                thickness: 2,
                height: 0,
              ),
            Expanded(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (selectedIndex == index && widget.unit != null) gapW28,
                    Text(
                      strValue,
                      maxLines: 1,
                      style: textStyle.copyWith(
                        color: selectedIndex == index
                            ? Colors.white
                            : const Color(0xFFAAAAAA),
                      ),
                    ),
                    if (selectedIndex == index && widget.unit != null) gapW4,
                    Visibility(
                      visible: selectedIndex == index && widget.unit != null,
                      child: Text(
                        widget.unit ?? "",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (selectedIndex == index && widget.data.length > 4)
              const Divider(
                color: AppTheme.primaryColor1,
                height: 0,
                thickness: 2,
              ),
          ],
        );
      },
    );
  }
}
