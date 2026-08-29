#!/usr/bin/env node
import { ALL_LABELS } from "../labels.generated.ts";
import {
  finiteGraphTheory,
  hyperbolicFiniteGraphConnection,
  selectFiniteGraphBlocksByLabel,
} from "../content/main-text.ts";
import type { Node } from "../schema.ts";

const required = [
  "def_edge_endpoint_label_set",
  "def_finite_graph_input",
  "def_spin_label_set",
  "def_spin_label_reversal",
  "def_spin_configuration_set",
  "def_broken_edge_set",
  "def_broken_edge_multiplicity",
  "def_ising_partition_polynomial",
  "claim_partition_polynomial_coefficient_expansion",
  "def_mod_two_boundary_parity",
  "def_even_edge_subset",
  "def_even_subgraph_polynomial",
] as const;

const selected = selectFiniteGraphBlocksByLabel(required);
if ("heading" in hyperbolicFiniteGraphConnection) {
  throw new Error("双曲曲面接続層が一般有限グラフ理論の見出しを取り込んでいる");
}
const selectedLabels = new Set<string>(selected.flatMap((block) => [...block.labels]));
const generatedLabels = new Set<string>(ALL_LABELS);
const referenced = new Set<string>();

function collectRefs(nodes: readonly Node[]): void {
  for (const node of nodes) {
    if (node.type === "ref") referenced.add(node.target);
    if (node.type === "paragraph") collectRefs(node.children);
    if (node.type === "list") node.items.forEach(collectRefs);
  }
}

for (const block of selected) {
  collectRefs(block.statement ?? []);
  collectRefs("proof" in block ? block.proof ?? [] : []);
}

for (const label of required) {
  if (!generatedLabels.has(label)) throw new Error(`生成ラベルに無い接続ラベル: ${label}`);
  if (!selectedLabels.has(label)) throw new Error(`選択結果に無い接続ラベル: ${label}`);
}
for (const label of referenced) {
  if (!selectedLabels.has(label)) throw new Error(`接続集合の推移的依存が不足: ${label}`);
}

const idsFromCanonicalOrder = required.map((label) => {
  const match = finiteGraphTheory.find((block) => block.labels.some((candidate) => candidate === label));
  if (match === undefined) throw new Error(`正本に無い接続ラベル: ${label}`);
  return match.id;
});
const idsFromReversedOrder = required.map((label) => {
  const match = [...finiteGraphTheory].reverse().find((block) => block.labels.some((candidate) => candidate === label));
  if (match === undefined) throw new Error(`並べ替え後の正本に無い接続ラベル: ${label}`);
  return match.id;
});
if (idsFromCanonicalOrder.some((id, index) => id !== idsFromReversedOrder[index])) {
  throw new Error("正本の並べ替えで内容名ラベルの選択結果が変化した");
}

console.log(`verified hyperbolic connection: ${required.length} labels, ${referenced.size} transitive refs, reorder invariant`);
