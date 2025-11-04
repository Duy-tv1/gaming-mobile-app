import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/game_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GameProvider(),
      child: MaterialApp(
        title: 'Tran Van Duy - SE183134',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          // Gaming dark theme
          scaffoldBackgroundColor: const Color(0xFF0A0E27),
          primaryColor: const Color(0xFF6C5CE7),
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFF6C5CE7),
            secondary: Color(0xFFFF6B6B),
            surface: Color(0xFF1A1E3E),
            background: Color(0xFF0A0E27),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF1A1E3E),
            centerTitle: true,
            elevation: 0,
            titleTextStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
          chipTheme: ChipThemeData(
            backgroundColor: const Color(0xFF2D3561),
            selectedColor: const Color(0xFF6C5CE7),
            labelStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: const Color(0xFF1A1E3E),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF6C5CE7)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF2D3561)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF6C5CE7), width: 2),
            ),
            prefixIconColor: const Color(0xFF6C5CE7),
            suffixIconColor: const Color(0xFF6C5CE7),
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
