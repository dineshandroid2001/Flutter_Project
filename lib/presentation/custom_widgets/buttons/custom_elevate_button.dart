import 'package:chat_box/presentation/app_constant/app_constant.dart';
import 'package:chat_box/presentation/custom_widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';

class CustomElevateButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color buttonColor;
  final Color textColor;
  const CustomElevateButton({
    super.key, 
    this.onPressed, 
    required this.text,
    this.buttonColor = AppConstants.liteColor,
    this.textColor = AppConstants.secondaryColor
    });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
      child: CustomTextWidget(
        text: text,
        fontSize: 20,
        color: textColor,
      ),
    );
  }
}
