import 'package:chat_box/presentation/app_constant/app_constant.dart';
import 'package:chat_box/presentation/custom_widgets/container_widget.dart';
import 'package:chat_box/presentation/custom_widgets/icon_widget.dart';
import 'package:chat_box/presentation/custom_widgets/sized_box.dart';
import 'package:chat_box/presentation/custom_widgets/user_details.dart';
import 'package:flutter/material.dart';
import 'package:chat_box/presentation/custom_widgets/custom_text_widget.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppConstants.secondaryColor,
          toolbarHeight: 230,
          flexibleSpace: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 30),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(AppConstants.myProfile),
                ),
              ),
              SizedBoxWidget(height: 0.01),
              const CustomTextWidget(text: 'Dinesh Kumar', fontSize: 25),
              SizedBoxWidget(height: 0.01),
              const CustomTextWidget(
                  text: 'dinesh123@gmail.com', fontSize: 16),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 30, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    IconWidget(icon: Icon(Icons.message_outlined)),
                    IconWidget(icon: Icon(Icons.call_outlined)),
                    IconWidget(icon: Icon(Icons.video_call_outlined)),
                    IconWidget(icon: Icon(Icons.menu)),
                  ],
                ),
              )
            ],
          ),
        ),
        body: ContainerWidget(
            topLeftValue: AppConstants.decorationValue,
            topRightValue: AppConstants.decorationValue,
            child: Column(
              children: const [
                UserDetails(title: 'Display name', subTitle: 'Dinesh Kumar'),
                UserDetails(
                    title: 'Email address', subTitle: 'dinesh123@gmail.com'),
                UserDetails(
                    title: 'Address', subTitle: 'Salem, Mettur - 636304'),
                UserDetails(title: 'Phone number', subTitle: '+91 7339597574'),
              ],
            )));
  }
}

//SizedBox(width: MediaQuery.of(context).size.width*0.03,),