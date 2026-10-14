import 'package:flutter/material.dart';
import 'package:onedose_client/onedose_client.dart';

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

ThemeData buildTheme(Brightness brightness) => ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF2F5D8A),
    brightness: brightness,
  ),
  useMaterial3: true,
);

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
