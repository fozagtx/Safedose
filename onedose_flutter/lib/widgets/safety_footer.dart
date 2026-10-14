import 'package:flutter/material.dart' hide Ink;
import 'package:url_launcher/url_launcher.dart';

import '../theme.dart';

/// Shown on every screen: OneDose is a log, not medical advice.
class SafetyFooter extends StatelessWidget {
  final bool _sidebar;
  const SafetyFooter({super.key}) : _sidebar = false;
  const SafetyFooter.sidebar({super.key}) : _sidebar = true;

  static final _poisonHelp = Uri.parse('https://www.poison.org/');

  @override
  Widget build(BuildContext context) {
    if (_sidebar) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Material(
            color: Ink.soft,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              onTap: () => launchUrl(_poisonHelp),
              borderRadius: BorderRadius.circular(12),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Poison control',
                        style: TextStyle(fontSize: 14, color: Ink.ink),
                      ),
                    ),
                    Icon(Icons.open_in_new, size: 16, color: Ink.muted),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'A shared log, not medical advice.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Ink.faint),
          ),
        ],
      );
    }
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Text(
              'OneDose is a shared log, not medical advice. '
              'Too much given? ',
              style: TextStyle(fontSize: 12, color: Ink.faint),
            ),
            InkWell(
              onTap: () => launchUrl(_poisonHelp),
              child: const Text(
                'Poison control guidance',
                style: TextStyle(
                  fontSize: 12,
                  color: Ink.muted,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
