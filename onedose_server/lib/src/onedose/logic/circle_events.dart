import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';

/// Server events for a child's circle. Every open `circle.watch` stream on
/// this child listens on the same channel.
class CircleEvents {
  static String channel(int childId) => 'child:$childId';

  static Future<void> post(Session session, CircleEvent event) =>
      session.messages.postMessage(channel(event.childId), event);
}
