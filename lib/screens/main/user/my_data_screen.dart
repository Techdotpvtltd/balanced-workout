// Project: 	   balanced_workout
// File:    	   my_data_screen
// Path:    	   lib/screens/main/user/my_data_screen.dart
// Author:       Ali Akbar
// Date:        08-05-24 17:44:17 -- Wednesday
// Description:

import 'package:flutter/material.dart';

import '../../../utils/constants/app_assets.dart';
import '../../../utils/constants/app_theme.dart';
import '../../../utils/constants/constants.dart';
import '../../components/avatar_widget.dart';
import '../../components/circle_button.dart';
import '../../components/custom_app_bar.dart';
import '../../components/custom_button.dart';
import '../../components/custom_paddings.dart';
import '../../components/custom_scaffold.dart';
import '../../components/custom_title_textfiled.dart';

class MyDataScreen extends StatefulWidget {
  const MyDataScreen({super.key});

  @override
  State<MyDataScreen> createState() => _MyDataScreenState();
}

class _MyDataScreenState extends State<MyDataScreen> {
  bool isEditable = false;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: HorizontalPadding(
        child: CustomButton(
          isEnabled: isEditable,
          onPressed: () {},
          title: "Save",
        ),
      ),

      /// App Bar
      appBar: customAppBar(
        rightPadding: 29,
        title: 'My Data',
        actions: [
          /// Edit Button
          if (!isEditable)
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isEditable = true;
                });
              },
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Color(0xFF303030)),
                padding: MaterialStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 15)),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)))),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.edit_outlined,
                    size: 16,
                    color: AppTheme.primaryColor1,
                  ),
                  gapW6,
                  Text(
                    "Edit Data",
                    style: TextStyle(
                      color: AppTheme.primaryColor1,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),

      /// Content Screen
      body: ListView(
        physics: const ScrollPhysics(),
        padding:
            const EdgeInsets.only(left: 29, right: 29, top: 40, bottom: 100),
        children: [
          /// Profile Widget
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 105,
              width: 105,
              child: Stack(
                children: [
                  const Positioned(
                    child: AvatarWidget(
                      backgroundColor: Colors.black,
                      width: 100,
                      height: 100,
                    ),
                  ),

                  /// Camera Icon
                  Visibility(
                    visible: isEditable,
                    child: Positioned(
                      right: 0,
                      bottom: 20,
                      child: SizedBox(
                        width: 25,
                        height: 25,
                        child: CircleButton(
                          onPressed: () {},
                          icon: AppAssets.cameraIcon,
                          backgroundColor: AppTheme.primaryColor1,
                          colorFilter: const ColorFilter.mode(
                              Colors.black, BlendMode.srcIn),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// Weight TF
          gapH50,
          CustomTextField(
            isReadyOnly: !isEditable,
            hintText: '54 KG',
            titleText: 'Weight',
            keyboardType: TextInputType.number,
          ),
          gapH24,

          /// Height TF
          CustomTextField(
            isReadyOnly: !isEditable,
            hintText: '167 CM',
            titleText: 'Height',
            keyboardType: TextInputType.number,
          ),

          gapH24,

          /// Height TF
          CustomTextField(
            isReadyOnly: !isEditable,
            hintText: 'Select Goal',
            titleText: 'Goal',
            keyboardType: TextInputType.text,
          ),
          gapH24,

          /// Height TF
          CustomTextField(
            isReadyOnly: !isEditable,
            hintText: 'Select Activity',
            titleText: 'Physical Activity',
            keyboardType: TextInputType.text,
          ),
        ],
      ),
    );
  }
}
