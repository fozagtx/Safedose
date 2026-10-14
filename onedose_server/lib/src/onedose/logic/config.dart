import 'dart:io';

/// Timings for escalation. `ONEDOSE_DEMO=true` shortens them for the demo
/// video; the app shows a "Demo timings" label when that is on.
class OneDoseConfig {
  static bool get demo =>
      (Platform.environment['ONEDOSE_DEMO'] ?? '').toLowerCase() == 'true';

  /// When the on-shift caregiver is alerted about a missed fixed-time dose.
  static Duration get escalationStage1 =>
      demo ? const Duration(minutes: 1) : const Duration(minutes: 15);

  /// When the owner is alerted about a missed fixed-time dose.
  static Duration get escalationStage2 =>
      demo ? const Duration(minutes: 2) : const Duration(minutes: 30);

  /// A dose logged this close to a fixed time counts for that slot.
  static const slotWindow = Duration(hours: 2);

  /// How long a caregiver can undo a dose logged by mistake.
  static const undoWindow = Duration(minutes: 2);

  /// How long an unused invite link stays valid.
  static const inviteLifetime = Duration(days: 2);
}
