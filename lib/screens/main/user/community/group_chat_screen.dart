// Project: 	   balanced_workout
// File:    	   group_chat_screen
// Path:    	   lib/screens/main/user/community/group_chat_screen.dart
// Author:       Ali Akbar
// Date:        09-05-24 17:49:06 -- Thursday
// Description:

import 'package:flutter/material.dart';

import '../../../../utils/constants/app_assets.dart';
import '../../../../utils/constants/app_theme.dart';
import '../../../../utils/constants/constants.dart';
import '../../../components/avatar_widget.dart';
import '../../../components/circle_button.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_container.dart';
import '../../../components/custom_scaffold.dart';
import '../../../components/custom_title_textfiled.dart';

class GroupChatScreen extends StatelessWidget {
  const GroupChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBar(
        background: const Color(0xFF2C2C2E).withOpacity(0.62),

        /// Title Widget
        titleWidget: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pets United",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            gapH6,
            Text.rich(
              TextSpan(
                text: "1023",
                children: [
                  TextSpan(
                    text: ' members',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),

        /// Menu Button
        actions: [
          CircleButton(
            icon: AppAssets.menuIcon,
            onPressed: () {},
            backgroundColor: const Color(0xFFDEDEE0).withOpacity(0.11),
          ),
          gapW20,
        ],
      ),
      body: Column(
        children: [
          /// A chapi Style
          Container(
            height: 25,
            decoration: BoxDecoration(
              color: const Color(0xFF2C2C2E).withOpacity(0.62),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),

          const Expanded(
            child: _BubbleList(),
          ),

          /// TextField
          Padding(
            padding: const EdgeInsets.only(bottom: 30, left: 30, right: 30),
            child: CustomTextField(
              hintText: "Message",
              maxLines: 5,
              minLines: 1,
              prefixWidget: SizedBox(
                width: 20,
                height: 20,
                child: Center(
                  child: CircleButton(
                    onPressed: () {},
                    icon: AppAssets.plusIcon,
                    backgroundColor: AppTheme.primaryColor1,
                  ),
                ),
              ),
              suffixWidget: const Icon(
                Icons.send,
                color: AppTheme.primaryColor1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================Bubble List================================
class _BubbleList extends StatelessWidget {
  const _BubbleList();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 20, bottom: 30, left: 30, right: 30),
      children: const [
        _BubbleWidget(),
        _BubbleWidget(isSender: false),
        _BubbleWidget(),
      ],
    );
  }
}

// ===========================Bubble Widget================================

class _BubbleWidget extends StatelessWidget {
  const _BubbleWidget({this.isSender = true});
  final bool isSender;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.start : CrossAxisAlignment.end,

        /// Image and Messages
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Avatar Widget
              Visibility(
                visible: !isSender,
                child: const AvatarWidget(
                  width: 30,
                  height: 30,
                  backgroundColor: Colors.black,
                ),
              ),
              gapW10,
              Expanded(
                child: CustomContainer(
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                  color: isSender
                      ? AppTheme.primaryColor1
                      : const Color(0xFF2C2C2E).withOpacity(0.37),
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  child: Text(
                    "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content.",
                    style: TextStyle(
                      color: isSender ? Colors.black : Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              gapW10,

              /// Avatar Widget
              Visibility(
                visible: isSender,
                child: const AvatarWidget(
                  width: 30,
                  height: 30,
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          ),

          /// Time
          gapH4,
          const Text(
            "30:01 Pm",
            style: TextStyle(
              color: Color(0xFFBFBFBF),
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }
}
