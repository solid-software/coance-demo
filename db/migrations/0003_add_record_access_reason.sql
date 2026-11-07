-- Why a clinician opened or exported a record, for the access log review.
ALTER TABLE record_access_log ADD COLUMN reason text;

-- Rollback: ALTER TABLE record_access_log DROP COLUMN reason;
