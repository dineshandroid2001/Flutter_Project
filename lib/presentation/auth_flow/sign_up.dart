import 'package:chat_box/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:chat_box/presentation/app_constant/app_constant.dart';
import 'package:chat_box/presentation/custom_widgets/buttons/custom_elevate_button.dart';
import 'package:chat_box/presentation/custom_widgets/container_widget.dart';
import 'package:chat_box/presentation/custom_widgets/custom_app_bar.dart';
import 'package:chat_box/presentation/custom_widgets/text_field.dart';
import 'package:chat_box/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_box/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:chat_box/presentation/custom_widgets/custom_text_widget.dart';
import 'package:chat_box/presentation/custom_widgets/sized_box.dart';
import 'log_in.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(
          userRepository: context.read<AuthenticationBloc>().userRepository),
      child: const SignUpForm(),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final namecontrol = TextEditingController();
  final emailcontrol = TextEditingController();
  final passwordcontrol = TextEditingController();
  final repasswordcontrol = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const LogIn()));
        } else if (state is SignUpFailure) {
          const snackFailure = SnackBar(
            content: Text(
              AppConstants.invalidAlert1,
              style: TextStyle(color: AppConstants.warningColor, fontSize: 18),
            ),
            backgroundColor: AppConstants.primaryColor,
            behavior: SnackBarBehavior.floating,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackFailure);
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          backArrow: true,
          appBarColor: AppConstants.primaryColor,
          backArrowColor: AppConstants.secondaryColor,
        ),
        backgroundColor: AppConstants.primaryColor,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBoxWidget(height: 0.05),
                const Center(
                  child: CustomTextWidget(
                      text: AppConstants.signUpQuotes,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: AppConstants.secondaryColor),
                ),
                SizedBoxWidget(height: 0.02),
                const CustomTextWidget(
                    text: AppConstants.signUpQuotes1,
                    fontSize: 18,
                    color: AppConstants.secondaryColor),
                SizedBoxWidget(height: 0.005),
                const CustomTextWidget(
                    text: AppConstants.signUpQuotes2,
                    fontSize: 18,
                    color: AppConstants.secondaryColor),
                SizedBoxWidget(height: 0.02),
                CustomTextField(
                  controller: namecontrol,
                  labelText: 'Your Name',
                  obscureText: false,
                ),
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
                SizedBoxWidget(height: 0.02),
                CustomTextField(
                  controller: repasswordcontrol,
                  labelText: 'Confirm Password',
                  obscureText: true,
                  isPassword: true,
                  isConfirmPassword: true,
                ),
                SizedBoxWidget(height: 0.1),
                ContainerWidget(
                    paddingValue: 10,
                    child: CustomElevateButton(
                      text: AppConstants.saveAccount,
                      onPressed: () {
                        final isValid = _formKey.currentState?.validate();
                        if (isValid!) {
                          MyUser myUser = MyUser.empty;
                          myUser = myUser.copyWith(
                            name: namecontrol.text,
                            email: emailcontrol.text,
                          );
                          context.read<SignUpBloc>().add(
                              SignUpRequired(myUser, passwordcontrol.text));
                        } else {
                          return;
                        }
                      },
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
