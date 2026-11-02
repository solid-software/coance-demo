// Demo code for Coance guide screenshots.
export function refund(chargeId: string, amountCents: number, chargedCents: number) {
  if (amountCents <= 0) throw new Error("amount must be positive");
  if (amountCents > chargedCents) throw new Error("refund exceeds the charge");
  return { chargeId, amountCents, status: "requested" };
}
