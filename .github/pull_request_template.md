## Review

Areas touched: <!-- payments / auth / migrations / standard -->

### Quick look

- [ ] The change does what the description says, and nothing else
- [ ] Nothing surprising: no unrelated files, config or permission changes
- [ ] CI passes and the tests touched still test something real
- [ ] No secrets, tokens or personal data in code, tests or fixtures

### Careful review

- [ ] I read every changed line and understand what it does
- [ ] The author can explain the change, including generated parts
- [ ] Inputs are validated; queries and commands are parameterized
- [ ] Every new endpoint, query or job checks who is allowed to use it
- [ ] Errors, timeouts, retries and duplicate requests are handled
- [ ] Tests cover the failure cases, not only the happy path
- [ ] Tests check behavior, not only that a mock was called
- [ ] Every new dependency exists, is the intended package, and is needed
- [ ] APIs and functions called actually exist in the versions we use
- [ ] Copied or generated code has a license we can use
- [ ] Logs and errors do not expose personal data or secrets
- [ ] Migrations and data changes can be rolled back, or the plan is stated
- [ ] Performance is reasonable for real data sizes
- [ ] Docs, comments and changelog are updated where behavior changed
