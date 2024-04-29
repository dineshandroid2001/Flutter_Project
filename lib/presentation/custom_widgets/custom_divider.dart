import 'package:chat_box/presentation/app_constant/app_constant.dart';
import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Expanded(
          child: Divider(
            color: AppConstants.primaryColor,
            indent: 20,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'OR',
            style: TextStyle(
              color: AppConstants.primaryColor,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: AppConstants.primaryColor,
            endIndent: 20,
          ),
        ),
      ],
    );
  }
}
