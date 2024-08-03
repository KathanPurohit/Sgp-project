import 'package:flutter/material.dart';
import 'package:flutter_application_2/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_application_2/screens/home/views/home_screen.dart';
import 'package:flutter_application_2/screens/auth/views/welcome_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Canteen Work',
      debugShowCheckedModeBanner: false,
          theme: ThemeData(colorScheme: ColorScheme.light
          (background: Colors.grey.shade200, 
          onBackground: Colors.black,
          primary:Colors.blue,
          onPrimary: Colors.white)),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: ((context, state) {
            if (state.status == AuthenticationStatus.authenticated) {
              return const HomeScreen();
            }else {
             return const WelcomeScreen();
            }
  }),
        
        )
    );
   
  }
}