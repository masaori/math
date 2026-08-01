#!/usr/bin/env node
/**
 * **検査 R**: 本文・ロケール本文・検査道具・docs に書かれたツールへの参照が腐っていないか。
 *
 * cycle 24 step 2 で実際に起きた腐り（撤去済みツール・存在しない npm script・
 * 誤った相対パスを指したままの先頭コメント 12 ファイル分）を機械で検出する。
 * 何を見て何を見ないか、走査範囲の根拠、免除の型は reference-rot-model.ts の doc にある。
 *
 * 使い方: node tools/verify-reference-rot.ts
 */

import { REFERENCE_ALLOWANCES } from "./reference-rot-allowances.ts";
import {
  SCAN_EXCLUSIONS,
  SCAN_ROOTS,
  checkAllowances,
  collectReferences,
  findRot,
  scanTargets,
  unexplained,
  unusedAllowances,
} from "./reference-rot-model.ts";

const files = await scanTargets();
const references = await collectReferences(files);
const rot = await findRot(files);
const remaining = unexplained(rot, REFERENCE_ALLOWANCES);
const unused = unusedAllowances(rot, REFERENCE_ALLOWANCES);
const allowanceFindings = await checkAllowances(REFERENCE_ALLOWANCES);

console.log("腐ったツール参照の検査（検査 R）");
console.log(`  走査: ${files.length} ファイル / 参照 ${references.length} 件（${SCAN_ROOTS.join(", ")}）`);
console.log("  走査から外した場所（黙って外さない）:");
for (const { where, why } of SCAN_EXCLUSIONS) console.log(`    - ${where}: ${why}`);

const byType = new Map<string, number>();
for (const finding of rot) byType.set(finding.reason, (byType.get(finding.reason) ?? 0) + 1);
console.log(
  `\n  **実在しない参照 ${rot.length} 件**（${[...byType].map(([r, n]) => `${r} ${n}`).join("・")}）`,
);

const GROUNDS_LABEL: Record<string, string> = {
  historical: "過去の状態として書かれている",
  illustration: "例示・否定の文脈",
  generated: "生成物",
  otherProject: "別プロジェクトのファイル",
  outOfScope: "本当に腐っている（直すのは担当範囲外。記録済み）",
};
const groundsCount = new Map<string, number>();
for (const allowance of REFERENCE_ALLOWANCES) {
  groundsCount.set(allowance.grounds.type, (groundsCount.get(allowance.grounds.type) ?? 0) + 1);
}
console.log(
  `  免除 ${REFERENCE_ALLOWANCES.length} 件 / 型別: ` +
    [...groundsCount].map(([t, n]) => `${GROUNDS_LABEL[t] ?? t} ${n}`).join("・"),
);
console.log(
  `  **失効した免除 ${allowanceFindings.length} 件** / **登録が古い（1 件も当たらない）免除 ${unused.length} 件** / ` +
    `**説明のつかない腐り ${remaining.length} 件**`,
);

const outOfScopeCount = groundsCount.get("outOfScope") ?? 0;
if (outOfScopeCount > 0) {
  console.log(
    `    ↑ このうち ${outOfScopeCount} 件は**本当に腐っている**（実在しないものを現在形で指している）。` +
      "直すのが本 step の担当範囲外なので記録して通しているだけであって、直ったことにはならない。",
  );
}

for (const finding of allowanceFindings) {
  console.log(`      - ${finding.file} / ${finding.reference}: [${finding.kind}]`);
  console.log(`        ${finding.detail}`);
}
for (const allowance of unused) {
  console.log(
    `      - [免除が余っている] ${allowance.file} / ${allowance.reference}` +
      "（腐りとして挙がらなくなった。免除を消すこと）",
  );
}
for (const finding of remaining) {
  console.log(`      - ${finding.file}:${finding.line} [${finding.reason}] ${finding.text}`);
  console.log(`        ${finding.detail}`);
  console.log(`        行: ${truncate(finding.lineText, 140)}`);
}

console.log(
  "\n  限界: 実在するかしか見ない。実在するが別のものを指している参照、拡張子を書かない言及、" +
    "glob（`*` を含む記述）は検出しない。",
);

const violations = remaining.length + allowanceFindings.length + unused.length;
if (violations === 0) {
  console.log("\n違反 0 件。");
  process.exit(0);
}
console.error(`\n違反 ${violations} 件。`);
process.exit(1);

function truncate(s: string, n: number): string {
  return s.length <= n ? s : s.slice(0, n) + " …";
}
