/// How long sign-ins last. Documented in docs/review/auth.md; change both
/// together.
class SessionPolicy {
  /// A session ends after this long without a request.
  static const idleTimeout = Duration(minutes: 15);

  /// A session must re-authenticate before exporting a record if it signed
  /// in longer ago than this.
  static const exportReauthAfter = Duration(minutes: 30);

  /// A session ends this long after sign-in, active or not.
  static const absoluteTimeout = Duration(hours: 8);

  const SessionPolicy();

  bool isExpired({
    required DateTime signedInAt,
    required DateTime lastSeenAt,
    required DateTime now,
  }) =>
      now.difference(lastSeenAt) > idleTimeout ||
      now.difference(signedInAt) > absoluteTimeout;
}
