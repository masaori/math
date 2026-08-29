#!/usr/bin/env node
import {
  finiteGraphDocumentStructure,
  finiteGraphTheory,
  flatFiniteGraphTheory,
} from "../content/main-text.ts";
import { compileDocumentStructure } from "../schema.ts";
import type { HeadingBlock, Node, ProjectMeta } from "../schema.ts";
import type { FiniteGraphLabel } from "../source/elements.ts";

const toolkitLabels = new Set([
  "def_edge_endpoint_label_set",
  "def_finite_graph_input",
  "def_mod_two_boundary_parity",
  "def_even_edge_subset",
  "def_even_subgraph_polynomial",
]);
const chapters = finiteGraphTheory.filter(
  (block): block is HeadingBlock => block.kind === "heading" && block.level === 1,
);
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
  if (block.kind === "heading" && block.level === 1) {
    if (block.title.text === undefined) throw new Error(`章見出しに本文がない: ${block.id}`);
    chapter = block.title.text;
  }
  if (block.kind === "heading" && block.level === 2) {
    const guide = finiteGraphTheory[index + 1];
    if (guide?.kind !== "remark") throw new Error(`節「${block.title.text}」の直後に入出力案内がない`);
    const guideText: string[] = [];
    collect(guide.statement, new Set(), guideText);
    const joined = guideText.join("");
    for (const marker of ["入力:", "出力:"]) {
      if (!joined.includes(marker)) throw new Error(`節「${block.title.text}」の案内に ${marker} がない`);
    }
  }
  if (block.kind === "heading" || block.kind === "figure" || block.labels.length === 0) continue;
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

const compiled = compileDocumentStructure<FiniteGraphLabel, ProjectMeta>(finiteGraphDocumentStructure);
if (!compiled.success) throw new Error(`正規文書構造を解決できない: ${JSON.stringify(compiled.error)}`);
const blockById = new Map(compiled.data.blocks.map((block) => [block.id, block]));
const groupById = new Map(compiled.data.groups.map((group) => [group.groupId, group]));
const expectedPrimaryLabels = new Map<string, ReadonlySet<string>>([
  ["finite_graph_input_heading", new Set(["def_finite_graph_input"])],
  ["even_edge_subsets_heading", new Set(["def_even_edge_subset", "def_even_subgraph_polynomial"])],
  ["spin_configurations_heading", new Set(["def_spin_configuration_set", "claim_single_vertex_spin_flip_involution"])],
  ["partition_polynomial_heading", new Set(["def_ising_partition_polynomial", "claim_partition_polynomial_coefficient_expansion", "theorem_partition_polynomial_coefficient_evenness"])],
  ["minus_one_heading", new Set(["theorem_root_minus_one_characterizes_odd_incident_edge_count"])],
  ["degree_and_cut_heading", new Set(["theorem_partition_polynomial_degree_maximum_cut_size"])],
  ["fisher_zero_coefficients_heading", new Set(["theorem_fisher_zero_elementary_symmetric_coefficient_ratio", "theorem_fisher_zero_power_sum_newton_recurrence", "theorem_reciprocal_fisher_zero_elementary_symmetric_coefficient_ratio", "theorem_reciprocal_fisher_zero_power_sum_newton_recurrence"])],
  ["full_cut_characterization_heading", new Set(["theorem_coefficient_symmetry_characterizes_full_cut", "theorem_partition_polynomial_reciprocity_characterizes_full_cut"])],
  ["full_cut_fisher_zeros_heading", new Set(["theorem_full_cut_fisher_zero_reciprocal_multiplicity"])],
  ["shifted_fisher_zero_products_heading", new Set(["theorem_fisher_zero_algebraic_shifted_product_coefficient_ratio", "theorem_fisher_zero_algebraic_shifted_product_evaluation_quotient"])],
  ["shifted_fisher_zero_reciprocal_sums_heading", new Set(["def_fisher_zero_algebraic_shifted_reciprocal_sum", "theorem_fisher_zero_algebraic_shifted_reciprocal_sum_coefficient_ratio", "theorem_fisher_zero_algebraic_shifted_reciprocal_square_sum_coefficient_ratio", "theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio"])],
  ["positive_rational_order_heading", new Set(["theorem_partition_polynomial_positive_rational_evaluation_strict_monotonicity"])],
  ["positive_rational_configuration_count_heading", new Set(["theorem_partition_polynomial_positive_rational_evaluation_equal_configuration_count", "theorem_partition_polynomial_positive_rational_evaluation_strictly_below_configuration_count", "theorem_partition_polynomial_positive_rational_evaluation_strictly_above_configuration_count"])],
  ["formal_high_temperature_expansion_heading", new Set(["def_formal_edge_weight_sum", "theorem_formal_high_temperature_expansion"])],
]);
const levelTwoSections = compiled.data.sections.filter((section) => section.depth === 2);
if (levelTwoSections.length !== expectedPrimaryLabels.size) throw new Error(`節数と primary 規則数が異なる: ${levelTwoSections.length} != ${expectedPrimaryLabels.size}`);
for (const [sectionId, expectedLabels] of expectedPrimaryLabels) {
  const resolvedSection = compiled.data.sections.find((candidate) => candidate.sectionId === sectionId);
  if (resolvedSection === undefined) throw new Error(`正規文書構造に節がない: ${sectionId}`);
  const actualLabels = new Set<string>();
  for (const groupId of resolvedSection.primaryGroupIds) {
    const group = groupById.get(groupId);
    const focus = group === undefined ? undefined : blockById.get(group.focusBlockId);
    if (focus === undefined) throw new Error(`primary group の focus を解決できない: ${sectionId} -> ${groupId}`);
    if (group?.sectionId !== sectionId) throw new Error(`primary focus が別節に所属している: ${sectionId} -> ${groupId}`);
    if (focus.kind !== "definition" && focus.kind !== "theorem" && focus.kind !== "claim") {
      throw new Error(`primary focus が定義・定理・主張ではない: ${focus.id}`);
    }
    for (const label of focus.labels) actualLabels.add(label);
  }
  if (actualLabels.size === 0) throw new Error(`primary definition/theorem/claim がない節: ${sectionId}`);
  if ([...expectedLabels].some((label) => !actualLabels.has(label)) || [...actualLabels].some((label) => !expectedLabels.has(label))) {
    throw new Error(`節の primary 解決結果が意味上の指定と異なる: ${sectionId}`);
  }
}
const compiledIds = compiled.data.blocks.map((block) => block.id);
const exportedIds = finiteGraphTheory.map((block) => block.id);
if (compiledIds.length !== exportedIds.length || compiledIds.some((id, index) => id !== exportedIds[index])) {
  throw new Error("正規文書構造と生成器入力のブロック順が一致しない");
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
