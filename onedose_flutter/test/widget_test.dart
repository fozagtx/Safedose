import 'package:flutter/material.dart' hide Ink;
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:onedose_flutter/theme.dart';
import 'package:onedose_flutter/widgets/app_shell.dart';
import 'package:onedose_flutter/widgets/brand_mark.dart';
import 'package:onedose_flutter/widgets/page_header.dart';

Widget _wrap(Widget child, {Size size = const Size(1280, 800)}) {
  return MaterialApp(
    theme: buildTheme(),
    home: MediaQuery(
      data: MediaQueryData(size: size),
      child: child,
    ),
  );
}

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('BrandMark renders ONE and DOSE', (tester) async {
    await tester.pumpWidget(_wrap(const Scaffold(body: BrandMark())));
    expect(find.text('ONE'), findsOneWidget);
    expect(find.text('DOSE'), findsOneWidget);
  });

  testWidgets('PageHeader shows title, subtitle and actions', (tester) async {
    await tester.pumpWidget(
      _wrap(
        const Scaffold(
          body: PageHeader(
            title: 'Alex',
            subtitle: 'Every dose, once.',
            actions: [Text('ACT')],
            meta: Text('META'),
          ),
        ),
      ),
    );
    expect(find.text('Alex'), findsOneWidget);
    expect(find.text('Every dose, once.'), findsOneWidget);
    expect(find.text('ACT'), findsOneWidget);
    expect(find.text('META'), findsOneWidget);
  });

  testWidgets('AppShell wide: sidebar labels, no menu button, tap selects', (
    tester,
  ) async {
    var selected = 0;
    await tester.pumpWidget(
      _wrap(
        StatefulBuilder(
          builder: (context, setState) => AppShell(
            items: const [
              ShellNavItem(Icons.medication_outlined, 'Today'),
              ShellNavItem(Icons.history, 'History'),
              ShellNavItem(Icons.group_outlined, 'Care circle'),
            ],
            selected: selected,
            onSelect: (i) => setState(() => selected = i),
            body: const Text('BODY'),
          ),
        ),
      ),
    );
    expect(find.text('Today'), findsOneWidget);
    expect(find.text('History'), findsOneWidget);
    expect(find.text('Care circle'), findsOneWidget);
    expect(find.byIcon(Icons.menu), findsNothing);
    await tester.tap(find.text('History'));
    await tester.pump();
    expect(selected, 1);
  });

  testWidgets('AppShell narrow: menu button, labels only in drawer', (
    tester,
  ) async {
    await tester.pumpWidget(
      _wrap(
        AppShell(
          items: const [
            ShellNavItem(Icons.medication_outlined, 'Today'),
            ShellNavItem(Icons.history, 'History'),
          ],
          selected: 0,
          onSelect: (_) {},
          body: const Text('BODY'),
        ),
        size: const Size(390, 844),
      ),
    );
    expect(find.byIcon(Icons.menu), findsOneWidget);
    expect(find.text('History'), findsNothing);
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    expect(find.text('History'), findsOneWidget);
  });

  testWidgets('AppShell sign-out box calls onSignOut', (tester) async {
    var called = false;
    await tester.pumpWidget(
      _wrap(
        AppShell(
          items: const [ShellNavItem(Icons.medication_outlined, 'Today')],
          selected: 0,
          onSelect: (_) {},
          onSignOut: () => called = true,
          body: const Text('BODY'),
        ),
      ),
    );
    await tester.tap(find.text('Sign out'));
    await tester.pump();
    expect(called, isTrue);
  });
}
