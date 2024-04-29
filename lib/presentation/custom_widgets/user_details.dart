import 'package:chat_box/presentation/app_constant/app_constant.dart';
import 'package:chat_box/presentation/custom_widgets/sized_box.dart';
import 'package:flutter/material.dart';
import 'custom_text_widget.dart';

class UserDetails extends StatelessWidget {
  final String title;
  final String subTitle;
  const UserDetails({super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        title: CustomTextWidget(
            text: title, fontSize: 17, color: AppConstants.dividerColor),//const Color(0xFF767c7b)
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBoxWidget(height: 0.01),
            CustomTextWidget(
                text: subTitle, fontSize: 20, color:AppConstants.secondaryColor,
      ),
          ],
        ),
      ),
    );
  }
}
