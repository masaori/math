/**
 * **台帳の中の「エントリを数える主張」の数え直し**。
 *
 * 設計と限界は `entry-count-claims.ts` を正本とする。
 */

import {
  ENTRY_COUNT_CLAIMS,
  auditEntryCountClaim,
  type EntryCountClaim,
} from "./entry-count-claims.ts";
import { FORMALIZATION_COVERAGE } from "./formalization-coverage.ts";
import { EXTERNAL_THEOREM_COVERAGE } from "./external-theorem-coverage.ts";

/** 本文の台帳のエントリ 1 件ぶんの散文（状態によって欄の名前が違うので全部つなぐ）。 */
const bodyTexts = FORMALIZATION_COVERAGE.map((entry) =>
  Object.values(entry)
    .filter((value): value is string => typeof value === "string")
    .join("\n"),
);

/** 外部定理の台帳のエントリ 1 件ぶんの散文（種別ごとに欄の名前が違うので全部つなぐ）。 */
const externalTexts = EXTERNAL_THEOREM_COVERAGE.map((entry) =>
  Object.values(entry)
    .filter((value): value is string => typeof value === "string")
    .join("\n"),
);

/** 数を書いている欄の散文を、本文・外部定理のどちらからでも引く。 */
function holderTextOf(claim: EntryCountClaim): string | null {
  const body = FORMALIZATION_COVERAGE.findIndex((entry) => entry.block === claim.holder);
  if (body >= 0) return bodyTexts[body]!;
  const external = EXTERNAL_THEOREM_COVERAGE.findIndex((entry) => entry.name === claim.holder);
  if (external >= 0) return externalTexts[external]!;
  return null;
}

console.log("");
console.log("台帳の「エントリを数える主張」の数え直し");
console.log(
  "  塞げるのは「台帳のエントリのうちある語に触れているものの数」だけである。" +
    "散文の中の列挙を数える主張は対象外で、そこは人の読みのままである（設計は entry-count-claims.ts）。",
);

const violations: string[] = [];
for (const claim of ENTRY_COUNT_CLAIMS) {
  const countedTexts = claim.counts === "本文の台帳" ? bodyTexts : externalTexts;
  const result = auditEntryCountClaim({
    claim,
    countedTexts,
    holderText: holderTextOf(claim),
  });
  console.log(
    `  ${claim.terms[0]}（${claim.counts}を数える）: 数え直し ${result.counted} 件` +
      ` → ${claim.holder}`,
  );
  for (const v of result.violations) violations.push(`[${v.kind}] ${v.detail}`);
}

console.log("");
if (violations.length > 0) {
  console.log(`違反 ${violations.length} 件`);
  for (const v of violations) console.log(`    ${v}`);
  console.log("");
  console.log("  直し方: 欄を書き足したなら、その欄を要約している数も同じコミットで直すこと。");
  console.log(`違反 ${violations.length} 件。`);
  process.exit(1);
}
console.log("違反 0 件。");
