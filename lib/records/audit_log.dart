import 'package:postgres/postgres.dart';

/// What a clinician did with a record.
enum RecordAction { view, update, export }

/// Writes one row to `record_access_log` for every read or write of a
/// patient record. Rows are append-only: the table has no UPDATE or DELETE
/// grant for the app's role.
class AuditLog {
  final Session _db;

  AuditLog(this._db);

  Future<void> record({
    required String clinicianId,
    required String patientId,
    required RecordAction action,
    String? reason,
  }) async {
    await _db.execute(
      Sql.named(
        'INSERT INTO record_access_log (clinician_id, patient_id, action, reason) '
        'VALUES (@clinician, @patient, @action, @reason)',
      ),
      parameters: {
        'clinician': clinicianId,
        'reason': reason,
        'patient': patientId,
        'action': action.name,
      },
    );
  }
}
