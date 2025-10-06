import 'package:flutter/material.dart';

class FlockScreen extends StatelessWidget{
  const FlockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Image.asset('assets/images/logo.png'),
      ),
    );
  }
}