# Card data flow

Card numbers never touch Acme Health's servers.

```text
Patient's phone                 Stripe                     Acme Health API
---------------                 ------                     ---------------
card form (Stripe Elements) --> tokenizes the card
                                returns pm_... id   -->    stores pm_... and the
                                                           Stripe customer id
visit ends                                                 ChargeService charges
                                <-- PaymentIntent ------   pm_... (idempotency
                                                           key: visit id)
```

- The app collects the card in Stripe's own fields, so the number, CVC and
  expiry go from the phone straight to Stripe.
- We store only Stripe ids (`cus_...`, `pm_...`, `pi_...`) and the last
  four digits Stripe returns, for receipts.
- `lib/payments/` is the only code that calls Stripe. A change anywhere
  else that starts calling it, or that accepts a field named like a card
  number, is a design change: raise it before the pull request.
