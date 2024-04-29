import 'package:chat_box/presentation/app_constant/app_constant.dart';
import 'package:chat_box/presentation/auth_flow/log_in.dart';
import 'package:chat_box/presentation/auth_flow/sign_up.dart';
import 'package:chat_box/presentation/custom_widgets/buttons/custom_elevate_button.dart';
import 'package:chat_box/presentation/custom_widgets/buttons/custom_icon_button.dart';
import 'package:chat_box/presentation/custom_widgets/buttons/custom_text_button.dart';
import 'package:chat_box/presentation/custom_widgets/container_widget.dart';
import 'package:chat_box/presentation/custom_widgets/custom_divider.dart';
import 'package:chat_box/presentation/custom_widgets/custom_text_widget.dart';
import 'package:chat_box/presentation/custom_widgets/sized_box.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppConstants.linearColor, AppConstants.secondaryColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBoxWidget(height: 0.05),
                const Center(
                    child: CustomTextWidget(
                  text: 'ChatBox',
                  fontSize: 25,
                )),
                SizedBoxWidget(height: 0.02),
                Column(
                  children: const [
                    CustomTextWidget(
                      text: AppConstants.appQuotes1
                    ),
                    CustomTextWidget(
                        text: AppConstants.appQuotes2, fontWeight: FontWeight.bold),
                  ],
                ),
                SizedBoxWidget(height: 0.02),
                const CustomTextWidget(
                  text: AppConstants.appQuotes3,
                  fontSize: 18,
                ),
                SizedBoxWidget(height: 0.02),
                Center(
                    child: CustomIconImage(
                        icon: Image.asset(AppConstants.googleIcon))),
                SizedBoxWidget(height: 0.02),
                const CustomDivider(),
                SizedBoxWidget(height: 0.02),
                ContainerWidget(
                    paddingValue: 18,
                    child: CustomElevateButton(
                      text: 'Sign up with Mail',
                      buttonColor: AppConstants.primaryColor,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUp()));
                      },
                    )),
                SizedBoxWidget(height: 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomTextWidget(
                      text: 'Existing account?',
                      fontSize: 18,
                    ),
                    CustomTextButton(
                      text: 'Log in',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LogIn()));
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
