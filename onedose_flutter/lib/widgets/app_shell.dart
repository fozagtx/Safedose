import 'package:flutter/material.dart' hide Ink;

import '../theme.dart';
import 'brand_mark.dart';
import 'safety_footer.dart';

class ShellNavItem {
  final IconData icon;
  final String label;
  const ShellNavItem(this.icon, this.label);
}

/// The seesaw nav shell: brand top-left in a 67px bar, sidebar on wide
/// screens, hamburger + end drawer on narrow.
class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.items,
    required this.selected,
    required this.onSelect,
    required this.body,
    this.topActions = const [],
    this.primaryAction,
    this.status,
    this.onSignOut,
  });

  final List<ShellNavItem> items;
  final int selected;
  final ValueChanged<int> onSelect;
  final Widget body;

  /// Secondary (outlined) actions, hidden on narrow screens.
  final List<Widget> topActions;

  /// Black button, always shown in the top bar.
  final Widget? primaryAction;

  /// Grey pill centred in the top bar on wide screens.
  final Widget? status;

  /// Sign-out handler for the sidebar/drawer footer box.
  final VoidCallback? onSignOut;

  static bool isWide(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 840;

  static EdgeInsets pagePadding(BuildContext context) {
    final h = isWide(context) ? 40.0 : 24.0;
    return EdgeInsets.fromLTRB(h, 32, h, 48);
  }

  @override
  Widget build(BuildContext context) {
    final wide = isWide(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(67),
        child: SafeArea(
          bottom: false,
          child: SizedBox(
            height: 67,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: BrandMark(onTap: () => onSelect(0)),
                  ),
                  if (wide && status != null) Align(child: status!),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (wide) ...[
                          for (final a in topActions) ...[
                            a,
                            const SizedBox(width: 8),
                          ],
                        ],
                        ?primaryAction,
                        if (!wide) ...[
                          if (primaryAction != null) const SizedBox(width: 8),
                          Builder(
                            builder: (c) => IconButton(
                              icon: const Icon(Icons.menu),
                              onPressed: () => Scaffold.of(c).openEndDrawer(),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      endDrawer: wide
          ? null
          : Drawer(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: _Sidebar(
                    items: items,
                    selected: selected,
                    onSelect: (i) {
                      onSelect(i);
                      Navigator.of(context).pop();
                    },
                    onSignOut: onSignOut,
                  ),
                ),
              ),
            ),
      bottomNavigationBar: wide ? null : const SafetyFooter(),
      body: wide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 250,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: _Sidebar(
                      items: items,
                      selected: selected,
                      onSelect: onSelect,
                      onSignOut: onSignOut,
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: body,
                    ),
                  ),
                ),
              ],
            )
          : body,
    );
  }
}

class _Sidebar extends StatelessWidget {
  final List<ShellNavItem> items;
  final int selected;
  final ValueChanged<int> onSelect;
  final VoidCallback? onSignOut;

  const _Sidebar({
    required this.items,
    required this.selected,
    required this.onSelect,
    this.onSignOut,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              for (var i = 0; i < items.length; i++) ...[
                if (i > 0) const SizedBox(height: 2),
                _NavRow(
                  item: items[i],
                  selected: i == selected,
                  onTap: () => onSelect(i),
                ),
              ],
            ],
          ),
        ),
        const SafetyFooter.sidebar(),
        const SizedBox(height: 8),
        _SignOutBox(onTap: onSignOut),
      ],
    );
  }
}

class _NavRow extends StatelessWidget {
  final ShellNavItem item;
  final bool selected;
  final VoidCallback onTap;

  const _NavRow({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected ? Ink.ink : Ink.muted;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: selected ? Ink.soft : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        hoverColor: Ink.soft,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              Icon(item.icon, size: 16, color: color),
              const SizedBox(width: 12),
              Text(item.label, style: TextStyle(fontSize: 14, color: color)),
            ],
          ),
        ),
      ),
    );
  }
}

class _SignOutBox extends StatelessWidget {
  final VoidCallback? onTap;
  const _SignOutBox({this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Ink.soft,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Sign out',
                  style: TextStyle(fontSize: 14, color: Ink.ink),
                ),
              ),
              Icon(Icons.logout, size: 16, color: Ink.muted),
            ],
          ),
        ),
      ),
    );
  }
}
