# Payments review checklist

For changes under `lib/payments/` and any code that talks to Stripe. Two
people review; neither may be the author.

## Before you approve

- [ ] **Run it.** Check out the branch and run the change against Stripe
      test mode (`STRIPE_API_BASE` and the test key from the team vault).
      Use the [test cards](https://docs.stripe.com/testing) for a decline
      (`4000 0000 0000 0002`) and for 3-D Secure.
- [ ] **Declined payments.** A decline returns `Declined`, never throws past
      the service, and the visit stays unpaid.
- [ ] **Partial refunds.** The total refunded can never exceed the charge.
      There is a test that refunds in two steps and a third that is refused.
- [ ] **Repeated requests.** Every Stripe call that moves money sends an
      `Idempotency-Key` derived from our own id (visit, refund request), not
      a random value, so a retry cannot charge twice.
- [ ] **Amounts.** Money is `Money` in minor units. No `double`, no
      currency mixing.
- [ ] **No card data.** Nothing here receives, logs or stores a card number,
      CVC or expiry. See the [card data flow](../architecture/card-data-flow.md).
- [ ] **Errors.** Stripe errors are logged with their code and our ids,
      never with the request body.

## What we label this

Our standards mapping lists this review under PCI DSS v4.0.1
Requirement 6.2.3 (bespoke and custom software is reviewed before release)
and 6.2.3.1 (reviewers other than the author, who know secure coding). The
mapping is ours; the assessor decides what it covers.
