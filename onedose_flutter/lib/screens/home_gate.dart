import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:onedose_client/onedose_client.dart';

import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../client.dart';
import '../theme.dart';
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
          return _Message(
            text: errorText(snap.error!),
            action: FilledButton(onPressed: _load, child: const Text('Retry')),
          );
        }
        if (!snap.hasData) {
          return const Center(child: CircularProgressIndicator());
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
          Text(text, textAlign: TextAlign.center),
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

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('OneDose'),
        actions: [
          IconButton(
            tooltip: 'Sign out',
            icon: const Icon(Icons.logout),
            onPressed: () => client.auth.signOutDevice(),
          ),
        ],
      ),
      bottomNavigationBar: const SafetyFooter(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Every dose, once.', style: text.headlineSmall),
          const SizedBox(height: 8),
          const Text(
            'Everyone who looks after your child logs doses here. The '
            'server refuses a second dose before anyone can give it.',
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('I\'m the parent', style: text.titleMedium),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _childName,
                    decoration: const InputDecoration(
                      labelText: 'Child\'s name',
                    ),
                  ),
                  TextField(
                    controller: _ownerName,
                    decoration: const InputDecoration(
                      labelText: 'Your name in the circle',
                      helperText: 'Shown to others, e.g. "Mum"',
                    ),
                  ),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: _busy
                        ? null
                        : () => _run(
                            () => client.child.create(
                              name: _childName.text,
                              ownerName: _ownerName.text,
                              utcOffsetMinutes:
                                  DateTime.now().timeZoneOffset.inMinutes,
                            ),
                          ),
                    child: const Text('Set up my child'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('I was sent an invite', style: text.titleMedium),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _code,
                    textCapitalization: TextCapitalization.characters,
                    decoration: const InputDecoration(
                      labelText: 'Invite code',
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: _busy
                        ? null
                        : () => _run(() => client.invite.accept(_code.text)),
                    child: const Text('Join'),
                  ),
                ],
              ),
            ),
          ),
          if (_error != null) ...[
            const SizedBox(height: 12),
            Text(_error!, style: TextStyle(color: Lights.red)),
          ],
        ],
      ),
    );
  }
}
