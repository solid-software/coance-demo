/// A patient's health record as the care team sees it.
class PatientRecord {
  final String patientId;
  final String careTeamId;
  final String displayName;
  final DateTime dateOfBirth;
  final List<String> allergies;
  final List<String> activeMedications;

  const PatientRecord({
    required this.patientId,
    required this.careTeamId,
    required this.displayName,
    required this.dateOfBirth,
    this.allergies = const [],
    this.activeMedications = const [],
  });

  /// What may appear in logs and error reports: the id only, never health
  /// data or names.
  @override
  String toString() => 'PatientRecord($patientId)';
}
