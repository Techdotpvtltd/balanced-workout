// Project: 	   balanced_workout
// File:    	   create_community_screen
// Path:    	   lib/screens/main/user/community/create_community_screen.dart
// Author:       Ali Akbar
// Date:        09-05-24 15:50:22 -- Thursday
// Description:

import 'package:flutter/material.dart';

import '../../../../utils/constants/app_theme.dart';
import '../../../../utils/constants/constants.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_container.dart';
import '../../../components/custom_paddings.dart';
import '../../../components/custom_scaffold.dart';
import '../../../components/custom_title_textfiled.dart';

class CreateCommunityScreen extends StatelessWidget {
  const CreateCommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: HorizontalPadding(
        child: CustomButton(
          onPressed: () {},
          title: 'Create',
        ),
      ),
      appBar: customAppBar(
        title: 'Create Community',
      ),
      body: ListView(
        padding:
            const EdgeInsets.only(left: 30, right: 30, top: 46, bottom: 100),
        physics: const ScrollPhysics(),
        children: [
          /// Upload Image Button
          CustomContainer(
            onPressed: () {},
            size: const Size.fromHeight(183),
            color: AppTheme.darkWidgetColor2,
            borderRadius: const BorderRadius.all(Radius.circular(21)),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.file_upload_outlined,
                  size: 40,
                  color: AppTheme.primaryColor1,
                ),
                gapH6,
                Text(
                  'Upload Image',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          /// Name
          gapH22,
          const CustomTextField(
            titleText: "Name",
            hintText: 'Community Name',
          ),

          /// Description
          gapH22,
          const CustomTextField(
            titleText: "Description",
            hintText: 'Write Description',
            maxLines: 8,
          ),

          /// Maximum Members
          gapH22,
          const CustomTextField(
            titleText: "Max Community Limit",
            hintText: 'Add number of persons can join.',
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }
}
