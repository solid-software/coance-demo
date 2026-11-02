-- Why a record was exported. Existing rows are views and updates, which
-- need no reason, so the column is nullable; exports must give one.
ALTER TABLE record_access_log ADD COLUMN reason text;

ALTER TABLE record_access_log
  ADD CONSTRAINT export_has_reason
  CHECK (action <> 'export' OR reason IS NOT NULL);
