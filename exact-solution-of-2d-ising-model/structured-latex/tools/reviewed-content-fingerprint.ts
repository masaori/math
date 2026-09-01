import { createHash } from "node:crypto";

export const centralizerIsScalarExpectedSha256 =
  "d03bd0c088226927a708a10b1c3f6e037146f036d433019bf0b651e9bf52c201";

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
