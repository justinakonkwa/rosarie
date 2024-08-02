import 'package:flutter/material.dart';
import 'package:holy_rosarie/models/prayers.dart';
import 'package:holy_rosarie/providers/mystery_provider.dart';
import 'package:holy_rosarie/providers/prayer_provider.dart';
import 'package:holy_rosarie/screens/home_screen.dart';
import 'package:holy_rosarie/screens/main_screen.dart';
import 'package:holy_rosarie/screens/prayer_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MysteryProvider()),
        ChangeNotifierProvider(create: (_) => PrayerProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Saint Rosaire',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => MainPage(),
          '/home': (context) => HomeScreen(),
          // '/mystery':(context)=> MysteryScreen(mystery: );

        },
      ),
    );
  }
}
