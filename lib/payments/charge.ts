// Demo code for Coance guide screenshots.
export function charge(amountCents: number, currency: string) {
  if (amountCents <= 0) throw new Error("amount must be positive");
  return { amountCents, currency, status: "pending" };
}
