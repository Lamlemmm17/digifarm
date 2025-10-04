import 'package:flutter/material.dart';

class ProfileInput extends StatelessWidget {
  const ProfileInput({
    super.key,
    required this.controller,
    this.keyboard = TextInputType.text,
    this.read = false,
    required this.label,
    required this.hint,
    this.validator,
  });

  final TextInputType keyboard;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final String label;
  final String hint;
  final bool read;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        style: Theme.of(context).textTheme.bodyMedium,
        readOnly: read,
        keyboardType: keyboard,
        autovalidateMode: AutovalidateMode.onUnfocus,
        controller: controller,
        decoration: InputDecoration(
          floatingLabelStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
          labelText: label,
          hintText: hint,
          filled: true,
          fillColor: const Color.fromARGB(201, 201, 227, 227),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: const Color.fromARGB(255, 198, 198, 198),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: const Color.fromARGB(255, 198, 198, 198),
              width: 1,
            ),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
