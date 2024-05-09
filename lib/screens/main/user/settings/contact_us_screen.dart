// Project: 	   balanced_workout
// File:    	   contact_us_screen
// Path:    	   lib/screens/main/user/settings/contact_us_screen.dart
// Author:       Ali Akbar
// Date:        09-05-24 12:11:04 -- Thursday
// Description:

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../utils/constants/app_assets.dart';
import '../../../../utils/constants/constants.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_paddings.dart';
import '../../../components/custom_scaffold.dart';
import '../../../components/custom_title_textfiled.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: HorizontalPadding(
        child: CustomButton(
          onPressed: () {},
          title: 'Send',
        ),
      ),
      appBar: customAppBar(
        title: "Contact Us",
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 60),
        child: CustomPadding(
          top: 78,
          child: Column(
            children: [
              /// Contact Us
              SvgPicture.asset(AppAssets.contactIcon),
              gapH24,

              ///Name Text Field
              const CustomTextField(
                hintText: "Enter your name",
                titleText: 'Name:',
              ),

              /// Email Text Field
              gapH24,
              const CustomTextField(
                hintText: "Enter your email",
                titleText: 'Email:',
                keyboardType: TextInputType.emailAddress,
              ),

              /// Email Text Field
              gapH24,
              const CustomTextField(
                hintText: "Write here",
                titleText: 'Message:',
                maxLines: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
