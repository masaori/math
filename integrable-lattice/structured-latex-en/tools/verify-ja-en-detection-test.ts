#!/usr/bin/env node
/**
 * **例外表の穴が塞がったことの実証。**
 *
 * cycle 21 step 4 は、`ja-en-exceptions.ts` に登録済みのブロックで英語版のインライン数式を
 * **11 個落とした**のに、日英対応検証を通過した（`outputs/reports/cycle21_ops_reflect_to_paper.md` §6.1）。
 * 当時の例外表はブロック単位の免除だったので、登録した時点でそのブロックの数式は見られなくなっていた。
 *
 * 「新しい形にしたら本番が緑だった」は、穴が塞がったことの根拠にならない。
 * そこで**登録済みの各ブロックについて、英語版の数式ノードを 1 つずつ落とした版を作り**、
 * 新しい検査がそれを違反として挙げることを確かめる。**ファイルは 1 バイトも書き換えない**
 * （読み込んだ値をメモリ上で落とすだけ）。
 *
 * 併せて、cycle 21 が実際に落とした 11 個の数式（`\ell` 3 個、`\ell=2` 4 個、
 * `0` `2` `n=1` `n\ge2` `\le3` 各 1 個）と同じ形の脱落を、登録済みブロックに対して再現する。
 *
 * 使い方: node tools/verify-ja-en-detection-test.ts
 */

import { loadContentFiles as loadJaContentFiles } from "../../structured-latex/tools/content-modules.ts";
import type { ConvertedBlock as JaBlock } from "../../structured-latex/schema.ts";
import type { ConvertedBlock as EnBlock, Node } from "../schema.ts";
import { loadContentFiles as loadEnContentFiles } from "./content-modules.ts";
import { explainDifferences } from "./ja-en-diff-rules.ts";
import { MATH_DIFFERENCE_EXCEPTIONS } from "./ja-en-exceptions.ts";

/** cycle 21 step 4 が実際に落とした数式（report §6.1 の内訳そのまま）。 */
const CYCLE21_DROPPED = ["\\ell", "\\ell=2", "0", "2", "n=1", "n\\ge2", "\\le3"];

const jaFormulas = new Map<string, string[]>();
for (const { blocks } of await loadJaContentFiles()) {
  for (const block of blocks) jaFormulas.set(block.id, formulasOf(block));
}
const enFormulas = new Map<string, string[]>();
for (const { blocks } of await loadEnContentFiles()) {
  for (const block of blocks) enFormulas.set(block.id, formulasOf(block));
}

let checked = 0;
let detected = 0;
const missed: string[] = [];

console.log("日英対応検証の検出テスト（例外表の穴が塞がったことの実証）");
console.log(`  例外表に登録されているブロック: ${Object.keys(MATH_DIFFERENCE_EXCEPTIONS).length} 件\n`);

for (const [id, exception] of Object.entries(MATH_DIFFERENCE_EXCEPTIONS)) {
  const ja = jaFormulas.get(id);
  const en = enFormulas.get(id);
  if (ja === undefined || en === undefined) {
    missed.push(`${id}: ブロックが見つからない（例外表が古い）`);
    continue;
  }
  let blockChecked = 0;
  let blockDetected = 0;
  for (let i = 0; i < en.length; i += 1) {
    const broken = en.filter((_, index) => index !== i);
    const { jaOnly, enOnly } = onlyIn(ja, broken);
    const result = explainDifferences(jaOnly, enOnly, exception.allow);
    blockChecked += 1;
    checked += 1;
    if (result.unexplainedJaOnly.length > 0 || result.unexplainedEnOnly.length > 0) {
      blockDetected += 1;
      detected += 1;
    } else {
      missed.push(`${id}: 英語版から「${en[i]}」を落としても違反にならない`);
    }
  }
  console.log(`  ${id}: 英語版の数式 ${blockChecked} 個を 1 つずつ落として検査 → ${blockDetected} 個で違反`);
}

// --- cycle 21 が実際に落とした 11 個と同じ形の再現 -------------------------------
console.log("\n  cycle 21 step 4 が実際に落とした数式と同じ形の再現:");
let reproChecked = 0;
let reproDetected = 0;
for (const [id, exception] of Object.entries(MATH_DIFFERENCE_EXCEPTIONS)) {
  const ja = jaFormulas.get(id);
  const en = enFormulas.get(id);
  if (ja === undefined || en === undefined) continue;
  const targets = CYCLE21_DROPPED.filter((tex) => en.includes(tex));
  if (targets.length === 0) continue;
  const broken = en.filter((tex) => !targets.includes(tex));
  const { jaOnly, enOnly } = onlyIn(ja, broken);
  const result = explainDifferences(jaOnly, enOnly, exception.allow);
  reproChecked += 1;
  const ok = result.unexplainedJaOnly.length > 0;
  if (ok) reproDetected += 1;
  else missed.push(`${id}: cycle 21 型の脱落（${targets.join(", ")}）を検出できない`);
  console.log(
    `      ${id}: ${targets.length} 個（${targets.join(", ")}）を落とす → ` +
      `${ok ? `違反 ${result.unexplainedJaOnly.length} 件` : "**検出できない**"}`,
  );
}

console.log(
  `\n  結果: 1 個ずつの脱落 ${detected}/${checked} 件で違反、` +
    `cycle 21 型の脱落 ${reproDetected}/${reproChecked} ブロックで違反。`,
);
if (missed.length > 0) {
  console.error(`\n検出できなかったもの ${missed.length} 件:`);
  for (const line of missed) console.error(`  - ${line}`);
  process.exit(1);
}
console.log("  登録済みのブロックでも、数式ノードの脱落は 1 つ残らず違反になる。");
process.exit(0);

// --- 補助 ---------------------------------------------------------------------

function formulasOf(block: JaBlock | EnBlock): string[] {
  const out: string[] = [];
  const theoremLike = block as { statement?: readonly Node[]; proof?: readonly Node[] };
  collect(theoremLike.statement ?? [], out);
  collect(theoremLike.proof ?? [], out);
  const title = block.kind === "figure" ? undefined : block.title;
  if (title?.tex !== undefined) out.push(title.tex);
  return out.map((tex) => tex.replaceAll(/\s+/g, " ").trim()).sort();
}

function collect(nodes: readonly Node[], out: string[]): void {
  for (const node of nodes) {
    if (node.type === "math" || node.type === "displayMath") out.push(node.tex);
    if (node.type === "paragraph") collect(node.children, out);
    if (node.type === "list") node.items.forEach((item) => collect(item, out));
  }
}

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
