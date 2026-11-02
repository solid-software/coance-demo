# Infrastructure change runbook

For changes under `infra/` and `db/migrations/`.

## Terraform

1. Paste the `terraform plan` output in the pull request. The reviewer
   reads the plan, not only the diff.
2. Check nothing new is exposed: no `INGRESS_TRAFFIC_ALL`, no public IP,
   no `allUsers` or `allAuthenticatedUsers` binding, no secret in plain
   `env`.
3. Anything that destroys and recreates a resource (`-/+` in the plan)
   needs a note on downtime.
4. Apply from CI after merge, never from a laptop.

## Migrations

1. A migration is never edited after it merges. Fix forward with a new one.
2. Check it on a copy of production-sized data: adding a `NOT NULL` column
   needs a default or a backfill, and a new index on a big table uses
   `CREATE INDEX CONCURRENTLY`.
3. Grants: the app role gets only what it needs. Audit tables stay
   append-only.
4. Say how to roll back, or why it cannot be rolled back.

## What we label this

Our mapping lists these reviews under ISO/IEC 27001:2022 Annex A 8.9
(configuration management) and 8.32 (change management), and SOC 2 CC8.1
(change management). The mapping is ours.
