import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Shown on every screen: OneDose is a log, not medical advice.
class SafetyFooter extends StatelessWidget {
  const SafetyFooter({super.key});

  static final _poisonHelp = Uri.parse('https://www.poison.org/');

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodySmall;
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              'OneDose is a shared log, not medical advice. '
              'Too much given? ',
              style: style,
            ),
            InkWell(
              onTap: () => launchUrl(_poisonHelp),
              child: Text(
                'Poison control guidance',
                style: style?.copyWith(
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
