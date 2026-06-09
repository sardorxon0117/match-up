import 'package:flutter/material.dart';

class AppTheme {
  // ====================== COLORS ======================

  // ================== DARK MODE ==================
  static const Color primaryGreen = Color(0xFF10B981);
  static const Color primaryGreenDark = Color(0xFF059669);
  static const Color primaryGreenLight = Color(0xFF34D399);

  static const Color backgroundDark = Color(0xFF0A0F1C);
  static const Color surfaceDark = Color(0xFF121A2A);
  static const Color surfaceElevatedDark = Color(0xFF1C2538);
  static const Color dividerDark = Color(0xFF25334D);

  static const Color textPrimaryDark = Color(0xFFF1F5F9);
  static const Color textSecondaryDark = Color(0xFFE2E8F0);
  static const Color textMutedDark = Color(0xFF94A3B8);

  // ================== LIGHT MODE ==================
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceElevatedLight = Color(0xFFF1F5F9);
  static const Color dividerLight = Color(0xFFE2E8F0);

  static const Color textPrimaryLight = Color(0xFF0F172A);
  static const Color textSecondaryLight = Color(0xFF334155);
  static const Color textMutedLight = Color(0xFF64748B);

  // Accent Colors (ikkalasida ham bir xil)
  static const Color accentOrange = Color(0xFFFB923C);
  static const Color accentRed = Color(0xFFF87171);
  static const Color accentBlue = Color(0xFF60A5FA);
  static const Color accentPurple = Color(0xFFC084FC);
  static const Color success = Color(0xFF34D399);
  static const Color warning = Color(0xFFFBBF24);
  static const Color error = Color(0xFFF87171);

  // ====================== TEXT STYLES ======================

  static TextStyle displayLarge = const TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    height: 1.1,
  );

  static TextStyle heading1 = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.4,
    height: 1.25,
  );

  static TextStyle heading2 = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  static TextStyle bodyLarge = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.5,
  );

  static TextStyle bodyMedium = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static TextStyle caption = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  static TextStyle buttonLarge = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    letterSpacing: 0.5,
  );

  static TextStyle progressNumber = const TextStyle(
    fontSize: 42,
    fontWeight: FontWeight.w700,
    color: primaryGreen,
    height: 1.0,
  );

  static TextStyle tileScore = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: textMutedDark,
    height: 1.0,
  );

  static TextStyle tileTeam = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: textPrimaryDark,
    height: 1.0,
  );

  static TextStyle statusEllepsed = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: error,
    height: 1.0,
  );

  static TextStyle tileTeamWin = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: primaryGreen,
    height: 1.0,
  );

  static TextStyle tileTeamGrey = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: textMutedLight,
    height: 1.0,
  );

  static TextStyle grayLarge = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    height: 1.5,
    color: textMutedDark
  );
  static TextStyle grayMedium = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.5,
      color: textMutedDark
  );
  static TextStyle graySmall = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.5,
      color: textMutedDark
  );
}

// ====================== THEME DATA ======================

// ================== DARK THEME ==================
final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  primaryColor: AppTheme.primaryGreen,
  scaffoldBackgroundColor: AppTheme.backgroundDark,
  cardColor: AppTheme.surfaceDark,
  dividerColor: AppTheme.dividerDark,
  fontFamily: 'Inter',

  colorScheme: ColorScheme.dark(
    primary: AppTheme.primaryGreen,
    secondary: AppTheme.primaryGreenLight,
    surface: AppTheme.surfaceDark,
    background: AppTheme.backgroundDark,
    error: AppTheme.error,
    onPrimary: Colors.white,
    onSurface: AppTheme.textPrimaryDark,
  ),

  textTheme: TextTheme(
    displayLarge: AppTheme.displayLarge.copyWith(color: AppTheme.textPrimaryDark),
    headlineMedium: AppTheme.heading1.copyWith(color: AppTheme.textPrimaryDark),
    titleLarge: AppTheme.heading2.copyWith(color: AppTheme.textPrimaryDark),
    bodyLarge: AppTheme.bodyLarge.copyWith(color: AppTheme.textSecondaryDark),
    bodyMedium: AppTheme.bodyMedium.copyWith(color: AppTheme.textSecondaryDark),
    labelSmall: AppTheme.caption.copyWith(color: AppTheme.textMutedDark),
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: AppTheme.backgroundDark,
    elevation: 0,
    titleTextStyle: AppTheme.heading2.copyWith(color: AppTheme.textPrimaryDark),
  ),

  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppTheme.primaryGreen,
    foregroundColor: Colors.white,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppTheme.primaryGreen,
      foregroundColor: Colors.white,
      textStyle: AppTheme.buttonLarge,
      padding: const EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  ),
);

// ================== LIGHT THEME ==================
final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  primaryColor: AppTheme.primaryGreen,
  scaffoldBackgroundColor: AppTheme.backgroundLight,
  cardColor: AppTheme.surfaceLight,
  dividerColor: AppTheme.dividerLight,
  fontFamily: 'Inter',

  colorScheme: ColorScheme.light(
    primary: AppTheme.primaryGreen,
    secondary: AppTheme.primaryGreenLight,
    surface: AppTheme.surfaceLight,
    background: AppTheme.backgroundLight,
    error: AppTheme.error,
    onPrimary: Colors.white,
    onSurface: AppTheme.textPrimaryLight,
  ),

  textTheme: TextTheme(
    displayLarge: AppTheme.displayLarge.copyWith(color: AppTheme.textPrimaryLight),
    headlineMedium: AppTheme.heading1.copyWith(color: AppTheme.textPrimaryLight),
    titleLarge: AppTheme.heading2.copyWith(color: AppTheme.textPrimaryLight),
    bodyLarge: AppTheme.bodyLarge.copyWith(color: AppTheme.textSecondaryLight),
    bodyMedium: AppTheme.bodyMedium.copyWith(color: AppTheme.textSecondaryLight),
    labelSmall: AppTheme.caption.copyWith(color: AppTheme.textMutedLight),
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: AppTheme.backgroundLight,
    elevation: 0,
    titleTextStyle: AppTheme.heading2.copyWith(color: AppTheme.textPrimaryLight),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppTheme.primaryGreen,
      foregroundColor: Colors.white,
      textStyle: AppTheme.buttonLarge,
      padding: const EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  ),
);