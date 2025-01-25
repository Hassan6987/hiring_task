import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hiring_task/BusinessLogic/home%20bloc/home_bloc.dart';
import 'package:hiring_task/Screens/sign_up_screen.dart';
import 'package:hiring_task/repository/auth_repository.dart';


import 'BusinessLogic/Auth/auth_bloc.dart';
import 'Model/User.dart';
import 'Screens/home_screen.dart';
import 'Screens/login_screen.dart';
import 'Screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(authRepository: AuthRepository()),
        ),
        BlocProvider(
          create: (_) => HomeBloc(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
      ),
    );



  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      name: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      name: '/login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/signUp',
      name: 'signUp',
      builder: (context, state) {
        return SignUpScreen();
      },
    ),
    GoRoute(
      path: '/home',
      name: '/',
      builder: (context, state) {
        final User user= state.extra as User;
        return HomeScreen(user: user);
      },
    ),
  ],
);
