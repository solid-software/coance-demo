-- One row per read or write of a patient record. Append-only: the app role
-- gets INSERT and SELECT, never UPDATE or DELETE.
CREATE TABLE record_access_log (
  id            bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  clinician_id  text NOT NULL,
  patient_id    text NOT NULL REFERENCES patients (patient_id),
  action        text NOT NULL CHECK (action IN ('view', 'update', 'export')),
  at            timestamptz NOT NULL DEFAULT now()
);

GRANT INSERT, SELECT ON record_access_log TO acme_app;
