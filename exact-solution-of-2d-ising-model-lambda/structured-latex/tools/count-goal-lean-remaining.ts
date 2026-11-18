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
 * - 存在の義務: 到達点の Lean 具体版が引数で受け取る構造（例: 実閉部分体のデータ）の存在を示す主張。
 *   結論がその構造に依らない定理でも、構造が一つも作られていなければ条件付きの主張にとどまるので、
 *   到達点と同じく閉包の起点にする。主張が本文に無ければ、Lean の無いもの 1 件として数える。
 * - 予定の部品: 本文に無い存在の義務を、台帳の行に対応する予定の主張（ラベル）へ割ったもの。
 *   本文にそのラベルのブロックが現れるまでは、予定の依存を持つ Lean の無いもの 1 件として数え、
 *   現れたら本文のブロックとその依存で数える。義務を 1 件のまま数えると、台帳の行が済んでも
 *   義務の主張が書かれるまで件数が動かず、減る速さを読めないため。
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

/**
 * 到達点の Lean 具体版が引数で受け取り、本文が「既知」として存在を引くだけの構造の存在を示す主張。
 * `periodicFreeEnergyDensity_eq_dispersionIntegral` ほか到達点の具体版は `RealClosedSubfieldData` を
 * 引数に取るが、その値を作る主張は本文にも Lean にも無い（2026-11-17 の研究管理が確かめた）。
 */
export const EXISTENCE_OBLIGATIONS = [
  {
    label: "claim_real_closed_subfield_exists",
    title: "実閉部分体と虚数単位の組は存在する",
    parts: [
      "claim_enumerated_ordered_subfield_is_maximal",
      "claim_maximal_ordered_subfield_positive_is_square",
      "claim_odd_degree_positive_cone_extension",
      "claim_adjoin_imaginary_unit_gives_algebraic_numbers",
    ],
  },
] as const;

/**
 * 存在の義務の予定の部品。台帳の行と一対一に対応させる（runbook「実閉部分体の存在の経路」）。
 * 台帳で行を割ったら、ここにも割った行のラベルと依存を足す。
 * ラベル名は台帳の行が名指す。本文で別のラベルにしたら、ここを直す。
 */
export const PLANNED_PARTS: Record<string, { title: string; dependsOn: readonly string[] }> = {
  claim_algebraic_numbers_enumeration: { title: "代数的数の全体の列挙", dependsOn: [] },
  def_subfield_positive_cone: { title: "部分体の正錐", dependsOn: [] },
  def_positive_cone_extension: { title: "部分体の正錐の延長", dependsOn: ["def_subfield_positive_cone"] },
  claim_quadratic_positive_cone_is_subfield_positive_cone: {
    title: "二次体の正錐は部分体の正錐である",
    dependsOn: ["def_subfield_positive_cone"],
  },
  claim_enumerated_ordered_subfield_is_maximal: {
    title: "列挙に沿った順序付き部分体は極大である",
    dependsOn: [
      "claim_algebraic_numbers_enumeration",
      "def_positive_cone_extension",
      "claim_quadratic_positive_cone_is_subfield_positive_cone",
    ],
  },
  claim_square_root_adjoined_subfield_quadratic_representation: {
    title: "平方根を添加した部分体の二次係数表示",
    dependsOn: [],
  },
  claim_square_root_adjoined_weighted_square_sum_excludes_minus_one: {
    title: "平方根を添加した部分体の正錐重み付き平方和は負の単位元を含まない",
    dependsOn: ["claim_square_root_adjoined_subfield_quadratic_representation"],
  },
  claim_square_root_adjoined_positive_cone_extension: {
    title: "正の元の平方根を添加した部分体への正錐の延長",
    dependsOn: [
      "claim_square_root_adjoined_subfield_quadratic_representation",
      "claim_square_root_adjoined_weighted_square_sum_excludes_minus_one",
    ],
  },
  claim_maximal_ordered_subfield_positive_is_square: {
    title: "極大な順序付き部分体では正の元が平方である",
    dependsOn: ["claim_enumerated_ordered_subfield_is_maximal", "claim_square_root_adjoined_positive_cone_extension"],
  },
  claim_odd_degree_positive_cone_extension: {
    title: "奇数次の元を付け足しても正錐は延長できる",
    dependsOn: ["def_positive_cone_extension"],
  },
  claim_symmetric_vanishing_last_variable_divisible_by_product: {
    title: "零代入で消える対称多項式は全変数の積で割り切れる",
    dependsOn: [],
  },
  claim_elementary_symmetric_substitution_degree_bound: {
    title: "基本対称式への代入は対称で部分体係数を保ち、次数は重み付き次数以下",
    dependsOn: [],
  },
  claim_symmetric_polynomial_fundamental_theorem: {
    title: "対称式の基本定理",
    dependsOn: [
      "claim_symmetric_vanishing_last_variable_divisible_by_product",
      "claim_elementary_symmetric_substitution_degree_bound",
    ],
  },
  claim_adjoin_imaginary_unit_gives_algebraic_numbers: {
    title: "虚数単位を足すと代数的数の全体になる",
    dependsOn: ["claim_odd_degree_positive_cone_extension", "claim_symmetric_polynomial_fundamental_theorem"],
  },
};

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
// 本文にまだ無い主張は、予定の依存を持つ Lean の無いもの 1 件として閉包へ入れる。
const placeholders = new Map<string, Block>();
function resolvePlanned(label: string, title: string, dependsOn: readonly string[]): Block {
  const real = byLabel.get(label);
  if (real !== undefined) return real;
  const known = placeholders.get(label);
  if (known !== undefined) return known;
  const placeholder: Block = { id: label, kind: "claim", title: { text: `（本文に未作成）${title}` }, labels: [label] };
  placeholders.set(label, placeholder);
  dependencies.set(
    placeholder,
    dependsOn.map((dep) => {
      const part = PLANNED_PARTS[dep];
      if (part === undefined) throw new Error(`予定の部品 ${dep} が PLANNED_PARTS に無い`);
      return resolvePlanned(dep, part.title, part.dependsOn);
    }),
  );
  return placeholder;
}
for (const obligation of EXISTENCE_OBLIGATIONS) {
  queue.push(resolvePlanned(obligation.label, obligation.title, obligation.parts));
}
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
