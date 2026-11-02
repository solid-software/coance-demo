# Auth review checklist

For changes under `lib/auth/` and any new endpoint.

## Before you approve

- [ ] **Authorization on every endpoint.** A new handler checks
      `clinician.can(...)` for the permission it needs before it touches
      data. Signed in is not the same as allowed.
- [ ] **Deny by default.** A new `Permission` is granted to no role until a
      role change says so.
- [ ] **Sessions expire as documented.** 15 minutes idle, 8 hours absolute
      (`SessionPolicy`). If you change one, change this line too.
- [ ] **Tokens.** Tokens are checked for signature, issuer, audience and
      expiry. No token or session id in logs or URLs.
- [ ] **Failures look the same.** A wrong password and an unknown email
      give the same response and take about the same time.

## What we label this

Our mapping lists this review under
[OWASP ASVS 5.0](https://github.com/OWASP/ASVS/tree/master/5.0) chapters
V6 (Authentication), V7 (Session Management) and V8 (Authorization), and
SOC 2 CC6.1 (logical access). The mapping is ours.
