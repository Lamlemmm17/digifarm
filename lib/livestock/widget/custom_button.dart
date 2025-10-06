import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onTap});

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        backgroundColor: const Color.fromARGB(255, 142, 200, 100),
        elevation: 5,
        side: const BorderSide(color: Colors.black),
        minimumSize: const Size(130, 40),
      ),
      child: Text(
        'ADD',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontFamily: 'OpenSans',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: const Color.fromARGB(255, 0, 0, 0),
        ),
      ),
    );
  }
}
