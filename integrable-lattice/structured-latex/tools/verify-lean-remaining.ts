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
  auditDeclarationCount,
  auditCrossFilePhrase,
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

// --- 宣言の数の再確認（cycle 36 step 4。`未形式化` の側の穴への手当て） -------------
// 残り一覧が古くなるのは、そのファイルに宣言が増減したときだけである。
// 数が食い違ったら、残り一覧を読み直して未形式化かを確かめてから数を直すことを要求する。
const declCount = new Map<string, number>();
for (const file of leanFiles) {
  declCount.set(
    file,
    [
      ...readFileSync(join(leanDir, file), "utf8").matchAll(
        /^(?:private\s+|protected\s+|noncomputable\s+)*(?:theorem|lemma|def|abbrev|instance)\s+([A-Za-z_][A-Za-z0-9_'!?]*)/gm,
      ),
    ].length,
  );
}
let reviewChecked = 0;
for (const entry of LEAN_REMAINING_LEDGER) {
  const actual = declCount.get(entry.file);
  if (actual === undefined) continue;
  reviewChecked += 1;
  const v = auditDeclarationCount(entry, actual);
  if (v !== null) violations.push(v);
}

// --- 別のファイルが同じ事柄を書いていないか（cycle 37 step 4） ---------------------
// cycle 36 step 4 の鈴は「そのファイルの宣言が増減したときだけ鳴る」ので、
// 別のファイルに書かれた場合に鳴らなかった（cycle 37 が同じサイクル内で 2 回それをやった）。
// 項目ごとに語を宣言させ、他のファイルの本文（そのファイル自身の残り一覧を除く）に
// その語が現れたら読み直しを強制する。現れた側も同じ語を `未形式化` と宣言していれば通す。
const bodyWithoutRemaining = new Map<string, string>();
for (const file of leanFiles) {
  const text = readFileSync(join(leanDir, file), "utf8");
  const section = parsed.get(file);
  if (!section) {
    bodyWithoutRemaining.set(file, text);
    continue;
  }
  // 残り一覧の節（見出しから次の `##` か doc コメントの終わりまで）を落とす。
  const headingIndex = text.indexOf(`## ${section.heading}`);
  if (headingIndex < 0) {
    bodyWithoutRemaining.set(file, text);
    continue;
  }
  const rest = text.slice(headingIndex);
  const endRelative = rest.slice(3).search(/\n## |\n-\/|\n\/-!/);
  const end = endRelative < 0 ? text.length : headingIndex + 3 + endRelative;
  bodyWithoutRemaining.set(file, text.slice(0, headingIndex) + text.slice(end));
}
const unformalizedPhrases = new Map<string, Set<string>>();
for (const entry of LEAN_REMAINING_LEDGER) {
  const set = new Set<string>();
  for (const item of entry.items) {
    if (item.kind === "未形式化") set.add(item.crossFilePhrase);
  }
  unformalizedPhrases.set(entry.file, set);
}
let crossChecked = 0;
let crossAgreed = 0;
for (const entry of LEAN_REMAINING_LEDGER) {
  for (const item of entry.items) {
    if (item.kind !== "未形式化") continue;
    crossChecked += 1;
    for (const other of leanFiles) {
      if (other === entry.file) continue;
      const body = bodyWithoutRemaining.get(other);
      if (body === undefined || !body.includes(item.crossFilePhrase)) continue;
      const agrees = unformalizedPhrases.get(other)?.has(item.crossFilePhrase) ?? false;
      if (agrees) {
        crossAgreed += 1;
        continue;
      }
      const v = auditCrossFilePhrase(entry.file, item.crossFilePhrase, other, agrees);
      if (v !== null) violations.push(v);
    }
  }
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

// --- 「形式化済み」の証拠（実在する宣言）を解決する（cycle 35 step 5）-------------
const allDeclarations = new Set<string>();
for (const names of declaredIn.values()) for (const name of names) allDeclarations.add(name);
function declarationExists(name: string): boolean {
  return allDeclarations.has(name.replace(/^.*\./, ""));
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
    declarationExists,
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
  "  **cycle 35 step 5 で「形式化済み」にも証拠を要求するようにした**——" +
    "その項目を形式化した定理の名前を型で必須にし、`lean/` に実在することを確かめる。" +
    "**これが 2 サイクル持ち越していた「台帳と `lean/` の両方が同じだけ古い」穴の、塞げる側である**" +
    "（形式化済みと書いた当の定理を消せば赤くなる。入れた時点で、名前の取り違えが 2 件見つかった）。\n" +
    "  限界: `ledgerFragment` が台帳に在ることは確かめられるが、それが同じ事柄を指しているかは確かめられない（検査の強さの上限は台帳の書き手が選んだ語の妥当性である）。" +
    "\n  限界（cycle 35 時点で塞げていなかった側）: **`未形式化` と書いた項目については、" +
    "「まだ書いていない」ことを witness で示すことができない**（実在しない宣言は名指せない）。",
);
console.log(
  `  **cycle 36 step 4 で、その側に別の道から手当てをした**（宣言の数の再確認 ${reviewChecked} 件）——` +
    "「書いていないこと」を機械に言わせるのは諦め、**危険が生じた瞬間に人へ読み直しを強制する**形にした。" +
    "残り一覧が古くなるのはそのファイルに宣言が増減したときだけなので、" +
    "**宣言の数を台帳に持ち、実際の数と食い違ったら違反にする。**" +
    "書き足した人は、残り一覧を読み直して、まだ未形式化かを確かめてからこの数を直すことになる。\n" +
    "  限界: **数を直すときに本当に読み直したかは確かめられない**（数だけ合わせて通せる）。" +
    "強制できるのは読み直す機会が必ず訪れることだけである。" +
    "また**別ファイルに書いた場合は宣言が増えないので捕まらない**（そこは人の読みのままである）。",
);
console.log(
  `  **cycle 37 step 4 で、その「別ファイルに書いた場合」を塞いだ**` +
    `（項目ごとの語の走査 ${crossChecked} 件 / 両方が未形式化で一致した組 ${crossAgreed} 件）——` +
    "**cycle 36 step 4 の観察（残り一覧が古くなるのは宣言が増減したときだけ）は誤りだった。" +
    "cycle 37 が同じサイクルの中で 2 回反例を作った**" +
    "（`EulerDualBasisCommRing.lean` の「当てはめ」が `WStarPowerBasisInstance.lean` へ、" +
    "`TracePeriodAssembly.lean` の `hlift` の段が `TracePeriodWStarLift.lean` へ書かれ、" +
    "どちらも元のファイルの宣言は 1 つも増えなかった）。\n" +
    "  塞ぎ方は、項目ごとに語を宣言させ、**他のファイルの本文（そのファイル自身の残り一覧を除く）に" +
    "その語が現れたら読み直しを強制する**ことである。" +
    "**逃げ道は 1 つだけで、現れた側も同じ語を `未形式化` と宣言している場合に限り通す**" +
    "（形式化した側を黙らせるためには使えない）。\n" +
    "  限界: **語の選び方が検査の強さの上限である**（違う言い方で書けば素通りする）。" +
    "語が広すぎれば偽陽性が出る。" +
    "また分かるのは「同じ語について書いている」ことまでで、「形式化した」ことは分からない。",
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
