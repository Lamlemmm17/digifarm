
import 'package:digifarm/auth/provider/login_provider.dart';
import 'package:digifarm/auth/widgets/login_button.dart';
import 'package:digifarm/auth/widgets/login_input.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String _email = '';
  String _password = '';

  final _formKey = GlobalKey<FormState>();

  void _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    try {
      await ref.read(loginProvider.notifier).signIn(_email, _password);
    } on FirebaseAuthException catch (error) {
      if (mounted) {
      String message = '${error.code}, Email atau Password salah! ';

        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: 
        Text('Terjadi Kesalahan: $error')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Image.asset('assets/images/logo.png'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 80 + keyboardSpace),
          child: Column(
            children: [
              SizedBox(height: 50),
              Center(
                child: Text(
                  'Sign In',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 27,
                    color: const Color.fromARGB(255, 31, 130, 69),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    LoginInput(
                      initValue: _email,
                      keyboard: TextInputType.emailAddress,
                      label: 'Email Address',
                      validator: (value) {
                        if (value == null ||
                            !value.contains('@') ||
                            value.trim().isEmpty) {
                          return 'Alamat email tidak valid.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _email = value!.trim();
                      },
                    ),
                    LoginInput(
                      initValue: _password,
                      label: 'Password',
                      keyboard: TextInputType.visiblePassword,
                      obscure: true,
                      validator: (value) {
                        if (value == null || value.trim().length < 6) {
                          return 'Minimal 6 karakter';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _password = value!.trim();
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 220),
              LoginButton(
                onTap: _submit,
                isLoading: ref.watch(loginProvider).isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
