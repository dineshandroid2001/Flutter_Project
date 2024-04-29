import 'package:chat_box/presentation/app_constant/app_constant.dart';
import 'package:flutter/material.dart';

class AttachFile extends StatelessWidget {
  final Icon icon;
  final String title;
  final String subTitle;
  final VoidCallback? onPressed;
  const AttachFile({super.key,required this.icon, required this.title, required this.subTitle,this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      leading: Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color:AppConstants.liteWhiteColor,
          ),
          child: Icon(icon.icon)),
      title: Text(title),
      subtitle: Text(subTitle),
    );
  }
}

