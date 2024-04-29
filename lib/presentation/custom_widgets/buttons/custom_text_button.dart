import 'package:chat_box/presentation/app_constant/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:chat_box/presentation/custom_widgets/custom_text_widget.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color color;
  const CustomTextButton({
    super.key, 
    this.onPressed,
    required this.text,
    this.color = AppConstants.primaryColor
    });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: CustomTextWidget(
          text: text, 
          fontSize: 18, 
          fontWeight: FontWeight.bold,
          color: color,
          ),
    );
  }
}
