import 'package:chat_box/presentation/app_constant/app_constant.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Icon icon;
  final VoidCallback? onPressed;
  final double iconSize;
  final Color iconColor;
  const CustomIconButton(
      {super.key,
      required this.icon,
      this.onPressed,
      this.iconSize = 30,
      this.iconColor = AppConstants.liteColor});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: icon,
      iconSize: iconSize,
      color: iconColor,
    );
  }
}

class CustomIconImage extends StatelessWidget {
  final Image icon;
  const CustomIconImage({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: () {}, icon: icon);
  }
}
