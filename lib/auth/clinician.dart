/// A signed-in clinician and the care teams they belong to.
class Clinician {
  final String id;
  final List<String> careTeamIds;
  final Set<Permission> permissions;

  const Clinician({
    required this.id,
    required this.careTeamIds,
    required this.permissions,
  });

  bool can(Permission permission) => permissions.contains(permission);
}

/// What a clinician's role allows.
enum Permission { viewRecords, editRecords, exportRecords, issueRefunds }
