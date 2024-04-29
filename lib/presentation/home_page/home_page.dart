import 'package:chat_box/presentation/app_constant/app_constant.dart';
import 'package:chat_box/presentation/buttom_navbar/calls.dart';
import 'package:chat_box/presentation/buttom_navbar/contacts.dart';
import 'package:chat_box/presentation/buttom_navbar/message.dart';
import 'package:chat_box/presentation/buttom_navbar/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_box/blocs/chat_bloc.dart';
import 'package:chat_box/blocs/sign_in_bloc/sign_in_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(0),
      child: const HomePageContent(),
    );
  }
}

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Chat Box'),
            backgroundColor: AppConstants.secondaryColor,
            actions: [
              IconButton(
                  onPressed: () {
                    context.read<SignInBloc>().add(const SignOutRequired());
                  },
                  icon: const Icon(Icons.logout)),
            ],
          ),
          body: _buildNavTypes(currentIndex),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppConstants.bottomColor,
            onTap: (value) {
              context.read<ChatBloc>().setIndex(value);
            },
            currentIndex: currentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.message),
                label: 'Message',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.call),
                label: 'Calls',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.contacts_rounded),
                label: 'Contacts',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNavTypes(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return const MessageNav();
      case 1:
        return const CallsNav();
      case 2:
        return const ContactNav();
      case 3:
        return const SettingNav();
      default:
        return const MessageNav();
    }
  }
}

