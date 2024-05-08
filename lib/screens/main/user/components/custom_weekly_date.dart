// Project: 	   balanced_workout
// File:    	   custom_weekly_date
// Path:    	   lib/screens/main/user/components/custom_weekly_date.dart
// Author:       Ali Akbar
// Date:        08-05-24 12:59:17 -- Wednesday
// Description:

import 'package:balanced_workout/utils/extensions/date_extension.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../utils/constants/app_assets.dart';
import '../../../../utils/constants/app_theme.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../utils/extensions/methods.dart';
import '../../../components/circle_button.dart';
import '../../../components/custom_container.dart';
import '../../../components/custom_ink_well.dart';
import '../../../components/custom_paddings.dart';

class CustomWeeklyDate extends StatefulWidget {
  const CustomWeeklyDate(
      {super.key, this.initialDate, required this.onSelectedDate});
  final DateTime? initialDate;
  final Function(DateTime) onSelectedDate;

  @override
  State<CustomWeeklyDate> createState() => _CustomWeeklyDateState();
}

class _CustomWeeklyDateState extends State<CustomWeeklyDate> {
  List<DateTime> dates = [];
  late int currentMonthIndex = (widget.initialDate ?? DateTime.now()).month;
  final DateTime now = DateTime.now();
  late DateTime? selectedDate = widget.initialDate ?? now;
  final ItemScrollController controller = ItemScrollController();

  void onNextMonthPressed() {
    setState(() {
      currentMonthIndex += 1;
      dates = getDates(ofYear: selectedDate?.year, ofMonth: currentMonthIndex);
    });
  }

  void onPreviousMonthPressed() {
    setState(() {
      currentMonthIndex -= 1;
      dates = getDates(ofYear: selectedDate?.year, ofMonth: currentMonthIndex);
    });
  }

  void navigateToSelectedDate() async {
    final int selectedDateIndex = dates.indexWhere((element) =>
        element.day == selectedDate?.day &&
        element.year == selectedDate?.year &&
        selectedDate?.month == element.month);
    await Future.delayed(const Duration(milliseconds: 500));
    if (controller.isAttached) {
      controller.scrollTo(
        index: selectedDateIndex - 4,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    dates = getDates(ofYear: selectedDate?.year, ofMonth: currentMonthIndex);
    navigateToSelectedDate();
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      color: const Color(0xFF2C2C2E).withOpacity(0.62),
      size: Size(SCREEN_WIDTH, SCREEN_HEIGHT * 0.215),
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
      child: Column(
        children: [
          /// Header View
          CustomPadding(
            top: 20,
            left: 20,
            right: 20,
            bottom: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleButton(
                  icon: AppAssets.backwardIcon,
                  onPressed: () {
                    onPreviousMonthPressed();
                  },
                ),
                Text(
                  dates.last.dateToString("MMMM yyyy"),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                CircleButton(
                  icon: AppAssets.forwardIcon,
                  onPressed: () {
                    onNextMonthPressed();
                  },
                ),
              ],
            ),
          ),

          /// Date View List
          gapH20,
          Expanded(
            child: ScrollablePositionedList.builder(
              itemScrollController: controller,
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              itemCount: dates.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final DateTime date = dates[index];
                final bool isSelected = dates.indexWhere((element) =>
                        element.day == selectedDate?.day &&
                        element.year == selectedDate?.year &&
                        selectedDate?.month == element.month) ==
                    index;
                final bool isToday = dates.indexWhere((element) =>
                        element.day == now.day &&
                        element.year == now.year &&
                        now.month == element.month) ==
                    index;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: CustomInkWell(
                    onTap: () {
                      setState(() {
                        selectedDate = date;
                      });
                      widget.onSelectedDate(date);
                    },
                    child: CustomContainer(
                      padding: const EdgeInsets.only(top: 23, bottom: 0),
                      size: const Size.fromWidth(43),
                      color: isSelected
                          ? AppTheme.primaryColor1
                          : isToday
                              ? Colors.blueGrey
                              : const Color(0xFF3A3A3C),
                      borderRadius: const BorderRadius.all(Radius.circular(98)),
                      child: Column(
                        children: [
                          Text(
                            date.dateToString("EEE"),
                            style: TextStyle(
                              color: isSelected
                                  ? AppTheme.titleDarkColor1
                                  : Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          gapH4,
                          Text(
                            date.dateToString("dd"),
                            style: TextStyle(
                              color: isSelected
                                  ? AppTheme.titleDarkColor1
                                  : Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
