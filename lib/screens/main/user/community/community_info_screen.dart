// Project: 	   balanced_workout
// File:    	   community_info_screen
// Path:    	   lib/screens/main/user/community/community_info_screen.dart
// Author:       Ali Akbar
// Date:        09-05-24 16:08:51 -- Thursday
// Description:

import 'package:flutter/material.dart';

import '../../../../utils/constants/app_assets.dart';
import '../../../../utils/constants/app_theme.dart';
import '../../../../utils/constants/constants.dart';
import '../../../components/avatar_widget.dart';
import '../../../components/circle_button.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_paddings.dart';
import '../../../components/custom_scaffold.dart';
import '../../../components/custom_title_textfiled.dart';

class CommunityInfoScreen extends StatelessWidget {
  const CommunityInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: HorizontalPadding(
        child: Row(
          children: [
            Expanded(
              child: CustomButton(
                title: "Edit",
                onPressed: () {},
              ),
            ),
            gapW10,
            Expanded(
              child: CustomButton(
                title: "Deleted",
                onlyBorder: true,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
      appBar: customAppBar(
        title: "Community Info",
      ),
      body: ListView(
        padding:
            const EdgeInsets.only(top: 47, left: 29, right: 29, bottom: 100),
        children: [
          /// Profile Widget
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 115,
              width: 115,
              child: Stack(
                children: [
                  const Positioned(
                    child: AvatarWidget(
                      backgroundColor: Colors.green,
                      width: 110,
                      height: 110,
                      placeholderChar: 'C',
                    ),
                  ),

                  /// Camera Icon
                  Positioned(
                    right: 0,
                    bottom: 20,
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: CircleButton(
                        onPressed: () {},
                        icon: AppAssets.cameraIcon,
                        backgroundColor: AppTheme.primaryColor1,
                        colorFilter: const ColorFilter.mode(
                            Colors.black, BlendMode.srcIn),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          gapH50,

          /// Buttoms
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: () {},
                  title: "Add Member",
                  onlyBorder: true,
                  isSmallText: true,
                ),
              ),
              gapW22,
              Expanded(
                child: CustomButton(
                  onPressed: () {},
                  title: "Add Group",
                  isSmallText: true,
                ),
              ),
            ],
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
