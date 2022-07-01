import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData lightMode = ThemeData(
  drawerTheme: const DrawerThemeData(
    backgroundColor: Colors.white,
    elevation: 30.0,
  ),
  scaffoldBackgroundColor: Colors.white,
  brightness: Brightness.light,
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: Colors.black,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    elevation: 30.0,
    selectedItemColor: Colors.deepOrange,
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.fixed,
  ),
  primarySwatch: Colors.blue,
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headline5: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headline6: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  ),
  appBarTheme: const AppBarTheme(
    //titleSpacing: 20.0,
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
);


///////////////////////////////////////////////////////////

ThemeData darkMode = ThemeData(
  drawerTheme:  DrawerThemeData(
    backgroundColor: HexColor('333739'),
    elevation: 30.0,
  ),
  scaffoldBackgroundColor: HexColor('333739'),
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: HexColor('333739'),
    elevation: 30.0,
    selectedItemColor: Colors.deepOrange,
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.fixed,
  ),
  primarySwatch: Colors.deepOrange,
  brightness: Brightness.dark,
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headline5: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headline6: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
  appBarTheme:  AppBarTheme(
    //titleSpacing: 20.0,
    backgroundColor: HexColor('333739'),
    elevation: 0.0,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
    ),
  ),
);