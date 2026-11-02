# Acme Health (Coance demo)

A small, fictional telehealth backend that takes card payments and stores
patient records. It is the public demo repository for
[Coance](https://coance.ai) and its guides: open pull requests here show how
Coance asks for a different review on each file, alongside `CODEOWNERS` and
branch protection.

All names, patients and data in this repository are invented.

| Path             | What it is                         | Review level                                   |
| ---------------- | ---------------------------------- | ---------------------------------------------- |
| `lib/payments/`  | Charges and refunds through Stripe | `payments`, 2 approvals, not the author        |
| `lib/records/`   | Patient health records             | `patient-records`, 2 approvals, not the author |
| `lib/auth/`      | Sign-in, sessions and permissions  | `auth`, 1 approval, not the author             |
| `infra/`         | Terraform for the API              | `infrastructure`, 1 approval, not the author   |
| `db/migrations/` | Database migrations                | `infrastructure`                               |
| other `*.dart`   | App code                           | `app`, 1 approval                              |

The policy is in [`.github/coance.yml`](.github/coance.yml). Each level's
description says what the reviewer checks and links the team's checklist
in [`docs/`](docs/).
