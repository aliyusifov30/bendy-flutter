import 'package:flutter/material.dart';

import '../home/presentation/home_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int currentIndex = 0;

  final pages = [
    const HomePage(),
    const Placeholder(),
    const Placeholder(),
    const Placeholder(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: pages[currentIndex],
      ),

      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(0.08),
            )
          ],
        ),

        child: BottomNavigationBar(
          currentIndex: currentIndex,

          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },

          type: BottomNavigationBarType.fixed,

          backgroundColor: Colors.transparent,

          elevation: 0,

          selectedItemColor: const Color(0xFF1565C0),

          unselectedItemColor: Colors.grey,

          items: const [

            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: "Home",
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.build_rounded),
              label: "Services",
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_rounded),
              label: "Products",
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: "Contact",
            ),
          ],
        ),
      ),
    );
  }
}