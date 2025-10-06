import 'package:flutter/material.dart';

class ActivityScreen extends StatelessWidget{
  const ActivityScreen({super.key});

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