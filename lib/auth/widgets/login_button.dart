import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key, required this.isLoading, required this.onTap});

  final bool isLoading;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: const Color.fromARGB(255, 142, 200, 100),
        minimumSize: Size(320, 60),
        elevation: 5
      ),
      child: 
      !isLoading ? 
      Text(
        'LOGIN',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontFamily: 'OpenSans',
          fontSize: 27,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ) :
      SizedBox(height: 30, width: 30, child: CircularProgressIndicator())
    );
  }
}
