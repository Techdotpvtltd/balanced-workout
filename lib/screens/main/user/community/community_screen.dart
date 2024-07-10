// Project: 	   balanced_workout
// File:    	   community_screen
// Path:    	   lib/screens/main/user/community/community_screen.dart
// Author:       Ali Akbar
// Date:        09-05-24 14:41:26 -- Thursday
// Description:

import 'package:flutter/material.dart';

import '../../../../utils/constants/app_assets.dart';
import '../../../../utils/constants/app_theme.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../utils/extensions/navigation_service.dart';
import '../../../components/avatar_widget.dart';
import '../../../components/circle_button.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_container.dart';
import '../../../components/custom_paddings.dart';
import '../../../components/custom_scaffold.dart';
import '../../../components/custom_title_textfiled.dart';
import 'create_community_screen.dart';
import 'group_chat_screen.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  bool isMyCommunityView = false;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      floatingActionButton: CircleButton(
        onPressed: () {
          NavigationService.go(const CreateCommunityScreen());
        },
        icon: AppAssets.plusIcon,
        backgroundColor: AppTheme.primaryColor1,
      ),
      appBar: customAppBar(title: "Community"),
      body: const CustomPadding(
        top: 30,
        child: Column(
          children: [
            /// Search Text
            CustomTextField(
              hintText: "Search",
              prefixWidget: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),

            /// Custom Tab Bar
            // gapH20,
            // CustomTabBar(
            //   items: const [
            //     'App Community',
            //     'My Community',
            //     'Other Communities'
            //   ],
            //   onPressed: (index) {
            //     setState(() {
            //       isMyCommunityView = index == 1;
            //     });
            //   },
            // ),

            /// Community Widget
            Expanded(
              child: _CommunityItemWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

// =========================== Community Views================================
class _CommunityItemWidget extends StatelessWidget {
  const _CommunityItemWidget();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 15, bottom: 70),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: CustomContainer(
            onPressed: () {
              NavigationService.go(const GroupChatScreen());
            },
            padding:
                const EdgeInsets.only(left: 17, top: 16, bottom: 16, right: 20),
            color: const Color(0xFFF2F2F2).withOpacity(0.12),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AvatarWidget(
                  avatarUrl: "",
                  backgroundColor: Colors.brown,
                  placeholderChar: 'G',
                  width: 32,
                  height: 32,
                ),
                gapW10,

                /// Community Description
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Group Title",
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      /// Description and Join Button Feature
                      gapH2,
                      Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
