import 'package:flutter/material.dart';

class LightTheme {
  static var theme = ThemeData(
   brightness: Brightness.light,
    colorScheme: ColorScheme.fromSwatch().copyWith(
     secondary: const Color(0xFFfbcd22),
     tertiary: const Color(0xFF082d3d),
     primary: const Color(0xFF1183b7),
     surface: const Color(0xFFf9f9f9),
      surfaceDim: Colors.grey[400],
    )




  );
}


class DarkTheme {
 static var theme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  useMaterial3: true,

 );
}
