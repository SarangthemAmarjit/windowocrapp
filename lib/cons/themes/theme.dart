import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final themedata = ThemeData(
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        visualDensity: VisualDensity.standard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.grey,
        textStyle: GoogleFonts.ralewayTextTheme().bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: Colors.grey[300], // clean background
      surfaceTintColor: Colors.transparent,
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.05),

      // Flat rectangle corners
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),

      // Selected day (blue background, white text)
      dayBackgroundColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.blue;
        }
        return Colors.transparent;
      }),
      dayForegroundColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.white;
        }
        return Colors.grey[900]!;
      }),

      // Today’s date with subtle border
      todayBackgroundColor: WidgetStateColor.resolveWith((c) => Colors.transparent),
      todayBorder: BorderSide(color: Colors.blue, width: 1.2),

      // Range selection
      rangeSelectionBackgroundColor:
          WidgetStateColor.resolveWith((c) => Colors.blue.withOpacity(0.15)),
      rangeSelectionOverlayColor: WidgetStateColor.resolveWith((c) => Colors.blue.withOpacity(0.2)),

      // Buttons
      cancelButtonStyle: ButtonStyle(
        foregroundColor: WidgetStateColor.resolveWith((e) => Colors.grey[700]!),
      ),
      confirmButtonStyle: ButtonStyle(
        foregroundColor: WidgetStateColor.resolveWith((e) => Colors.white),
        backgroundColor: WidgetStateColor.resolveWith((e) => Colors.blue),
      ),
    ),
    textTheme: GoogleFonts.interTextTheme(),
    colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: Colors.white,
        onPrimary: Colors.black,
        secondary: Colors.blue,
        onSecondary: Colors.blue.withValues(alpha: 0.5),
        error: Colors.redAccent,
        onError: Colors.white,
        surface: Colors.white,
        onSurface: const Color.fromARGB(255, 26, 25, 25)));
