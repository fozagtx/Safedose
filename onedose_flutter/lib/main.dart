import 'package:flutter/material.dart' hide Ink;

import 'client.dart';
import 'screens/home_gate.dart';
import 'screens/sign_in_screen.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeClient();
  runApp(const OneDoseApp());
}

class OneDoseApp extends StatelessWidget {
  const OneDoseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OneDose',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      themeMode: ThemeMode.light,
      home: const SignInScreen(child: HomeGate()),
    );
  }
}
