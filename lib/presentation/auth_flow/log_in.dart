import 'package:chat_box/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:chat_box/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:chat_box/presentation/app_constant/app_constant.dart';
import 'package:chat_box/presentation/custom_widgets/buttons/custom_elevate_button.dart';
import 'package:chat_box/presentation/custom_widgets/buttons/custom_icon_button.dart';
import 'package:chat_box/presentation/custom_widgets/buttons/custom_text_button.dart';
import 'package:chat_box/presentation/custom_widgets/container_widget.dart';
import 'package:chat_box/presentation/custom_widgets/custom_app_bar.dart';
import 'package:chat_box/presentation/custom_widgets/custom_divider.dart';
import 'package:chat_box/presentation/custom_widgets/text_field.dart';
import 'package:chat_box/presentation/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_box/presentation/custom_widgets/custom_text_widget.dart';
import 'package:chat_box/presentation/custom_widgets/sized_box.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInBloc>(
      create: (context) => SignInBloc(
          userRepository: context.read<AuthenticationBloc>().userRepository),
      child: const SignInForm(),
    );
  }
}

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final emailcontrol = TextEditingController();
  final passwordcontrol = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is SignInSuccess) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        } else if (state is SignInFailure) {
          const snackFailure = SnackBar(
            content: Text(
              AppConstants.invalidAlert2,
              style: TextStyle(color: AppConstants.warningColor, fontSize: 18),
            ),
            backgroundColor: AppConstants.primaryColor,
            behavior: SnackBarBehavior.fixed,
            elevation: 0.0,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackFailure);
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          backArrow: true,
          backArrowColor: AppConstants.secondaryColor,
          appBarColor: AppConstants.primaryColor,
        ),
        backgroundColor: AppConstants.primaryColor,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBoxWidget(height: 0.1),
                const Center(
                  child: CustomTextWidget(
                      text: AppConstants.logInQuotes,
                      fontSize: 25,
                      color: AppConstants.secondaryColor,
                      fontWeight: FontWeight.bold),
                ),
                SizedBoxWidget(height: 0.02),
                const CustomTextWidget(
                    text: AppConstants.logInQuotes1,
                    fontSize: 20,
                    color: AppConstants.secondaryColor),
                const CustomTextWidget(
                    text: AppConstants.logInQuotes2,
                    fontSize: 20,
                    color: AppConstants.secondaryColor),
                SizedBoxWidget(height: 0.02),
                CustomIconImage(
                  icon: Image.asset(
                    AppConstants.googleIcon,
                  ),
                ),
                SizedBoxWidget(height: 0.02),
                const CustomDivider(),
                SizedBoxWidget(height: 0.02),
                CustomTextField(
                  controller: emailcontrol,
                  labelText: 'Email Id',
                  obscureText: false,
                ),
                SizedBoxWidget(height: 0.02),
                CustomTextField(
                  controller: passwordcontrol,
                  labelText: 'Password',
                  obscureText: true,
                  isPassword: true,
                ),
                SizedBoxWidget(height: 0.12),
                Column(children: [
                  ContainerWidget(
                      paddingValue: 10,
                      child: CustomElevateButton(
                        onPressed: () {
                          final isValid = _formKey.currentState?.validate();
                          if (isValid!) {
                            context.read<SignInBloc>().add(SignInRequired(
                                emailcontrol.text, passwordcontrol.text));
                          } else {
                            return;
                          }
                        },
                        text: 'Log in',
                      )),
                  const CustomTextButton(
                    text: 'Forgot password?',
                    color: AppConstants.liteColor,
                  )
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
