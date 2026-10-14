import 'package:flutter/material.dart' hide Ink;
import 'package:google_fonts/google_fonts.dart';
import 'package:onedose_client/onedose_client.dart';

/// The seesaw neutrals: ink text on white, hairline borders, soft fills.
class Ink {
  static const ink = Color(0xFF1C1C1C);
  static const muted = Color(0xFF737373);
  static const faint = Color(0xFFA3A3A3);
  static const line = Color(0xFFE5E5E5);
  static const soft = Color(0xFFF5F5F5);
  static const field = Color(0x1A525252);
  static const bg = Colors.white;

  /// rgba(0,0,0,.08) — the seesaw "shadow-button" ring on outlined buttons.
  static const hairline = BorderSide(color: Color(0x14000000));
}

/// One colour system: the three answers to "Can I give this now?".
class Lights {
  static const green = Color(0xFF1E7F4F);
  static const amber = Color(0xFFB26A00);
  static const red = Color(0xFFC62828);
  static const unknown = Color(0xFF616161);

  static Color of(StatusLight? light) => switch (light) {
    StatusLight.green => green,
    StatusLight.amber => amber,
    StatusLight.red => red,
    null => unknown,
  };

  static String label(StatusLight? light) => switch (light) {
    StatusLight.green => 'OK to give',
    StatusLight.amber => 'Not yet',
    StatusLight.red => 'Do not give',
    null => 'Can\'t check',
  };

  static IconData icon(StatusLight? light) => switch (light) {
    StatusLight.green => Icons.check_circle,
    StatusLight.amber => Icons.schedule,
    StatusLight.red => Icons.block,
    null => Icons.cloud_off,
  };
}

ThemeData buildTheme() {
  final base = GoogleFonts.interTextTheme();
  final text = base
      .copyWith(
        displaySmall: base.displaySmall?.copyWith(
          fontSize: 36,
          fontWeight: FontWeight.w600,
          letterSpacing: -1.44,
          height: 1.1,
          color: Ink.ink,
        ),
        headlineLarge: base.headlineLarge?.copyWith(
          fontSize: 36,
          fontWeight: FontWeight.w600,
          letterSpacing: -1.44,
          height: 1.1,
          color: Ink.ink,
        ),
        headlineMedium: base.headlineMedium?.copyWith(
          fontSize: 30,
          fontWeight: FontWeight.w600,
          letterSpacing: -1.2,
          color: Ink.ink,
        ),
        headlineSmall: base.headlineSmall?.copyWith(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.48,
          color: Ink.ink,
        ),
        titleLarge: base.titleLarge?.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.36,
          color: Ink.ink,
        ),
        titleMedium: base.titleMedium?.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Ink.ink,
        ),
        titleSmall: base.titleSmall?.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Ink.ink,
        ),
        bodyLarge: base.bodyLarge?.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Ink.ink,
        ),
        bodyMedium: base.bodyMedium?.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Ink.ink,
        ),
        bodySmall: base.bodySmall?.copyWith(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: Ink.muted,
        ),
        labelLarge: base.labelLarge?.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Ink.ink,
        ),
      )
      .apply(bodyColor: Ink.ink, displayColor: Ink.ink);

  const radius10 = BorderRadius.all(Radius.circular(10));

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    textTheme: text,
    scaffoldBackgroundColor: Ink.bg,
    colorScheme: const ColorScheme.light(
      primary: Ink.ink,
      onPrimary: Colors.white,
      secondary: Ink.ink,
      onSecondary: Colors.white,
      surface: Ink.bg,
      onSurface: Ink.ink,
      onSurfaceVariant: Ink.muted,
      outline: Ink.line,
      outlineVariant: Ink.soft,
      surfaceContainerLowest: Ink.bg,
      surfaceContainerLow: Ink.bg,
      surfaceContainer: Ink.soft,
      surfaceContainerHigh: Ink.soft,
      surfaceContainerHighest: Ink.soft,
      error: Lights.red,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Ink.bg,
      foregroundColor: Ink.ink,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: text.titleLarge,
      toolbarHeight: 67,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style:
          FilledButton.styleFrom(
            backgroundColor: Ink.ink,
            foregroundColor: Colors.white,
            disabledBackgroundColor: Ink.soft,
            disabledForegroundColor: Ink.faint,
            minimumSize: const Size(0, 44),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            elevation: 0,
            shape: const RoundedRectangleBorder(borderRadius: radius10),
          ).copyWith(
            overlayColor: WidgetStateProperty.resolveWith(
              (states) => states.contains(WidgetState.pressed)
                  ? Colors.white.withValues(alpha: 0.08)
                  : null,
            ),
          ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: Ink.bg,
        foregroundColor: Ink.ink,
        side: Ink.hairline,
        minimumSize: const Size(0, 44),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        shape: const RoundedRectangleBorder(borderRadius: radius10),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Ink.ink,
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        shape: const RoundedRectangleBorder(borderRadius: radius10),
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(foregroundColor: Ink.ink),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Ink.field,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide.none,
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide.none,
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: Ink.ink, width: 1.5),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: Lights.red),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      labelStyle: const TextStyle(color: Ink.muted),
      floatingLabelStyle: const TextStyle(color: Ink.ink),
      helperStyle: const TextStyle(fontSize: 12, color: Ink.faint),
      helperMaxLines: 3,
    ),
    cardTheme: const CardThemeData(
      color: Ink.bg,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        side: BorderSide(color: Ink.line),
      ),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: Ink.bg,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      titleTextStyle: text.headlineSmall,
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Ink.ink,
      contentTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
      shape: const RoundedRectangleBorder(borderRadius: radius10),
      actionTextColor: Colors.white,
    ),
    dividerTheme: const DividerThemeData(
      color: Ink.soft,
      space: 1,
      thickness: 1,
    ),
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected) ? Ink.ink : Ink.bg,
        ),
        foregroundColor: WidgetStateProperty.resolveWith(
          (states) =>
              states.contains(WidgetState.selected) ? Colors.white : Ink.ink,
        ),
        side: const WidgetStatePropertyAll(BorderSide(color: Ink.line)),
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: radius10),
        ),
      ),
    ),
    listTileTheme: ListTileThemeData(
      titleTextStyle: text.titleSmall,
      subtitleTextStyle: text.bodySmall,
      iconColor: Ink.muted,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(color: Ink.ink),
    popupMenuTheme: const PopupMenuThemeData(
      color: Ink.bg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Ink.bg,
      width: 280,
      shape: RoundedRectangleBorder(),
      endShape: RoundedRectangleBorder(),
    ),
  );
}

String formatTime(DateTime? t) {
  if (t == null) return '';
  final l = t.toLocal();
  final h = l.hour % 12 == 0 ? 12 : l.hour % 12;
  return '$h:${l.minute.toString().padLeft(2, '0')}${l.hour < 12 ? 'am' : 'pm'}';
}

String formatDateTime(DateTime? t) {
  if (t == null) return '';
  final l = t.toLocal();
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return '${l.day} ${months[l.month - 1]}, ${formatTime(t)}';
}

/// The message to show for any error coming back from the server.
String errorText(Object e) {
  if (e is OneDoseException) return e.message;
  return 'Can\'t reach the server. Ask the parent before giving anything.';
}
