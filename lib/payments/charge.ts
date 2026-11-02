// Demo code for Coance guide screenshots.
export function charge(amountCents: number, currency: string) {
  const cents = Math.round(amountCents);
  if (cents <= 0) throw new Error("amount must be positive");
  return { amountCents: cents, currency, status: "pending" };
}
