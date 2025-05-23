import 'package:flutter/material.dart';
import 'package:nti_r2/core/utils/app_colors.dart';

class TestNavBar extends StatefulWidget {
  const TestNavBar({super.key});

  @override
  State<TestNavBar> createState() => _TestNavBarState();
}

class _TestNavBarState extends State<TestNavBar> {
  int currentIndex = 0;
  List<Widget> screens = [
    LocationTest(),
    HomeTest(),
    ProfileTest(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.grey,
        onTap: (int index)
        {
          setState(() {
            currentIndex = index;
          });
        },
        items:
        [
          BottomNavigationBarItem(icon: Icon(Icons.location_on_outlined),
              label: 'location'),
          BottomNavigationBarItem(icon: Icon(Icons.home),
              label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person),
              label: 'Profile'),
        ]
      ),
    );
  }
}
class ProfileTest extends StatelessWidget {
  const ProfileTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Profile"),
    );
  }
}

class HomeTest extends StatelessWidget {
  const HomeTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("HomeTest"),
    );
  }
}
class LocationTest extends StatelessWidget {
  const LocationTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("LocationTest"),
    );
  }
}
