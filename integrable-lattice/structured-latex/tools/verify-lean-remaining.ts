/**
 * **残り一覧の照合（`lean/` の一覧と検査 F の台帳）**。
 *
 * 設計と限界は `lean-remaining-model.ts` を正本とする。
 *
 * 対応表（どの `lean/` のファイルがどの主張に対応するか）は**宣言しない。機械が導く**——
 * 本文のブロックが宣言する Lean の定理名と、各ファイルが宣言する定理名の重なりで決める。
 * 宣言を二重に持つと片方だけが腐るので、導けるものは導く。
 */

import { readFileSync, readdirSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

import {
  LEAN_REMAINING_LEDGER,
  auditLeanRemaining,
  parseRemainingSection,
  type LeanRemainingFile,
  type LeanRemainingReferent,
} from "./lean-remaining-model.ts";
import { FORMALIZATION_COVERAGE } from "./formalization-coverage.ts";
import { EXTERNAL_THEOREM_COVERAGE } from "./external-theorem-coverage.ts";
import { loadContentFiles } from "./content-modules.ts";

const here = dirname(fileURLToPath(import.meta.url));
const leanDir = join(here, "..", "..", "lean", "IntegrableLattice");
const logDir = join(here, "..", "..", "lean", "logs");

const violations: string[] = [];

// --- 1. 節を持つファイルが 1 つ残らず台帳にあること -----------------------------
const leanFiles = readdirSync(leanDir).filter((name) => name.endsWith(".lean"));
const parsed = new Map<string, { heading: string; bullets: string[] }>();
for (const file of leanFiles) {
  const section = parseRemainingSection(readFileSync(join(leanDir, file), "utf8"));
  if (section) parsed.set(file, section);
}
const registered = new Map<string, LeanRemainingFile>(
  LEAN_REMAINING_LEDGER.map((entry) => [entry.file, entry]),
);
for (const file of parsed.keys()) {
  if (registered.has(file)) continue;
  violations.push(
    `[台帳に無いファイル] ${file} — 残り一覧の節を持つのに台帳に無い（黙って書き散らせない）`,
  );
}
for (const entry of LEAN_REMAINING_LEDGER) {
  if (parsed.has(entry.file)) continue;
  violations.push(`[宣言が余っている] ${entry.file} — 残り一覧の節が実在しない（改名・削除で浮いた）`);
}

// --- 対応表を導く（本文の lean 紐づけ × ファイルの宣言） -------------------------
const declaredIn = new Map<string, Set<string>>();
for (const file of leanFiles) {
  const names = new Set<string>();
  for (const m of readFileSync(join(leanDir, file), "utf8").matchAll(
    /^(?:private\s+|protected\s+|noncomputable\s+)*(?:theorem|lemma|def|abbrev|instance)\s+([A-Za-z_][A-Za-z0-9_'!?]*)/gm,
  )) {
    names.add(m[1]!);
  }
  declaredIn.set(file, names);
}
const ledgerText = new Map<string, string>();
for (const entry of FORMALIZATION_COVERAGE) {
  const text =
    entry.state === "完了"
      ? (entry.note ?? "")
      : entry.state === "部分的"
        ? entry.remaining
        : entry.reason;
  ledgerText.set(entry.block, text);
}
const ledgerState = new Map(FORMALIZATION_COVERAGE.map((e) => [e.block, e.state]));

/** そのファイルに対応する台帳エントリ（本文の紐づけ経由）。 */
const jaBlocks: { id: string; lean?: readonly string[] }[] = [];
for (const { blocks } of await loadContentFiles()) {
  for (const block of blocks) {
    jaBlocks.push(block as { id: string; lean?: readonly string[] });
  }
}

function blocksFor(file: string): string[] {
  const names = declaredIn.get(file) ?? new Set<string>();
  const out: string[] = [];
  for (const block of jaBlocks) {
    const leanNames: readonly string[] = (block as { lean?: readonly string[] }).lean ?? [];
    if (leanNames.length === 0) continue;
    const hit = leanNames.some((name) => names.has(name.split(".").pop()!));
    if (hit) out.push(block.id);
  }
  return out;
}

// --- 外部定理の台帳（紐づかないファイルの照合先） -------------------------------
const externalText = new Map<string, string>();
for (const entry of EXTERNAL_THEOREM_COVERAGE) {
  const e = entry as unknown as Record<string, string>;
  externalText.set(
    e.name!,
    [e.remaining, e.note, e.presence, e.wiring, e.isolation, e.notAGround, e.absence]
      .filter((x) => typeof x === "string")
      .join(" "),
  );
}
for (const entry of LEAN_REMAINING_LEDGER) {
  if (entry.externalEntry === undefined) continue;
  if (externalText.has(entry.externalEntry)) continue;
  violations.push(
    `[externalEntry が実在しない] ${entry.file} — 外部定理の台帳に「${entry.externalEntry}」が無い`,
  );
}

// --- 「参照だけ」の指し先を解決する ---------------------------------------------
const logFiles = readdirSync(logDir);
const logBodies = logFiles.map((name) => readFileSync(join(logDir, name), "utf8"));
function referentExists(referent: LeanRemainingReferent): boolean {
  if (referent.kind === "lean ファイル") return leanFiles.includes(referent.target);
  if (referent.kind === "ログ") return logFiles.includes(referent.target);
  return logBodies.some((body) => body.includes(referent.target));
}

// --- 2〜5. 件数・実在・台帳への反映 ---------------------------------------------
const counts = { 未形式化: 0, 形式化済み: 0, 参照だけ: 0 };
let unlinked = 0;
for (const entry of LEAN_REMAINING_LEDGER) {
  const section = parsed.get(entry.file);
  if (!section) continue;
  const linked = blocksFor(entry.file).map((block) => ({
    block,
    text: ledgerText.get(block) ?? "",
    state: String(ledgerState.get(block) ?? ""),
  }));
  const result = auditLeanRemaining({
    entry,
    section,
    linked,
    externalText:
      entry.externalEntry === undefined ? null : (externalText.get(entry.externalEntry) ?? null),
    referentExists,
  });
  violations.push(...result.violations);
  counts.未形式化 += result.counts.未形式化;
  counts.形式化済み += result.counts.形式化済み;
  counts.参照だけ += result.counts.参照だけ;
  unlinked += result.unlinked;
}

console.log("");
console.log("`lean/` の残り一覧と台帳の照合");
console.log(
  `  残り一覧を持つファイル ${parsed.size} 件 / 箇条書き ` +
    `${[...parsed.values()].reduce((n, s) => n + s.bullets.length, 0)} 件`,
);
console.log(
  `  分類: 未形式化 ${counts.未形式化} 件 / 形式化済み ${counts.形式化済み} 件 / ` +
    `参照だけ ${counts.参照だけ} 件`,
);
console.log(
  `  本文の主張へ紐づかないファイルの未形式化項目 ${unlinked} 件` +
    `（cycle 34 step 3 以降は、外部定理の台帳のエントリと突き合わせている）`,
);
console.log(
  "  **分類そのものは人の判断である。** ただし cycle 34 step 3 で 2 つの逃げ道を塞いだ——" +
    "(1) 本文へ紐づかないファイルは `externalEntry` の宣言を要求し、無ければ違反にする。" +
    "(2) 「参照だけ」は実在を確かめられる指し先（lean ファイル / ログ / mathlib）を型で要求する。",
);
console.log(
  "  限界: `ledgerFragment` が台帳に在ることは確かめられるが、それが同じ事柄を指しているかは" +
    "確かめられない（検査の強さの上限は台帳の書き手が選んだ語の妥当性である）。",
);

if (violations.length > 0) {
  console.log("");
  console.log(`違反 ${violations.length} 件`);
  for (const violation of violations) console.log(`    ${violation}`);
  console.log("");
  console.log("  直し方: `lean/` の一覧を正として、検査 F の台帳（formalization-coverage.ts）へ写す。");
  console.error(`違反 ${violations.length} 件。`);
  process.exit(1);
}
console.log("");
console.log("違反 0 件。");
