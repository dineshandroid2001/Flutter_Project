import 'package:chat_box/presentation/app_constant/app_constant.dart';
import 'package:flutter/material.dart';
import 'custom_text_widget.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Icon icon;
  bool homeImage;
  bool backArrow;
  final Color appBarColor;
  final Color backArrowColor;

  CustomAppBar(
      {super.key,
      this.title = 'Chat Box',
      this.icon = const Icon(Icons.contacts),
      this.homeImage = false,
      this.backArrow = false,
      this.appBarColor = AppConstants.secondaryColor,
      this.backArrowColor = AppConstants.primaryColor});
  @override
  Widget build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: backArrow,
        backgroundColor: appBarColor,
        elevation: 0,
        iconTheme: IconThemeData(color: backArrowColor),
        title: backArrow != true
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: AppConstants.liteWhiteColor, width: 1),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                        size: 30,
                        color: AppConstants.primaryColor,
                      ),
                    ),
                  ),
                  CustomTextWidget(
                    text: title,
                    fontSize: 26,
                  ),
                  homeImage
                      ? const CircleAvatar(
                          radius: 28,
                          backgroundImage: AssetImage(AppConstants.myProfile),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: AppConstants.liteWhiteColor, width: 1),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              icon.icon,
                              size: 30,
                              color: AppConstants.primaryColor,
                            ),
                          ),
                        ),
                ],
              )
            : null);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

//automaticallyImplyLeading: false,
