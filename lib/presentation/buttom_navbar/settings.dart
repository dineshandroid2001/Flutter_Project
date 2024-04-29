import 'package:chat_box/presentation/app_constant/app_constant.dart';
import 'package:chat_box/presentation/custom_widgets/attach_file.dart';
import 'package:chat_box/presentation/custom_widgets/buttons/custom_icon_button.dart';
import 'package:chat_box/presentation/custom_widgets/container_widget.dart';
import 'package:chat_box/presentation/custom_widgets/custom_app_bar.dart';
import 'package:chat_box/presentation/custom_widgets/sized_box.dart';
import 'package:chat_box/presentation/profile/my_profile.dart';
import 'package:flutter/material.dart';
import 'package:chat_box/presentation/custom_widgets/custom_text_widget.dart';

class SettingNav extends StatefulWidget {
  const SettingNav({super.key});

  @override
  State<SettingNav> createState() => _SettingNavState();
}

class _SettingNavState extends State<SettingNav> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: 'Settings',
          icon: const Icon(Icons.settings),),
      body: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: ContainerWidget(
            topLeftValue: AppConstants.decorationValue,
            topRightValue: AppConstants.decorationValue,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyProfile())),
                      child: const CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage(AppConstants.myProfile),
                      ),
                    ),
                    SizedBoxWidget(width: 0.04),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomTextWidget(
                            text: 'Dinesh Kumar',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppConstants.secondaryColor),
                        SizedBoxWidget(height: 0.005),
                        const Text('Available')
                      ],
                    ),
                    SizedBoxWidget(width: 0.23),
                    const CustomIconButton(icon: Icon(Icons.qr_code),iconSize: 40,)
                  ],
                ),
              ),
              const AttachFile(
                  icon: Icon(Icons.key),
                  title: 'Account',
                  subTitle: AppConstants.settingAcc),
              const AttachFile(
                  icon: Icon(Icons.message),
                  title: 'Chat',
                  subTitle: AppConstants.settingChat),
              const AttachFile(
                  icon: Icon(Icons.notifications),
                  title: 'Notifications',
                  subTitle: AppConstants.settingNoti),
              const AttachFile(
                  icon: Icon(Icons.help),
                  title: 'Help',
                  subTitle: AppConstants.settingHelp),
              const AttachFile(
                  icon: Icon(Icons.data_usage),
                  title: 'Storage',
                  subTitle: AppConstants.settingStore),
              const AttachFile(
                  icon: Icon(Icons.person),
                  title: 'Invite a friend',
                  subTitle: AppConstants.settingInvite),
            ]),
          )),
    );
  }
}
