// Project: 	   balanced_workout
// File:    	   notification_screen
// Path:    	   lib/screens/main/user/notification_screen.dart
// Author:       Ali Akbar
// Date:        07-05-24 18:43:47 -- Tuesday
// Description:

import 'package:flutter/material.dart';

import '../../../utils/constants/app_theme.dart';
import '../../components/avatar_widget.dart';
import '../../components/custom_app_bar.dart';
import '../../components/custom_container.dart';
import '../../components/custom_scaffold.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBar(
        title: "Notification",
      ),
      body: ListView.builder(
        padding:
            const EdgeInsets.only(left: 29, right: 29, bottom: 30, top: 10),
        itemCount: 5,
        itemBuilder: (context, index) {
          bool isSelected = index == 0;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 11),
            child: CustomContainer(
              padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 10),
              color: isSelected
                  ? AppTheme.primaryColor1
                  : AppTheme.darkWidgetColor2,
              borderRadius: const BorderRadius.all(Radius.circular(14)),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.top,

                /// Avatar Widget
                leading: const SizedBox(
                  height: 42,
                  width: 42,
                  child: AvatarWidget(
                    backgroundColor: Colors.black,
                    avatarUrl:
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTEes0YXLnhTrbMOKYC8apm3kYA59-oiGadfhGkzTOdzxDzxLewZ6i_NT7H5S-Ag8M7vQ&usqp=CAU',
                  ),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "20 mins ago",
                      style: TextStyle(
                        color: isSelected
                            ? AppTheme.titleDarkColor1
                            : AppTheme.primaryColor1,
                        fontSize: 8,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "Notification Heading Here",
                      style: TextStyle(
                        color: isSelected
                            ? AppTheme.titleDarkColor1
                            : Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),

                subtitle: Text(
                  "A dwarf who brings a standard to measure his own size, take my word,",
                  style: TextStyle(
                    color: isSelected ? AppTheme.titleDarkColor1 : Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
