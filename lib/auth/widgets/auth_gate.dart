import 'package:digifarm/auth/provider/login_provider.dart';
import 'package:digifarm/auth/screen/login_screen.dart';
import 'package:digifarm/home/screen/home_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthGate extends ConsumerWidget{
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user){
        if (user == null) {
          return const LoginScreen();
        }
        return const HomeScreen();
      }, 
      error: (error, stackTrace) {
        return Scaffold(
          body: Center(
            child: Text(
              'Error :$error',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black),),
          ),
        );
      },
      loading: () {
        return Scaffold(
          body: Center(
            child: SizedBox(height: 100, width: 100, child: Image.asset('assets/images/logo.png')),
          ),
        );
      }
  );
}}