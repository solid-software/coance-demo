CREATE TABLE patients (
  patient_id          text PRIMARY KEY,
  care_team_id        text NOT NULL,
  display_name        text NOT NULL,
  date_of_birth       date NOT NULL,
  allergies           text[] NOT NULL DEFAULT '{}',
  active_medications  text[] NOT NULL DEFAULT '{}',
  created_at          timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX patients_care_team_idx ON patients (care_team_id);
