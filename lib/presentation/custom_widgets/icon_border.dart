import 'package:chat_box/presentation/app_constant/app_constant.dart';
import 'package:flutter/material.dart';

class IconBorder extends StatelessWidget {
  final Icon icon;
  final Color colors;
  const IconBorder({super.key,required this.icon,required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
          width: 40,
          height: 40,
          decoration:BoxDecoration(
            shape: BoxShape.circle,
            color: colors,
          ),
          child: Icon(icon.icon,color: AppConstants.primaryColor,size: 25,));
  }
}
//color: Color(0xFF797C7B)