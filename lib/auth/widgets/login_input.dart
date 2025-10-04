import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class LoginInput extends StatelessWidget {

  const LoginInput({
    super.key,
    required this.controller,
    this.keyboard = TextInputType.text,
    required this.label,
    this.obscure = false
  });

  final TextEditingController controller;
  final TextInputType keyboard;
  final String label;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        style: Theme.of(context).textTheme.bodyMedium,
        keyboardType: keyboard,
        obscureText: obscure,
        controller: controller,
        decoration: InputDecoration(
          floatingLabelStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
          labelStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: 18,
            color: const Color.fromARGB(255, 134, 141, 141),
            fontFamily: 'NunitoSans',
            fontWeight: FontWeight.w600,),
          labelText: label,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: const Color.fromARGB(255, 198, 198, 198),
              
              width: 1,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: const Color.fromARGB(255, 198, 198, 198),
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}