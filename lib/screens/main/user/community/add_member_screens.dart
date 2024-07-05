// Project: 	   balanced_workout
// File:    	   add_member_screens
// Path:    	   lib/screens/main/user/community/add_member_screens.dart
// Author:       Ali Akbar
// Date:        09-05-24 16:51:01 -- Thursday
// Description:

import 'package:flutter/material.dart';

import '../../../../utils/constants/app_theme.dart';
import '../../../../utils/constants/constants.dart';
import '../../../components/avatar_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_container.dart';
import '../../../components/custom_paddings.dart';
import '../../../components/custom_scaffold.dart';
import '../../../components/custom_title_textfiled.dart';

class AddMemberScreen extends StatefulWidget {
  const AddMemberScreen({super.key});

  @override
  State<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  List<int> selectedIndexes = [1, 2];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: HorizontalPadding(
        child: CustomButton(
          onPressed: () {},
          title: 'Send Invite',
        ),
      ),
      appBar: customAppBar(
        title: "Add Members",
      ),
      body: CustomPadding(
        child: Column(
          children: [
            /// Search TF
            const CustomTextField(
              hintText: 'Search',
              prefixWidget: Icon(
                Icons.search,
                color: Colors.white,
              ),
              textInputAction: TextInputAction.search,
            ),

            /// Profile List View
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                padding: const EdgeInsets.only(top: 22, bottom: 80),
                itemBuilder: (context, index) {
                  final bool isSelected = selectedIndexes.contains(index);

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: CustomContainer(
                      onPressed: () {
                        setState(() {
                          if (isSelected) {
                            selectedIndexes.remove(index);
                          } else {
                            selectedIndexes.add(index);
                          }
                        });
                      },
                      color: const Color(0xFF232323).withOpacity(0.62),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 9),
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// Custom Avatar
                          const Expanded(
                            child: Row(
                              children: [
                                AvatarWidget(
                                  width: 41,
                                  height: 41,
                                  backgroundColor: Colors.black,
                                ),
                                gapW10,

                                /// Name Text
                                Flexible(
                                  child: Text(
                                    'Ali Akbar',
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Checkbox(
                            value: isSelected,
                            onChanged: (value) {},
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(300)),
                            ),
                            fillColor: const WidgetStatePropertyAll(
                                Colors.transparent),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            side: WidgetStateBorderSide.resolveWith(
                              (states) => BorderSide(
                                  color: !isSelected
                                      ? const Color(0xFF434242)
                                      : AppTheme.primaryColor1),
                            ),
                            checkColor: AppTheme.primaryColor1,
                            visualDensity: VisualDensity.comfortable,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
