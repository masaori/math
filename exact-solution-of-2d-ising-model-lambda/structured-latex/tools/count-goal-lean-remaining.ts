#!/usr/bin/env node
/**
 * ゴール（Onsager 閉形式まで）の到達点から依存を辿り、Lean で閉じていないブロックを数える。
 *
 * 研究管理は、この出力で進み具合・残りの見込み・積み上げの順序を決める。数え方が回ごとに違うと、
 * 件数の推移から減る速さを読めないので、数え方をここに固定する。
 *
 * - 依存: 本文・証明に現れる `ref` ノードの target と、数式中の `\blkref{<ラベル>}`。
 * - Lean の無いもの: 閉包の中で `lean` の対応先を持たない定義・主張・定理・注意。
 * - 必要十分版に頼る具体版: 閉包の中で、`lean` の対応先が例外の台帳
 *   `lean/concrete-necsuf-delegations.txt` に載っているブロック。
 * - 着手できるもの: Lean の無いもののうち、直接の依存に Lean の無いものが一つも無いもの。
 * - 最長の鎖: Lean の無いものだけを辿る依存の最長の列。積み上げを一本で進める限り、
 *   残りはこの長さの回数より早くは終わらない。
 *
 * 使い方: node structured-latex/tools/count-goal-lean-remaining.ts [--tsv]
 *   --tsv を付けると、推移の記録 docs/tasks/goal-lean-remaining.tsv の一行の形で出す。
 */

import { execFileSync } from "node:child_process";
import { readFileSync } from "node:fs";
import { join } from "node:path";

import { loadContentFiles, structuredLatexDir } from "./content-modules.ts";

/** README の完了条件が名指す到達点。変えるときは研究管理の記録に理由を書く。 */
export const GOAL_TARGETS = [
  "theorem_periodic_density_onsager_integral",
  "claim_onsager_hyperbolic_integral_form",
  "claim_dispersion_minimum_self_dual_point",
  "claim_determinant_square_root_torus_formula",
] as const;

const COUNTED_KINDS = new Set(["definition", "claim", "theorem", "remark"]);
const BLKREF_RE = /\\blkref\{([^}]+)\}/g;

type Block = {
  id: string;
  kind: string;
  title?: { text?: string };
  labels?: readonly string[];
  lean?: readonly string[];
};

function collectReferences(value: unknown, out: Set<string>): void {
  if (typeof value === "string") {
    for (const match of value.matchAll(BLKREF_RE)) if (match[1] !== undefined) out.add(match[1]);
    return;
  }
  if (Array.isArray(value)) {
    for (const item of value) collectReferences(item, out);
    return;
  }
  if (typeof value === "object" && value !== null) {
    const record = value as Record<string, unknown>;
    if (record.type === "ref" && typeof record.target === "string") out.add(record.target);
    for (const [key, child] of Object.entries(record)) if (key !== "lean") collectReferences(child, out);
  }
}

const files = await loadContentFiles();
const blocks = files.flatMap((file) => file.blocks) as unknown as Block[];
const byLabel = new Map<string, Block>();
for (const block of blocks) for (const label of block.labels ?? []) byLabel.set(label, block);

const dependencies = new Map<Block, Block[]>();
for (const block of blocks) {
  const refs = new Set<string>();
  collectReferences(block, refs);
  dependencies.set(
    block,
    [...refs].map((label) => byLabel.get(label)).filter((dep): dep is Block => dep !== undefined && dep !== block),
  );
}

for (const target of GOAL_TARGETS) {
  if (!byLabel.has(target)) throw new Error(`到達点のラベル ${target} が本文に無い`);
}
const closure = new Set<Block>();
const queue = GOAL_TARGETS.map((target) => byLabel.get(target) as Block);
while (queue.length > 0) {
  const block = queue.pop() as Block;
  if (closure.has(block)) continue;
  closure.add(block);
  queue.push(...(dependencies.get(block) ?? []));
}

const ledger = new Set(
  readFileSync(join(structuredLatexDir, "..", "lean", "concrete-necsuf-delegations.txt"), "utf8")
    .split("\n")
    .map((line) => line.trim())
    .filter((line) => line !== "" && !line.startsWith("#")),
);

const counted = [...closure].filter((block) => COUNTED_KINDS.has(block.kind));
const withoutLean = new Set(counted.filter((block) => (block.lean ?? []).length === 0));
const delegating = counted.filter((block) => (block.lean ?? []).some((name) => ledger.has(name)));
const missingDeps = (block: Block): Block[] =>
  (dependencies.get(block) ?? []).filter((dep) => withoutLean.has(dep));
const ready = [...withoutLean].filter((block) => missingDeps(block).length === 0);

// Lean の無いものだけを辿る鎖の長さ。依存は本文の参照なので循環しない前提だが、念のため訪問中を 0 とする。
const depth = new Map<Block, number>();
function chainLength(block: Block): number {
  const known = depth.get(block);
  if (known !== undefined) return known;
  depth.set(block, 0);
  const length = 1 + Math.max(0, ...missingDeps(block).map(chainLength));
  depth.set(block, length);
  return length;
}
const longest: Block[] = [];
let cursor = [...withoutLean].sort((a, b) => chainLength(b) - chainLength(a))[0];
while (cursor !== undefined) {
  longest.push(cursor);
  cursor = missingDeps(cursor).sort((a, b) => chainLength(b) - chainLength(a))[0];
}

const name = (block: Block): string => block.labels?.[0] ?? block.id;
const describe = (block: Block): string => `${name(block)}\t${block.title?.text ?? ""}`;

if (process.argv.includes("--tsv")) {
  const commit = execFileSync("git", ["rev-parse", "--short=9", "HEAD"], { encoding: "utf8" }).trim();
  const date = new Date().toISOString().slice(0, 16);
  console.log(
    [date, commit, closure.size, withoutLean.size, delegating.length, ready.length, longest.length].join("\t"),
  );
} else {
  console.log(`到達点の閉包: ${closure.size} ブロック`);
  console.log(`Lean の無いもの: ${withoutLean.size} 件`);
  console.log(`必要十分版に頼る具体版を持つもの: ${delegating.length} 件`);
  console.log(`Lean の無いもののうち、いま着手できるもの: ${ready.length} 件`);
  console.log(`Lean の無いものの最長の鎖: ${longest.length} 件（着手できる端から到達点へ）`);
  for (const block of [...longest].reverse()) console.log(`  鎖\t${describe(block)}`);
  for (const block of ready) console.log(`  着手可\t${describe(block)}`);
  for (const block of withoutLean) console.log(`  Lean 無し\t${block.kind}\t${describe(block)}`);
  for (const block of delegating) console.log(`  委譲\t${block.kind}\t${describe(block)}`);
}
