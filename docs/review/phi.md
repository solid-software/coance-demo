# PHI handling guide

For changes under `lib/records/` and anything that reads patient data.
PHI is any health information we can tie to a patient: names, dates of
birth, allergies, medications, visit notes.

## Before you approve

- [ ] **Every access is logged.** Each read or write of a record calls
      `AuditLog.record` with the clinician, the patient and the action, in
      the same request.
- [ ] **Scoped to the care team.** Every query filters on the clinician's
      `careTeamIds`. A record outside them returns the same "not found" as a
      missing one.
- [ ] **Nothing leaks into logs.** Log the patient id, never the record.
      `PatientRecord.toString()` prints the id only; keep it that way.
      Check exceptions too: an error message that embeds a row leaks it.
- [ ] **Integrity.** Updates go through the repository, never raw SQL in a
      handler. Audit rows are never updated or deleted.
- [ ] **Exports.** A new export needs `Permission.exportRecords` and writes
      an `export` audit row.
- [ ] **Test data.** Fixtures use invented patients only.

## What we label this

Our standards mapping lists this review under the HIPAA Security Rule,
[45 CFR 164.312(b)](https://www.ecfr.gov/current/title-45/part-164/section-164.312)
(audit controls) and 164.312(c)(1) (integrity). The mapping is ours; it
does not by itself make the service meet the rule.
