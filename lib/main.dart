
import 'package:chat_box/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:chat_box/presentation/app_constant/app_constant.dart';
import 'package:chat_box/presentation/home_page/home_page.dart';
import 'package:chat_box/presentation/splash_screen/splash_screen.dart';
import 'package:chat_box/presentation/welcome_screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_box/data/models/firebase_user.dart';
import 'blocs/bloc_observer/bloc_observer.dart';
import 'blocs/sign_in_bloc/sign_in_bloc.dart';
import 'data/models/user_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));

  Future.delayed(const Duration(seconds: 3), () {
    runApp(MyApp(FirebaseUserRepo()));
  });
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  const MyApp(
    this.userRepository, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc(userRepository: userRepository),
      child: const MyAppView(),
    );
  }
}

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: AppConstants.secondaryColor
      ),
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            return BlocProvider(
              create: (context) => SignInBloc(
                  userRepository:
                      context.read<AuthenticationBloc>().userRepository),
              child: const HomePage(),
            );
          } else if (state.status == AuthenticationStatus.unknown) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return const WelcomeScreen();
          }
        }));
  }
}
