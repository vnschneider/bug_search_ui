// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData themeData = ThemeData(
  unselectedWidgetColor: const Color.fromARGB(255, 145, 100, 200),
  textTheme: TextTheme(
    displayLarge: GoogleFonts.poppins(
                      textStyle: const TextStyle(color: Color(0xff4766EA)),
                      fontSize: 58,

                      fontWeight: FontWeight.w600,
                      //fontStyle: FontStyle.italic,
                    ), 
    headlineLarge: GoogleFonts.paytoneOne(
      textStyle: const TextStyle(
        color: Color(0xff4766EA),
      ),
      fontSize: 58,
      fontWeight: FontWeight.bold,
      //fontStyle: FontStyle.italic,
    ),
    headlineMedium: GoogleFonts.poppins(
      textStyle: const TextStyle(color: Color(0xffFAFAFB)),
      fontSize: 18,
      fontWeight: FontWeight.w400,
      //fontStyle: FontStyle.italic,
    ),
    titleLarge: GoogleFonts.poppins(
      textStyle: const TextStyle(color: Color(0xffFAFAFB)),
      fontSize: 18,
      fontWeight: FontWeight.w400,
      //fontStyle: FontStyle.italic,
    ),
    titleMedium: GoogleFonts.poppins(
      textStyle: const TextStyle(color: Color(0xffFAFAFB)),
      fontSize: 16,
      fontWeight: FontWeight.w300,
      //fontStyle: FontStyle.italic,
    ),
    titleSmall: GoogleFonts.poppins(
      textStyle: const TextStyle(color: Color(0xffFAFAFB)),
      fontSize: 14,
      fontWeight: FontWeight.w200,
      //fontStyle: FontStyle.italic,
    ),
  ),
  indicatorColor: const Color(0xffFAFAFB),
  textButtonTheme: const TextButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)))),
      textStyle: MaterialStatePropertyAll<TextStyle>(TextStyle(
        color: Color(0xffFAFAFB),
        fontFamily: 'Poppins',
        fontSize: 18,
        //fontWeight: FontWeight.bold,
        //fontStyle: FontStyle.italic,
      )),
      surfaceTintColor: MaterialStatePropertyAll<Color>(Color(0xffFAFAFB)),
      backgroundColor: MaterialStatePropertyAll<Color>(Color(0xff4766EA)),
      overlayColor: MaterialStatePropertyAll<Color>((Color(0xff848FFF))),
    ),
  ),
  //buttonBarTheme: ButtonBarThemeData(),
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: Color(0xff848FFF),
    selectionHandleColor: Color(0xffFAFAFB),
    cursorColor: Color(0xffFAFAFB),
  ),

  useMaterial3: true,
  //light scheme
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xff4766EA),
    onPrimary: Color(0xffFAFAFB),
    secondary: Color(0xff657AFF),
    onSecondary: Color(0xffFAFAFB),
    tertiary: Color(0xff848FFF),
    error: Color.fromARGB(255, 186, 26, 26),
    onError: Color.fromARGB(255, 255, 218, 214),
    background: Color(0xffFAFAFB),
    onBackground: Color(0xff4766EA),
    surface: Color(0xffFAFAFB),
    onSurface: Color(0xffFAFAFB),
  ),
);
