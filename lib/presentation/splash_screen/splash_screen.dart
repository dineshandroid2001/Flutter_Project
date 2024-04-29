// ignore_for_file: library_private_types_in_public_api

import 'package:chat_box/presentation/app_constant/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:chat_box/presentation/custom_widgets/custom_text_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppConstants.splash),
            const CustomTextWidget(
                text: 'Chatbox',
                fontSize: 60,
                color: AppConstants.secondaryColor,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ],
        ),
      ),
    );
  }
}
