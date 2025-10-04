import 'package:digifarm/auth/widgets/login_button.dart';
import 'package:digifarm/auth/widgets/login_input.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
              SizedBox(height: 40,),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    LoginInput(
                      controller: _emailController,
                      keyboard: TextInputType.emailAddress,
                      label: 'Email Address',
                    ),
                    LoginInput(
                      controller: _passwordController,
                      label: 'Password',
                      keyboard: TextInputType.visiblePassword,
                      obscure: true,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 220),
              LoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}
