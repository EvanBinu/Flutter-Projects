import 'package:flutter/material.dart';
import 'screens/input_page.dart';
void main() => runApp(BMICalculator());

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,  // Enables Material 3 styling
        colorScheme: const ColorScheme.dark().copyWith(
          primary: Color(0xFF0A0E21),
        ),
        scaffoldBackgroundColor: const Color(0xFF0A0E21),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0A0E21),  // Matches primary color
          elevation: 4,  // Adds shadow effect
          centerTitle: true,  // Centers title text
          titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,  // Ensures contrast
            shadows: [
              Shadow(
                color: Colors.black54,
                offset: Offset(2, 2),
                blurRadius: 4,
              ),
            ],
          ),
          iconTheme: IconThemeData(
            color: Colors.white, // Ensures icons are visible
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.purple,  // Sets FAB background color
          foregroundColor: Colors.white,  // Sets icon color
          elevation: 6,  // Adds shadow effect
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)), // Makes it slightly rounded
          ),
        ),
      ),
      home: InputPage(),
    );
  }
}

