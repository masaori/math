#!/usr/bin/env node
/**
 * **日本語版と英語版の対応を機械検証する。**
 *
 * この作業の絶対条件は「日本語版を失わない可逆な構成にすること」である。
 * 散文の約束にすると必ず腐るので、ここで検査可能な形にした。日本語版
 * `../structured-latex/content/` は正本であり、**このツールは一切書き換えない**（読むだけ）。
 *
 * 検査する不変条件:
 *   1. 日本語版のブロック id が、英語版にすべて存在する（欠落 ＝ 内容の喪失）。
 *   2. 対応するブロックの `kind` が一致する。
 *   3. 対応するブロックの `labels` の**集合**が一致する。
 *   4. 日本語版のラベルが英語版にすべて存在する（相互参照の可逆性）。
 *   5. 対応するブロックの `habitat` が一致する。
 *      `realEscape` は英訳されるので文字列一致は求めないが、**片方だけ有る／無いは違反**。
 *   6. 対応するブロックの `proof` の有無・`verification`・`lean` が一致する。
 *   7. 対応するブロックの数式（`math` / `displayMath` の `tex`）の**多重集合**が一致する。
 *      数式は翻訳の対象ではないので、ずれていれば訳し落としか無断の書き換えである。
 *      正当な差は `ja-en-exceptions.ts` に**理由と、許す差の種類つきで**登録したものだけ許す。
 *      **免除の単位はブロックではなく差分 1 つである。** ブロック単位の免除は cycle 21 で
 *      実際に検査の穴になり、英語版のインライン数式 11 個の脱落を隠した
 *      （`outputs/reports/cycle21_ops_reflect_to_paper.md` §6.1）。登録済みのブロックでも、
 *      宣言した規則で説明できない差が 1 つでも残れば違反として報告する。
 *   8. 英語版にしか無いブロックは、`en-only-blocks.ts` に**理由つきで**登録したものだけ許す。
 *
 * なぜ `npm run check` に入れず `npm run check:full` に分けてあるか:
 *   本文の英訳は後続の作業であり、翻訳が終わるまでこの検証は必ず「欠落」で落ちる。
 *   常に落ちる検査を `check` に入れると `check` が「無視するもの」になり、
 *   `check` が守っている他の不変条件まで一緒に無視される。**落ちてよい検査と、
 *   落ちてはいけない検査を混ぜない**ために分けてある。翻訳が完了して緑になったら
 *   `check` へ移してよい（そのときこのコメントも直すこと）。
 *
 * 使い方: node tools/verify-ja-en-correspondence.ts
 */

import { loadContentFiles as loadJaContentFiles } from "../../structured-latex/tools/content-modules.ts";
import type { ConvertedBlock as JaBlock } from "../../structured-latex/schema.ts";
import type { ConvertedBlock as EnBlock, Node } from "../schema.ts";
import { loadContentFiles as loadEnContentFiles } from "./content-modules.ts";
import { EN_ONLY_BLOCKS } from "./en-only-blocks.ts";
import { explainDifferences } from "./ja-en-diff-rules.ts";
import { MATH_DIFFERENCE_EXCEPTIONS } from "./ja-en-exceptions.ts";

/** 比較に使う、言語に依らないブロックの見え方。 */
type Facet = {
  id: string;
  file: string;
  kind: string;
  labels: readonly string[];
  habitat: string | undefined;
  hasRealEscape: boolean;
  hasProof: boolean;
  verification: readonly string[];
  lean: readonly string[];
  /** 数式の多重集合（ソート済みの列として持つ）。 */
  formulas: readonly string[];
};

type Violation = { category: string; detail: string };

const violations: Violation[] = [];

const jaFiles = await loadJaContentFiles();
const enFiles = await loadEnContentFiles();

const ja = new Map<string, Facet>();
const jaOrder: string[] = [];
for (const { file, blocks } of jaFiles) {
  for (const block of blocks) {
    ja.set(block.id, facetOf(block, file));
    jaOrder.push(block.id);
  }
}

const en = new Map<string, Facet>();
for (const { file, blocks } of enFiles) {
  for (const block of blocks) {
    en.set(block.id, facetOf(block, file));
  }
}

// --- 1. 日本語版のブロックがすべて英語版にあること -----------------------------
const missing = jaOrder.filter((id) => !en.has(id));
for (const id of missing) {
  const facet = ja.get(id);
  violations.push({
    category: "英語版に欠落しているブロック（内容の喪失）",
    detail: `${id} [${facet?.kind}] （日本語版 ${facet?.file}）`,
  });
}

// --- 8. 英語版にしか無いブロックは、理由つきで登録されたものだけ ----------------
for (const [id, facet] of en) {
  if (ja.has(id)) continue;
  const reason = EN_ONLY_BLOCKS[id];
  if (reason === undefined) {
    violations.push({
      category: "理由の無い英語版限定ブロック",
      detail:
        `${id} [${facet.kind}]（英語版 ${facet.file}）。` +
        "日本語版に対応物が無い。tools/en-only-blocks.ts へ id と理由を書くこと。",
    });
  } else if (reason.trim() === "") {
    violations.push({
      category: "英語版限定ブロックの理由が空",
      detail: `${id}: tools/en-only-blocks.ts の理由が空文字である。理由を書くこと。`,
    });
  }
}

// --- 2〜7. 対応するブロック同士の比較 -----------------------------------------
let compared = 0;
let explainedByRule = 0;
for (const id of jaOrder) {
  const a = ja.get(id);
  const b = en.get(id);
  if (a === undefined || b === undefined) continue;
  compared += 1;

  if (a.kind !== b.kind) {
    violations.push({ category: "kind の不一致", detail: `${id}: 日本語版 ${a.kind} / 英語版 ${b.kind}` });
  }

  const labelDiff = diffSets(a.labels, b.labels);
  if (labelDiff !== undefined) {
    violations.push({ category: "labels の不一致", detail: `${id}: ${labelDiff}` });
  }

  if (a.habitat !== b.habitat) {
    violations.push({
      category: "habitat の不一致（住処は翻訳の対象ではない）",
      detail: `${id}: 日本語版 ${String(a.habitat)} / 英語版 ${String(b.habitat)}`,
    });
  }
  if (a.hasRealEscape !== b.hasRealEscape) {
    violations.push({
      category: "realEscape の有無の不一致",
      detail:
        `${id}: 日本語版 ${a.hasRealEscape ? "有" : "無"} / 英語版 ${b.hasRealEscape ? "有" : "無"}` +
        "（文言は英訳されてよいが、ℝ 脱出の宣言そのものは失ってはならない）",
    });
  }

  if (a.hasProof !== b.hasProof) {
    violations.push({
      category: "proof の有無の不一致",
      detail: `${id}: 日本語版 ${a.hasProof ? "有" : "無"} / 英語版 ${b.hasProof ? "有" : "無"}`,
    });
  }
  const verificationDiff = diffSets(a.verification, b.verification);
  if (verificationDiff !== undefined) {
    violations.push({ category: "verification の不一致", detail: `${id}: ${verificationDiff}` });
  }
  const leanDiff = diffSets(a.lean, b.lean);
  if (leanDiff !== undefined) {
    violations.push({ category: "lean の不一致", detail: `${id}: ${leanDiff}` });
  }

  // --- 7. 数式の多重集合 ---
  // **免除はブロック単位ではなく差分 1 つ単位である**（cycle 21 でブロック単位の免除が
  // 数式ノード 11 個の脱落を隠した。tools/ja-en-exceptions.ts の冒頭を参照）。
  const { jaOnly, enOnly } = onlyIn(a.formulas, b.formulas);
  const exception = MATH_DIFFERENCE_EXCEPTIONS[id];
  if (jaOnly.length === 0 && enOnly.length === 0) {
    if (exception !== undefined) {
      violations.push({
        category: "不要な例外登録",
        detail: `${id}: 数式は一致しているのに tools/ja-en-exceptions.ts に登録されている。消すこと。`,
      });
    }
  } else if (exception === undefined) {
    violations.push({
      category: "数式の不一致（訳し落とし・無断の改変）",
      detail: `${id}: ${describeDiff(jaOnly, enOnly)}`,
    });
  } else if (exception.reason.trim() === "") {
    violations.push({
      category: "数式差の例外の理由が空",
      detail: `${id}: tools/ja-en-exceptions.ts の理由が空文字である。理由の無い例外は認めない。`,
    });
  } else {
    const result = explainDifferences(jaOnly, enOnly, exception.allow);
    explainedByRule += result.explained.length;
    if (result.unexplainedJaOnly.length > 0 || result.unexplainedEnOnly.length > 0) {
      violations.push({
        category: "例外の規則で説明できない数式差（登録があっても免除されない）",
        detail:
          `${id}: 許した規則 [${exception.allow.join(", ")}] では説明できない差が残った。\n` +
          describeDiff(result.unexplainedJaOnly, result.unexplainedEnOnly),
      });
    }
    for (const rule of result.unusedRules) {
      violations.push({
        category: "使われていない例外規則（登録が古い）",
        detail: `${id}: 規則 ${rule} は 1 度も使われなかった。tools/ja-en-exceptions.ts から消すこと。`,
      });
    }
  }
}

// --- 4. 日本語版のラベルがすべて英語版にあること --------------------------------
const jaLabels = new Set<string>();
for (const facet of ja.values()) for (const label of facet.labels) jaLabels.add(label);
const enLabels = new Set<string>();
for (const facet of en.values()) for (const label of facet.labels) enLabels.add(label);
const missingLabels = [...jaLabels].filter((label) => !enLabels.has(label)).sort();
for (const label of missingLabels) {
  violations.push({
    category: "英語版に欠落しているラベル（相互参照が復元できない）",
    detail: label,
  });
}

// --- 報告 ---------------------------------------------------------------------
console.log("日英対応検証");
console.log(`  日本語版: ${ja.size} ブロック / ${jaLabels.size} ラベル（${jaFiles.length} ファイル）`);
console.log(`  英語版:   ${en.size} ブロック / ${enLabels.size} ラベル（${enFiles.length} ファイル）`);
console.log(`  突き合わせた対応ブロック: ${compared} 件`);
console.log(`  英語版に欠落しているブロック: ${missing.length} 件`);
console.log(`  英語版に欠落しているラベル: ${missingLabels.length} 件`);
console.log(`  英語版限定ブロック: ${[...en.keys()].filter((id) => !ja.has(id)).length} 件`);
console.log(
  `  例外表: 数式差 ${Object.keys(MATH_DIFFERENCE_EXCEPTIONS).length} ブロック` +
    `（規則で説明した差分 ${explainedByRule} 件。**免除はブロック単位ではなく差分 1 つ単位**） / ` +
    `英語版限定 ${Object.keys(EN_ONLY_BLOCKS).length} 件`,
);

if (violations.length === 0) {
  console.log("\n違反 0 件: 英語版は日本語版の内容を 1 件も失っていない。");
  process.exit(0);
}

const byCategory = new Map<string, string[]>();
for (const violation of violations) {
  const list = byCategory.get(violation.category) ?? [];
  list.push(violation.detail);
  byCategory.set(violation.category, list);
}

console.error(`\n違反 ${violations.length} 件:`);
for (const [category, details] of byCategory) {
  console.error(`\n[${category}] ${details.length} 件`);
  for (const detail of details) console.error(`  - ${detail}`);
}
process.exit(1);

// --- 補助 ---------------------------------------------------------------------

function facetOf(block: JaBlock | EnBlock, file: string): Facet {
  const theoremLike = block as {
    habitat?: string;
    realEscape?: string;
    verification?: readonly string[];
    lean?: readonly string[];
    proof?: readonly Node[];
    statement?: readonly Node[];
  };
  const formulas: string[] = [];
  collectFormulas(theoremLike.statement ?? [], formulas);
  collectFormulas(theoremLike.proof ?? [], formulas);
  // タイトルの tex も数式である（訳されない）。
  const title = block.kind === "figure" ? undefined : block.title;
  if (title !== null && title !== undefined && title.tex !== undefined) formulas.push(title.tex);
  return {
    id: block.id,
    file,
    kind: block.kind,
    labels: [...block.labels],
    habitat: theoremLike.habitat,
    hasRealEscape: theoremLike.realEscape !== undefined,
    hasProof: (theoremLike.proof ?? []).length > 0,
    verification: [...(theoremLike.verification ?? [])],
    lean: [...(theoremLike.lean ?? [])],
    formulas: formulas.map(normalizeFormula).sort(),
  };
}

/**
 * 数式の正規化。**中身は変えない。** 改行とインデントの入れ方は原稿整形の都合で変わりうるので、
 * 連続する空白を 1 つに畳んで前後を落とすところまでだけを揃える。
 * 記号を書き換えるような正規化はしない（それをすると訳し落としを見逃す）。
 */
function normalizeFormula(tex: string): string {
  return tex.replaceAll(/\s+/g, " ").trim();
}

function collectFormulas(nodes: readonly Node[], out: string[]): void {
  for (const node of nodes) {
    if (node.type === "math" || node.type === "displayMath") out.push(node.tex);
    if (node.type === "paragraph") collectFormulas(node.children, out);
    if (node.type === "list") node.items.forEach((item) => collectFormulas(item, out));
  }
}

/** 集合として違うなら差分の説明を返す。同じなら undefined。 */
function diffSets(a: readonly string[], b: readonly string[]): string | undefined {
  const setA = new Set(a);
  const setB = new Set(b);
  const onlyJa = [...setA].filter((value) => !setB.has(value)).sort();
  const onlyEn = [...setB].filter((value) => !setA.has(value)).sort();
  if (onlyJa.length === 0 && onlyEn.length === 0) return undefined;
  return (
    `日本語版のみ: ${onlyJa.join(", ") || "なし"} / 英語版のみ: ${onlyEn.join(", ") || "なし"}`
  );
}

/** 多重集合の差を「日本語版にしか無い側」「英語版にしか無い側」へ分けて返す。 */
function onlyIn(a: readonly string[], b: readonly string[]): { jaOnly: string[]; enOnly: string[] } {
  const count = (values: readonly string[]): Map<string, number> => {
    const map = new Map<string, number>();
    for (const value of values) map.set(value, (map.get(value) ?? 0) + 1);
    return map;
  };
  const countA = count(a);
  const countB = count(b);
  const jaOnly: string[] = [];
  const enOnly: string[] = [];
  for (const key of new Set([...countA.keys(), ...countB.keys()])) {
    const diff = (countA.get(key) ?? 0) - (countB.get(key) ?? 0);
    for (let i = 0; i < diff; i += 1) jaOnly.push(key);
    for (let i = 0; i < -diff; i += 1) enOnly.push(key);
  }
  return { jaOnly: jaOnly.sort(), enOnly: enOnly.sort() };
}

function describeDiff(jaOnly: readonly string[], enOnly: readonly string[]): string {
  const lines: string[] = [];
  for (const tex of jaOnly) lines.push(`    日本語版にしか無い: ${tex}`);
  for (const tex of enOnly) lines.push(`    英語版にしか無い:   ${tex}`);
  return lines.join("\n");
}
