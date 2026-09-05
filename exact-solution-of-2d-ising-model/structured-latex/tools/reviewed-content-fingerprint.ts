import { createHash } from "node:crypto";

export const centralizerIsScalarExpectedSha256 =
  "22a91fef805e4fa6c21e27b0ad698ea98f16801ce46d99a47cea5f66468bc884";

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
