import 'package:flutter/material.dart';

import 'home_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int selectedIndex = 0;

  buildScreens(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const Center(
          child: Text(
            'Categories',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(95, 163, 182, 1)),
          ),
        );
      case 2:
        return const Center(
          child: Text(
            'Search',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(95, 163, 182, 1)),
          ),
        );
      case 3:
        return const Center(
          child: Text(
            'Favorite',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(95, 163, 182, 1)),
          ),
        );
      case 4:
        return const Center(
          child: Text(
            'Profile',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(95, 163, 182, 1)),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(244, 249, 250, 1),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          backgroundColor: Colors.white,
          selectedItemColor: const Color.fromRGBO(95, 163, 182, 1),
          unselectedItemColor: const Color.fromARGB(255, 165, 220, 235),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.dashboard_outlined,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search_outlined,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite_outline,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_outline,
                ),
                label: ''),
          ]),
      body: buildScreens(selectedIndex),
    );
  }
}
