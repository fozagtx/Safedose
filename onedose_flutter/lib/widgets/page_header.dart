import 'package:flutter/material.dart' hide Ink;

import '../theme.dart';

/// The big page title + subtitle + optional actions/meta, seesaw style.
class PageHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<Widget> actions;
  final Widget? meta;

  const PageHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.actions = const [],
    this.meta,
  });

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final narrow = MediaQuery.sizeOf(context).width < 600;
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: narrow ? text.headlineMedium : text.headlineLarge,
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 6),
            Text(
              subtitle!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Ink.muted,
                height: 1.35,
              ),
            ),
          ],
          if (actions.isNotEmpty || meta != null) ...[
            const SizedBox(height: 20),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [...actions, ?meta],
            ),
          ],
        ],
      ),
    );
  }
}
