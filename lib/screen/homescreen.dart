import 'package:flutter/material.dart';
import 'package:tws/fragment/MyClient.dart';
import 'package:tws/screen/account.dart';
import 'package:tws/screen/appointment.dart';
import 'package:tws/screen/feeds.dart';
import 'package:tws/screen/workout.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final _widgetOptios = [
    MyClient(),
    WorkOut(),
    AppointmentScreen(),
    Feeds(),
    AccountFragment()
  ];

  @override
  Widget build(Object context) {
    return Scaffold(
      body: Center(
        child: _widgetOptios.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/cleint.png",
                width: 34,
                height: 31,
              ),
              label: 'Clients'),
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/gallery.png",
                width: 34,
                height: 31,
              ),
              label: 'Gallery'),
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/appointment.png",
                width: 34,
                height: 31,
              ),
              label: 'Appointments'),
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/feeds.png",
                width: 34,
                height: 31,
              ),
              label: 'Feeds'),
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/account.png",
                width: 34,
                height: 31,
              ),
              label: 'Account'),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.blue,
        onTap: onItemTapped,
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
