import 'package:digifarm/home/screen/menu_screen.dart';
import 'package:digifarm/home/screen/profile_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  var _currentIndex = 1;
  final _pageController = PageController(initialPage: 1);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Image.asset('assets/images/logo.png'),
      ),
      body: PageView( //Untuk pake swipe gesture
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [const ProfileScreen(), const MenuScreen()],
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(85, 50, 45, 45),
              blurRadius: 20,
              spreadRadius: 1,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              });
            },
            items: [
              BottomNavigationBarItem(
                // selectedItemColor: const Color.fromARGB(255, 109, 199, 198),
                icon: Image.asset(
                  'assets/images/profile.png',
                  height: 35,
                  width: 35,
                  color: _currentIndex == 1 ? const Color.fromARGB(255, 0, 0, 0) : const Color.fromARGB(255, 109, 199, 198) ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/menu.png',
                  height: 35,
                  width: 35,
                  color: _currentIndex == 0 ? const Color.fromARGB(255, 0, 0, 0) : const Color.fromARGB(255, 109, 199, 198) ),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
