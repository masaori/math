#!/usr/bin/env node
/**
 * **免除の穴が塞がったことの実証**（`verify-ja-en-detection-test.ts` の移植・拡張）。
 *
 * cycle 21 step 4 は、例外表に登録済みのブロックで英語版のインライン数式を **11 個落とした**のに、
 * 当時の日英対応検証を通過した（`outputs/reports/cycle21_ops_reflect_to_paper.md` §6.1）。
 * 当時の例外表はブロック単位の免除だったので、登録した時点でそのブロックの数式は見られなくなっていた。
 *
 * 「新しい形にしたら本番が緑だった」は、穴が塞がったことの根拠にならない。そこで
 * **実際に壊した版を作り、検査がそれを違反として挙げること**を確かめる。
 * **ファイルは 1 バイトも書き換えない**（読み込んだ値をメモリ上で壊すだけ）。
 *
 * cycle 24 step 2 で比較器をシステム側へ載せ替えたので、このテストも
 * `validateLocalizedRevision`（allowance つき）に対して回す。旧テストが守っていた性質
 * （登録済みブロックでも数式ノードの脱落は 1 つ残らず違反になる）が**載せ替え後も落ちること**を
 * ここで実測する。加えて、載せ替えで初めて検査対象になったもの（参照先・引用キー・意味メタデータ・
 * 翻訳限定ブロックの無断追加）も壊して確かめる。
 *
 * 使い方: node tools/verify-localization-detection-test.ts
 */

import { MATH_DIFFERENCE_EXCEPTIONS } from "../locales/en/structure-exceptions.ts";
import { allowancesFromConfig, buildSnapshot, checkStructure } from "./localization.ts";

/** cycle 21 step 4 が実際に落とした数式（report §6.1 の内訳そのまま）。 */
const CYCLE21_DROPPED = ["\\ell", "\\ell=2", "0", "2", "n=1", "n\\ge2", "\\le3"];

const baseline = await buildSnapshot();
const allowances = allowancesFromConfig();

const clone = (): typeof baseline => JSON.parse(JSON.stringify(baseline)) as typeof baseline;

type AnyRecord = Record<string, unknown>;

const englishBlocks = (snapshot: typeof baseline): AnyRecord[] => {
  const english = snapshot.localizations.find((entry) => entry.locale === "en");
  if (english === undefined) throw new Error("英語ロケールが無い");
  return english.revision.segments.flatMap((segment) => segment.blocks as unknown as AnyRecord[]);
};

/** ブロックの中の数式ノードを、深さ優先で親配列つきに列挙する。 */
const mathNodesOf = (block: AnyRecord): { parent: AnyRecord[]; index: number; tex: string }[] => {
  const found: { parent: AnyRecord[]; index: number; tex: string }[] = [];
  const walk = (nodes: AnyRecord[]): void => {
    nodes.forEach((node, index) => {
      if (node.type === "math" || node.type === "displayMath") {
        found.push({ parent: nodes, index, tex: String(node.tex) });
      }
      if (node.type === "paragraph") walk(node.children as AnyRecord[]);
      if (node.type === "list") (node.items as AnyRecord[][]).forEach(walk);
    });
  };
  walk((block.statement ?? []) as AnyRecord[]);
  walk((block.proof ?? []) as AnyRecord[]);
  return found;
};

const detects = (snapshot: typeof baseline): boolean => !checkStructure(snapshot, allowances).ok;

const missed: string[] = [];
let checked = 0;
let detected = 0;

console.log("ロケール対応検証の検出テスト（免除の穴が塞がったことの実証）");
console.log(`  例外表に登録されているブロック: ${Object.keys(MATH_DIFFERENCE_EXCEPTIONS).length} 件`);
if (!checkStructure(baseline, allowances).ok) {
  console.error("  現状が既に違反している。壊す前に verify-localization.ts を緑にすること。");
  process.exit(1);
}
console.log("");

// --- 1. 登録済みブロックの数式を 1 つずつ落とす --------------------------------
for (const id of Object.keys(MATH_DIFFERENCE_EXCEPTIONS)) {
  const probe = clone();
  const block = englishBlocks(probe).find((candidate) => candidate.id === id);
  if (block === undefined) {
    missed.push(`${id}: ブロックが見つからない（例外表が古い）`);
    continue;
  }
  const count = mathNodesOf(block).length;
  let blockDetected = 0;
  for (let i = 0; i < count; i += 1) {
    const broken = clone();
    const target = englishBlocks(broken).find((candidate) => candidate.id === id);
    if (target === undefined) continue;
    const nodes = mathNodesOf(target);
    const node = nodes[i];
    if (node === undefined) continue;
    node.parent.splice(node.index, 1);
    checked += 1;
    if (detects(broken)) {
      blockDetected += 1;
      detected += 1;
    } else {
      missed.push(`${id}: 英語版から「${node.tex.slice(0, 40)}」を落としても違反にならない`);
    }
  }
  console.log(`  ${id}: 英語版の数式 ${count} 個を 1 つずつ落として検査 → ${blockDetected} 個で違反`);
}

// --- 2. cycle 21 が実際に落とした形の再現 --------------------------------------
console.log("\n  cycle 21 step 4 が実際に落とした数式と同じ形の再現:");
let reproChecked = 0;
let reproDetected = 0;
for (const id of Object.keys(MATH_DIFFERENCE_EXCEPTIONS)) {
  const broken = clone();
  const block = englishBlocks(broken).find((candidate) => candidate.id === id);
  if (block === undefined) continue;
  const targets = mathNodesOf(block).filter((node) =>
    CYCLE21_DROPPED.includes(node.tex.replaceAll(/\s+/g, " ").trim()),
  );
  if (targets.length === 0) continue;
  // 後ろから消す（前から消すと index がずれる）。
  for (const node of [...targets].reverse()) node.parent.splice(node.index, 1);
  reproChecked += 1;
  const ok = detects(broken);
  if (ok) reproDetected += 1;
  else missed.push(`${id}: cycle 21 型の脱落を検出できない`);
  console.log(
    `      ${id}: ${targets.length} 個（${[...new Set(targets.map((t) => t.tex))].join(", ")}）を落とす → ` +
      `${ok ? "違反" : "**検出できない**"}`,
  );
}

// --- 3. 載せ替えで新たに検査対象になったもの -----------------------------------
console.log("\n  載せ替えで新たに検査対象になった壊し方:");
const newProbes: { name: string; mutate: (snapshot: typeof baseline) => void }[] = [
  {
    name: "参照先（ref.target）を別のラベルへ差し替える",
    mutate: (snapshot) => {
      for (const block of englishBlocks(snapshot)) {
        const walk = (nodes: AnyRecord[]): boolean => {
          for (const node of nodes) {
            if (node.type === "ref") {
              node.target = "paper_ladder";
              return true;
            }
            if (node.type === "paragraph" && walk(node.children as AnyRecord[])) return true;
            if (node.type === "list") {
              for (const item of node.items as AnyRecord[][]) if (walk(item)) return true;
            }
          }
          return false;
        };
        if (walk((block.statement ?? []) as AnyRecord[])) return;
      }
      throw new Error("ref ノードが見つからない");
    },
  },
  {
    name: "住処（habitat）を書き換える",
    mutate: (snapshot) => {
      const block = englishBlocks(snapshot).find((candidate) => candidate.habitat === "Lambda");
      if (block === undefined) throw new Error("habitat Lambda のブロックが無い");
      block.habitat = "Qbar";
    },
  },
  {
    name: "ℝ 脱出の宣言（realEscape）を落とす",
    mutate: (snapshot) => {
      const block = englishBlocks(snapshot).find((candidate) => candidate.realEscape !== undefined);
      if (block === undefined) throw new Error("realEscape を持つブロックが無い");
      delete block.realEscape;
    },
  },
  {
    name: "SageMath 検証の紐づけ（verification）を落とす",
    mutate: (snapshot) => {
      const block = englishBlocks(snapshot).find(
        (candidate) => Array.isArray(candidate.verification) && candidate.verification.length > 0,
      );
      if (block === undefined) throw new Error("verification を持つブロックが無い");
      block.verification = [];
    },
  },
  {
    name: "理由の無い翻訳限定ブロックを足す",
    mutate: (snapshot) => {
      const english = snapshot.localizations.find((entry) => entry.locale === "en");
      const segment = english?.revision.segments[0];
      if (segment === undefined) throw new Error("英語のセグメントが無い");
      (segment.blocks as unknown as AnyRecord[]).push({
        id: "paper_999_remark_unregistered",
        kind: "remark",
        labels: [],
        title: { text: "Unregistered" },
        statement: [],
        habitat: "none",
      });
    },
  },
  {
    name: "原文のブロックを英語版から落とす",
    mutate: (snapshot) => {
      const english = snapshot.localizations.find((entry) => entry.locale === "en");
      const segment = english?.revision.segments[0];
      if (segment === undefined) throw new Error("英語のセグメントが無い");
      (segment.blocks as unknown as AnyRecord[]).pop();
    },
  },
];

for (const probe of newProbes) {
  const broken = clone();
  probe.mutate(broken);
  checked += 1;
  const ok = detects(broken);
  if (ok) detected += 1;
  else missed.push(`新規: ${probe.name} を検出できない`);
  console.log(`      ${probe.name} → ${ok ? "違反" : "**検出できない**"}`);
}

console.log(
  `\n  結果: 壊し方 ${detected}/${checked} 件で違反、` +
    `cycle 21 型の脱落 ${reproDetected}/${reproChecked} ブロックで違反。`,
);
if (missed.length > 0) {
  console.error(`\n検出できなかったもの ${missed.length} 件:`);
  for (const line of missed) console.error(`  - ${line}`);
  process.exit(1);
}
console.log("  登録済みのブロックでも、骨格ノードの脱落は 1 つ残らず違反になる。");
process.exit(0);
