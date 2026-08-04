/**
 * **検査 F（形式化の被覆）**。本文の全主張について形式化の状態が宣言されていること、
 * 宣言が腐っていないこと、宣言された Lean の定理名が実在することを確かめ、
 * **未形式化の件数を毎回出す**。
 *
 * 目標と語彙は `formalization-coverage.ts` の doc を正本とする。要点だけ:
 * **論文の主張を全数 Lean 形式化することが目標である**（2026-08-03 ユーザー方針）。
 * 一部の形式化で足れりとしないので、残りが何件・どれかを毎サイクル見えるようにする。
 */

import { readFileSync, readdirSync } from "node:fs";
import { join } from "node:path";

import { loadContentFiles, structuredLatexDir } from "./content-modules.ts";
import { type CoverageState, FORMALIZATION_COVERAGE } from "./formalization-coverage.ts";

const leanDir = join(structuredLatexDir, "..", "lean", "IntegrableLattice");

const declaredInLean = new Set<string>();
for (const file of readdirSync(leanDir).filter((name) => name.endsWith(".lean"))) {
  const source = readFileSync(join(leanDir, file), "utf8");
  for (const match of source.matchAll(
    /^(?:private\s+|protected\s+|noncomputable\s+)*(?:theorem|lemma|def|abbrev|instance)\s+([A-Za-z_][A-Za-z0-9_'!?]*)/gm,
  )) {
    declaredInLean.add(match[1]!);
  }
}

type Claim = { id: string; title: string; leanNames: readonly string[] };
const claims: Claim[] = [];
for (const { blocks } of await loadContentFiles()) {
  for (const block of blocks) {
    if (block.kind !== "theorem" && block.kind !== "claim") continue;
    claims.push({
      id: block.id,
      title: block.title?.text ?? "",
      leanNames: block.lean ?? [],
    });
  }
}

const byBlock = new Map(FORMALIZATION_COVERAGE.map((entry) => [entry.block, entry] as const));
const violations: string[] = [];

for (const claim of claims) {
  const entry = byBlock.get(claim.id);
  if (entry === undefined) {
    violations.push(
      `[台帳に無い主張] ${claim.id}（${claim.title}）— 形式化の状態を宣言すること（黙って落とせない）`,
    );
    continue;
  }
  if (entry.state !== "未着手" && claim.leanNames.length === 0) {
    violations.push(
      `[${entry.state} なのに Lean の紐づけが無い] ${claim.id} — 形式化したと言うなら読者が辿れる先が要る`,
    );
  }
  if (entry.state === "未着手" && claim.leanNames.length > 0) {
    violations.push(
      `[未着手なのに Lean の紐づけがある] ${claim.id} — 紐づけがあるなら少なくとも「部分的」である`,
    );
  }
  for (const name of claim.leanNames) {
    const short = name.replace(/^IntegrableLattice\./, "");
    if (declaredInLean.has(short)) continue;
    violations.push(`[Lean に実在しない定理名] ${claim.id} — ${name}`);
  }
}

const claimIds = new Set(claims.map((claim) => claim.id));
for (const entry of FORMALIZATION_COVERAGE) {
  if (claimIds.has(entry.block)) continue;
  violations.push(`[宣言が余っている] ${entry.block} — その主張は本文に無い（改名・削除で浮いた）`);
}

const counts: Record<CoverageState, number> = { 完了: 0, 部分的: 0, 未着手: 0 };
for (const entry of FORMALIZATION_COVERAGE) counts[entry.state] += 1;
const unformalised = FORMALIZATION_COVERAGE.filter((entry) => entry.state !== "完了");

console.log("");
console.log("形式化の被覆の検査（検査 F）");
console.log("  目標: 論文の主張を全数 Lean 形式化する（2026-08-03 ユーザー方針）。");
console.log(
  `  本文の主張（theorem / claim）${claims.length} 件 / 台帳 ${FORMALIZATION_COVERAGE.length} 件 /` +
    ` lean/ の宣言 ${declaredInLean.size} 件`,
);
console.log(
  `  状態: 完了 ${counts.完了} 件 / 部分的 ${counts.部分的} 件 / 未着手 ${counts.未着手} 件`,
);
console.log(`  **全数形式化まで残り ${unformalised.length} 件**（完了でないもの）`);
console.log("");
for (const entry of unformalised) {
  const detail = entry.state === "部分的" ? entry.remaining : entry.reason;
  console.log(`    [${entry.state}] ${entry.block}`);
  console.log(`      残り／理由: ${detail}`);
}

if (violations.length > 0) {
  console.log("");
  console.log(`  違反 ${violations.length} 件`);
  for (const violation of violations) console.log(`    ${violation}`);
  console.log("");
  console.log("  直し方: `tools/formalization-coverage.ts` の宣言を実態へ合わせる。");
  console.log("  形式化できない主張は、黙って落とさず、何がなぜできないかを一次情報で書くこと。");
  console.log("");
  console.log(`違反 ${violations.length} 件。`);
  process.exit(1);
}

console.log("");
console.log(
  "  限界: 「完了」が本当に完了かは機械で確かめられない（人の判断）。" +
    "この検査が保証するのは、判断が書かれていることと、書かれた判断が腐っていないことだけである。",
);
console.log("");
console.log("違反 0 件。");
