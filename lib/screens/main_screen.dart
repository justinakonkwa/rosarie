// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:holy_rosarie/screens/home_screen.dart';
import 'package:holy_rosarie/screens/meditation_screen.dart';
import 'package:holy_rosarie/screens/settings_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    MeditationScreen(),
    MyHomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _widgetOptions.elementAt(currentIndex),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                width: 1,
              ),
            ),
          ),
          child: BottomNavigationBar(
            backgroundColor: Theme.of(context).colorScheme.background,
            selectedItemColor: Theme.of(context).colorScheme.onBackground,
            elevation: 0,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            unselectedIconTheme: IconThemeData(color: Colors.grey),
            currentIndex: currentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.house_alt,
                ),
                label: ('Home'),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.layers_alt,
                ),
                label: ('Meditation'),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.settings,
                ),
                label: ('Setting'),
              ),
            ],
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        )
        // : null,
        );
  }
}
