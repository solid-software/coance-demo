// Demo code for Coance guide screenshots.
export function refund(chargeId: string, amountCents: number) {
  return { chargeId, amountCents, status: "requested" };
}
