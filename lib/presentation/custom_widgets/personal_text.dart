import 'package:chat_box/presentation/app_constant/app_constant.dart';
import 'package:chat_box/presentation/custom_widgets/container_widget.dart';
import 'package:chat_box/presentation/custom_widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';

class PersonalText extends StatelessWidget {
  final String text;
  const PersonalText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: ContainerWidget(
          colors: AppConstants.liteColor,
          paddingValue: 10,
          topLeftValue: 10,
          bottomLeftValue: 10,
          bottomRightValue: 10,
          child: CustomTextWidget(text: text, fontSize: 15)),
    );
  }
}
