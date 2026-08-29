#!/usr/bin/env node
import { finiteGraphTheory, flatFiniteGraphTheory } from "../content/main-text.ts";
import type { Node } from "../schema.ts";

const toolkitLabels = new Set([
  "def_edge_endpoint_label_set",
  "def_finite_graph_input",
  "def_mod_two_boundary_parity",
  "def_even_edge_subset",
  "def_even_subgraph_polynomial",
]);
const chapters = finiteGraphTheory.filter((block) => block.kind === "heading" && block.level === 1);
if (chapters.length !== 2) throw new Error(`第一階層の章が二つではない: ${chapters.length}`);
if (chapters[0]?.title.text !== "数学的道具立て") throw new Error("第一章が数学的道具立てではない");
if (chapters[1]?.title.text !== "有限グラフ上の Ising 模型・分配多項式と Fisher 零点") {
  throw new Error("第二章が有限グラフ Ising の意味論ではない");
}

let chapter = "";
const chapterByLabel = new Map<string, string>();
const positionByLabel = new Map<string, number>();
const refsByLabel = new Map<string, Set<string>>();
const forbiddenToolkitTerms = /Ising|Fisher|スピン|破れ辺|分配多項式/;
const implicitSymbolDependencies = new Map<string, readonly string[]>([
  ["def_finite_graph_input", ["def_edge_endpoint_label_set"]],
  ["def_mod_two_boundary_parity", ["def_edge_endpoint_label_set", "def_finite_graph_input"]],
  ["def_even_subgraph_polynomial", ["def_even_edge_subset"]],
  ["def_spin_configuration_set", ["def_finite_graph_input", "def_spin_label_set"]],
  ["def_edge_spin_sign", ["def_finite_graph_input", "def_spin_configuration_set", "def_spin_integer_realization"]],
  ["def_formal_edge_weight_sum", ["def_edge_spin_sign"]],
]);

function collect(nodes: readonly Node[], refs: Set<string>, text: string[]): void {
  for (const node of nodes) {
    if (node.type === "ref") refs.add(node.target);
    if (node.type === "text") text.push(node.value);
    if (node.type === "math" || node.type === "displayMath") text.push(node.tex);
    if (node.type === "paragraph") collect(node.children, refs, text);
    if (node.type === "list") node.items.forEach((item) => collect(item, refs, text));
  }
}

for (const [index, block] of finiteGraphTheory.entries()) {
  if (block.kind === "heading" && block.level === 1) chapter = block.title.text;
  if (block.kind === "heading" && block.level === 2) {
    const guide = finiteGraphTheory[index + 1];
    if (guide?.kind !== "remark") throw new Error(`節「${block.title.text}」の直後に入出力案内がない`);
    const guideText: string[] = [];
    collect(guide.statement, new Set(), guideText);
    const joined = guideText.join("");
    for (const marker of ["入力:", "出力:", "主定義・主定理・主張:"]) {
      if (!joined.includes(marker)) throw new Error(`節「${block.title.text}」の案内に ${marker} がない`);
    }
  }
  if (block.kind === "heading" || block.labels.length === 0) continue;
  const refs = new Set<string>();
  const text: string[] = [block.title?.text ?? ""];
  collect(block.statement, refs, text);
  if ("proof" in block) collect(block.proof ?? [], refs, text);
  for (const label of block.labels) {
    for (const target of implicitSymbolDependencies.get(label) ?? []) refs.add(target);
    if (chapterByLabel.has(label)) throw new Error(`分類が重複している: ${label}`);
    chapterByLabel.set(label, chapter);
    positionByLabel.set(label, index);
    refsByLabel.set(label, refs);
    const inToolkit = chapter === "数学的道具立て";
    if (inToolkit !== toolkitLabels.has(label)) throw new Error(`章境界が不一致: ${label}`);
    if (inToolkit && forbiddenToolkitTerms.test(text.join(""))) throw new Error(`数学的道具立てへ Ising 固有意味論が混入: ${label}`);
  }
}

if (chapterByLabel.size !== 74) throw new Error(`分類された数学ラベルが 74 個ではない: ${chapterByLabel.size}`);
const flatLabels = new Set<string>(flatFiniteGraphTheory.flatMap((block) => [...block.labels]));
if (flatLabels.size !== chapterByLabel.size) throw new Error(`フラット正本と最終分類のラベル数が異なる: ${flatLabels.size} != ${chapterByLabel.size}`);
for (const label of flatLabels) if (!chapterByLabel.has(label)) throw new Error(`最終章立てから欠落したラベル: ${label}`);
for (const label of chapterByLabel.keys()) if (!flatLabels.has(label)) throw new Error(`フラット正本にないラベル: ${label}`);
for (const [label, refs] of refsByLabel) {
  for (const target of refs) {
    const targetPosition = positionByLabel.get(target);
    if (targetPosition === undefined) throw new Error(`未分類の参照先: ${label} -> ${target}`);
    if (targetPosition >= positionByLabel.get(label)!) throw new Error(`依存順序が逆転: ${label} -> ${target}`);
    if (toolkitLabels.has(label) && !toolkitLabels.has(target)) throw new Error(`道具から意味論への依存: ${label} -> ${target}`);
  }
}

console.log("verified chapter organization: 2 chapters, 74 mathematical labels, guides and dependency order");
