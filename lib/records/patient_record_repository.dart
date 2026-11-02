import 'package:postgres/postgres.dart';

import '../auth/clinician.dart';
import 'audit_log.dart';
import 'patient_record.dart';

/// Reads and updates patient records, scoped to the clinician's care teams.
class PatientRecordRepository {
  final Session _db;
  final AuditLog _audit;

  PatientRecordRepository(this._db, this._audit);

  /// The record of [patientId], or `null` when it does not exist or the
  /// clinician is not on the patient's care team. Both cases look the same
  /// to the caller, so the response does not reveal that a patient exists.
  Future<PatientRecord?> find(Clinician clinician, String patientId) async {
    final rows = await _db.execute(
      Sql.named(
        'SELECT patient_id, care_team_id, display_name, date_of_birth, '
        'allergies, active_medications FROM patients '
        'WHERE patient_id = @patient AND care_team_id = ANY(@teams)',
      ),
      parameters: {'patient': patientId, 'teams': clinician.careTeamIds},
    );
    if (rows.isEmpty) return null;
    await _audit.record(
      clinicianId: clinician.id,
      patientId: patientId,
      action: RecordAction.view,
    );

    final row = rows.single.toColumnMap();
    return PatientRecord(
      patientId: row['patient_id'] as String,
      careTeamId: row['care_team_id'] as String,
      displayName: row['display_name'] as String,
      dateOfBirth: row['date_of_birth'] as DateTime,
      allergies: (row['allergies'] as List).cast<String>(),
      activeMedications: (row['active_medications'] as List).cast<String>(),
    );
  }
}
