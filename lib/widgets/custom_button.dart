import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key, 
    required this.onTap, 
    required this.isLoading,
    this.color = const Color.fromARGB(255, 142, 200, 100),
    this.size = const Size(130, 40),
    this.fontSize = 18,
    this.text = 'ADD'});

  final void Function() onTap;
  final bool isLoading;
  final Color? color;
  final Size? size;
  final double? fontSize;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        backgroundColor: color,
        elevation: 5,
        side: const BorderSide(color: Colors.black),
        minimumSize: size,
      ),
      child: 
      isLoading ? 
      SizedBox(
        width: 15,
        height: 15,
        child: CircularProgressIndicator())
      :
      Text(
        text!,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontFamily: 'OpenSans',
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color.fromARGB(255, 0, 0, 0),
        ),
      ),
    );
  }
}
