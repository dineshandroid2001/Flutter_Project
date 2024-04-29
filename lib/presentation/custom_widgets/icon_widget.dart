import 'package:chat_box/presentation/app_constant/app_constant.dart';
import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  final Icon icon;
  final double size;
  final Color colors;
  const IconWidget({
    super.key,
    required this.icon,
    this.colors = AppConstants.primaryColor,
    this.size = 33
    });

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon.icon,
      color: colors,
      size: size,      
    );
  }
}