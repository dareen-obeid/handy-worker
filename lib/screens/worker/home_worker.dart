import 'package:flutter/material.dart';
import 'package:handyworker/screens/worker/profile_worker.dart';

import '../NavigationBarItem/home.dart';
import '../NavigationBarItem/notification.dart';
import '../NavigationBarItem/search.dart';



class HomeWorker extends StatefulWidget {
  const HomeWorker({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeWorkerState createState() => _HomeWorkerState();
}

class _HomeWorkerState extends State<HomeWorker> {
  List pages = [
    const HomePage(),
    const SearchPage(),
    const NotificationPage(),
    const ProfileWorker(),
  ];
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Image.asset(
                  'images/worker-icon.png',
                  width: 24.09,
                  height: 24.09,
                ),
                const SizedBox(width: 8),
                const Text(
                  "Handy Worker",
                  style: TextStyle(color: Color(0xff00abb3)),
                ),
              ],
            ),
            IconButton(
              icon: const SizedBox(
                width: 32,
                height: 32,
                child: Icon(Icons.favorite_border, color: Colors.black),
              ),
              onPressed: () {
                // add favorite functionality here
              },
            ),
          ],
        ),
      ),
      body:
       pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTap,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        fixedColor: const Color(0xff00abb3),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 25,
        unselectedFontSize: 0,
        selectedFontSize: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
            ),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
