import { createHash } from "node:crypto";

export const centralizerIsScalarExpectedSha256 =
  "61eabacf4ca1ec8f4921ba9d1506c22c94d255c83570d284e5a02297087161a4";

export function contentFingerprint(inspected: string): string {
  return createHash("sha256").update(inspected).digest("hex");
}

export function assertReviewedContentFingerprint(
  entryId: string,
  actualSha256: string,
  expectedSha256: string,
): void {
  if (actualSha256 !== expectedSha256) {
    throw new Error(`レビュー済み本文 fingerprint が変わりました: ${entryId}: ${actualSha256}`);
  }
}
