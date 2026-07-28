import 'package:flutter/material.dart';

import 'ui/splash_screen.dart';

class LogotherapyLevelsApp extends StatelessWidget {
const LogotherapyLevelsApp({super.key});

@override
Widget build(BuildContext context) {
const lightLilac = Color(0xFFD8B4FE);
const almostWhiteLilac = Color(0xFFF5F3FF);
const darkLilac = Color.fromARGB(255, 167, 85, 214);
const deepPurple = Color.fromARGB(255, 35, 8, 63);

final colorScheme = ColorScheme.fromSeed(
seedColor: darkLilac,
brightness: Brightness.light,
).copyWith(
primary: deepPurple,
secondary: darkLilac,
surface: Colors.white,
surfaceContainerHighest: almostWhiteLilac,
);

return MaterialApp(
debugShowCheckedModeBanner: false,
title: 'Put smisla',
theme: ThemeData(
useMaterial3: true,
colorScheme: colorScheme,
scaffoldBackgroundColor: almostWhiteLilac,
appBarTheme: const AppBarTheme(
backgroundColor: darkLilac,
foregroundColor: Colors.white,
centerTitle: true,
elevation: 0,
titleTextStyle: TextStyle(
fontSize: 22,
fontWeight: FontWeight.w900,
color: Colors.white,
),
iconTheme: IconThemeData(color: Colors.white),
),
textTheme: const TextTheme(
headlineSmall: TextStyle(
fontSize: 36,
fontWeight: FontWeight.w900,
color: deepPurple,
letterSpacing: 0.8,
),
titleLarge: TextStyle(
fontSize: 27,
fontWeight: FontWeight.w900,
color: deepPurple,
),
titleMedium: TextStyle(
fontSize: 21,
fontWeight: FontWeight.w900,
color: deepPurple,
),
bodyLarge: TextStyle(
fontSize: 19,
height: 1.5,
color: deepPurple,
),
bodyMedium: TextStyle(
fontSize: 17,
height: 1.45,
color: deepPurple,
),
),
filledButtonTheme: FilledButtonThemeData(
style: FilledButton.styleFrom(
backgroundColor: deepPurple,
foregroundColor: Colors.white,
padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(25),
),
textStyle: const TextStyle(
fontSize: 18,
fontWeight: FontWeight.w900,
),
),
),
outlinedButtonTheme: OutlinedButtonThemeData(
style: OutlinedButton.styleFrom(
foregroundColor: deepPurple,
side: const BorderSide(color: darkLilac, width: 1.6),
padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(25),
),
textStyle: const TextStyle(
fontSize: 17,
fontWeight: FontWeight.w800,
),
),
),
inputDecorationTheme: InputDecorationTheme(
filled: true,
fillColor: almostWhiteLilac,
labelStyle: const TextStyle(
color: deepPurple,
fontWeight: FontWeight.w800,
fontSize: 17,
),
prefixIconColor: darkLilac,
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(22),
borderSide: BorderSide.none,
),
enabledBorder: OutlineInputBorder(
borderRadius: BorderRadius.circular(22),
borderSide: const BorderSide(
color: lightLilac,
width: 1.4,
),
),
focusedBorder: OutlineInputBorder(
borderRadius: BorderRadius.circular(22),
borderSide: const BorderSide(
color: deepPurple,
width: 2.2,
),
),
),
),
home: const SplashScreen(),
);
}
}
