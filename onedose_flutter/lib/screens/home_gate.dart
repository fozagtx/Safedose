import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Ink;
import 'package:onedose_client/onedose_client.dart';

import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../client.dart';
import '../theme.dart';
import '../widgets/brand_mark.dart';
import '../widgets/page_header.dart';
import '../widgets/safety_footer.dart';
import 'circle_screen.dart';

/// Decides what a signed-in person sees: their circle, or setup.
class HomeGate extends StatefulWidget {
  const HomeGate({super.key});

  @override
  State<HomeGate> createState() => _HomeGateState();
}

class _HomeGateState extends State<HomeGate> {
  Future<List<CircleSummary>>? _circles;

  /// An invite token from a link like https://app/?invite=ABCD.
  String? get _linkToken => kIsWeb ? Uri.base.queryParameters['invite'] : null;
  bool _linkTried = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() => setState(() => _circles = _fetch());

  Future<List<CircleSummary>> _fetch() async {
    final token = _linkToken;
    if (token != null && !_linkTried) {
      _linkTried = true;
      try {
        await client.invite.accept(token);
      } on OneDoseException catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(e.message)));
        }
      }
    }
    return client.child.mine();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CircleSummary>>(
      future: _circles,
      builder: (context, snap) {
        if (snap.hasError) {
          return Scaffold(
            body: _Message(
              text: errorText(snap.error!),
              action: FilledButton(
                onPressed: _load,
                child: const Text('Retry'),
              ),
            ),
          );
        }
        if (!snap.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final circles = snap.data!;
        if (circles.isEmpty) return SetupScreen(onDone: _load);
        // Prefer the circle the person owns, else the first.
        final circle = circles.firstWhere(
          (c) => c.me.role == CareRole.owner,
          orElse: () => circles.first,
        );
        return CircleScreen(
          key: ValueKey(circle.me.id),
          circle: circle,
          onLeft: _load,
        );
      },
    );
  }
}

class _Message extends StatelessWidget {
  final String text;
  final Widget? action;
  const _Message({required this.text, this.action});

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Ink.muted),
          ),
          if (action != null) ...[const SizedBox(height: 16), action!],
        ],
      ),
    ),
  );
}

/// First run: set up a child, or join one with an invite code.
class SetupScreen extends StatefulWidget {
  final VoidCallback onDone;
  const SetupScreen({super.key, required this.onDone});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  final _childName = TextEditingController();
  final _ownerName = TextEditingController(text: 'Mum');
  final _code = TextEditingController();
  bool _busy = false;
  String? _error;

  Future<void> _run(Future<void> Function() action) async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await action();
      widget.onDone();
    } catch (e) {
      setState(() => _error = errorText(e));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Widget _setupCard({
    required String title,
    required String caption,
    required List<Widget> fields,
    required Widget button,
  }) {
    final text = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Ink.line),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title, style: text.titleLarge),
          const SizedBox(height: 6),
          Text(
            caption,
            style: const TextStyle(fontSize: 14, color: Ink.muted),
          ),
          const SizedBox(height: 20),
          for (var i = 0; i < fields.length; i++) ...[
            if (i > 0) const SizedBox(height: 12),
            fields[i],
          ],
          const SizedBox(height: 20),
          button,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 720;
    final parentCard = _setupCard(
      title: 'I\'m the parent',
      caption: 'Set up your child and invite the people who help.',
      fields: [
        TextField(
          controller: _childName,
          decoration: const InputDecoration(labelText: 'Child\'s name'),
        ),
        TextField(
          controller: _ownerName,
          decoration: const InputDecoration(
            labelText: 'Your name in the circle',
            helperText: 'Shown to others, e.g. "Mum"',
          ),
        ),
      ],
      button: FilledButton(
        onPressed: _busy
            ? null
            : () => _run(
                () => client.child.create(
                  name: _childName.text,
                  ownerName: _ownerName.text,
                  utcOffsetMinutes: DateTime.now().timeZoneOffset.inMinutes,
                ),
              ),
        child: const Text('Set up my child'),
      ),
    );
    final inviteCard = _setupCard(
      title: 'I was sent an invite',
      caption: 'Enter the code the parent sent you.',
      fields: [
        TextField(
          controller: _code,
          textCapitalization: TextCapitalization.characters,
          decoration: const InputDecoration(labelText: 'Invite code'),
        ),
      ],
      button: OutlinedButton(
        onPressed: _busy
            ? null
            : () => _run(() => client.invite.accept(_code.text)),
        child: const Text('Join'),
      ),
    );

    return Scaffold(
      bottomNavigationBar: const SafetyFooter(),
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: SizedBox(
              height: 67,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    const BrandMark(),
                    const Spacer(),
                    OutlinedButton(
                      onPressed: () => client.auth.signOutDevice(),
                      child: const Text('Sign out'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 48),
              children: [
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 960),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const PageHeader(
                          title: 'Every dose, once.',
                          subtitle:
                              'Everyone who looks after your child logs '
                              'doses here. The server refuses a second dose '
                              'before anyone can give it.',
                        ),
                        if (wide)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: parentCard),
                              const SizedBox(width: 20),
                              Expanded(child: inviteCard),
                            ],
                          )
                        else ...[
                          parentCard,
                          const SizedBox(height: 20),
                          inviteCard,
                        ],
                        if (_error != null) ...[
                          const SizedBox(height: 12),
                          Text(
                            _error!,
                            style: const TextStyle(color: Lights.red),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
