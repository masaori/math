import { createHash } from "node:crypto";
import type { ConvertedBlock, Node } from "../schema.ts";

export type ContentFile = { file: string; blocks: ConvertedBlock[] };

const sectionOrder = [
  "finite-graph-even-subgraphs",
  "two-stage-group-quotient-input",
  "finite-cell-complex-data",
  "f2-chain-homology",
  "homology-class-even-subgraph-polynomials",
  "finite-fourier-analysis",
  "primal-dual-homology",
  "prime-exponent-encoding",
  "hyperbolic-regular-types",
  "product-difference-classification",
  "finite-quotient-hyperbolic-lattice",
  "ising-partition-polynomial",
  "fixed-lattice-arithmetic",
  "quotient-tower-comparison",
] as const;

type Section = (typeof sectionOrder)[number];

const structureIds: Record<Section, readonly string[]> = {
  "finite-graph-even-subgraphs": ["publication_heading_mathematical_tools", "publication_heading_finite_graph_even_subgraphs", "publication_goal_finite_graph_even_subgraphs"],
  "two-stage-group-quotient-input": ["publication_heading_two_stage_group_quotient_input", "publication_goal_two_stage_group_quotient_input"],
  "finite-cell-complex-data": ["publication_heading_finite_cell_complex_data", "publication_goal_finite_cell_complex_data"],
  "f2-chain-homology": ["publication_heading_f2_chain_homology", "publication_goal_f2_chain_homology"],
  "homology-class-even-subgraph-polynomials": ["publication_heading_homology_class_even_subgraph_polynomials", "publication_goal_homology_class_even_subgraph_polynomials"],
  "finite-fourier-analysis": ["publication_heading_finite_fourier_analysis", "publication_goal_finite_fourier_analysis"],
  "primal-dual-homology": ["publication_heading_primal_dual_fourier", "publication_goal_primal_dual_fourier"],
  "prime-exponent-encoding": ["publication_heading_prime_exponent_encoding", "publication_goal_prime_exponent_encoding"],
  "hyperbolic-regular-types": ["publication_heading_hyperbolic_ising_semantics", "publication_heading_hyperbolic_regular_types", "publication_goal_hyperbolic_regular_types"],
  "product-difference-classification": ["publication_heading_product_difference_classification", "publication_goal_product_difference_classification"],
  "finite-quotient-hyperbolic-lattice": ["publication_heading_finite_quotient_hyperbolic_lattice", "publication_goal_finite_quotient_hyperbolic_lattice"],
  "ising-partition-polynomial": ["publication_heading_ising_partition_polynomial", "publication_goal_ising_partition_polynomial"],
  "fixed-lattice-arithmetic": ["publication_heading_fixed_lattice_arithmetic", "publication_goal_fixed_lattice_arithmetic"],
  "quotient-tower-comparison": ["publication_heading_quotient_tower_comparison", "publication_goal_quotient_tower_comparison"],
};

const genericCellulationIds = new Set([
  "finite_cellulation_definition_cell_sets",
  "finite_cellulation_definition_orientation_labels",
  "finite_cellulation_definition_orientation_endpoint_selectors",
  "finite_cellulation_definition_orientation_reversal",
  "finite_cellulation_definition_cyclic_position_system",
  "finite_cellulation_definition_face_boundary_word",
  "finite_cellulation_definition_opposite_edge_occurrences",
  "finite_cellulation_definition_corner_side_labels",
  "finite_cellulation_definition_corner_edge_end_map",
  "finite_cellulation_definition_vertex_links_are_cycles",
  "finite_cellulation_definition_connected_one_skeleton",
  "finite_cellulation_definition_euler_characteristic",
  "finite_cellulation_definition_oriented_closed_surface_cellulation",
  "finite_cellulation_definition_regular_type_set",
  "finite_cellulation_theorem_regular_face_edge_incidence",
  "finite_cellulation_theorem_regular_vertex_edge_incidence",
  "finite_cellulation_theorem_regular_euler_incidence_identity",
]);

const genericHomologyIds = new Set([
  "homology_sector_definition_first_boundary_matrix",
  "homology_sector_definition_second_boundary_matrix",
  "homology_sector_theorem_boundary_of_boundary_is_zero",
  "homology_sector_definition_first_cycle_space",
  "homology_sector_definition_edge_subset_coefficient_map",
  "homology_sector_definition_face_boundary_space",
  "homology_sector_definition_first_homology_group",
]);

const homologyPolynomialIds = new Set([
  "homology_sector_claim_even_edge_subset_maps_to_first_cycle",
  "homology_sector_definition_even_edge_subset_homology_class_map",
  "homology_sector_definition_homology_class_generating_polynomial",
  "homology_sector_theorem_homology_class_polynomials_recombine",
]);

const genericFourierIds = new Set([
  "finite_fourier_definition_f2_linear_character_space",
  "finite_fourier_definition_integer_sign_character_realization",
  "finite_fourier_claim_integer_sign_character_multiplicativity",
  "finite_fourier_theorem_character_orthogonality",
  "finite_fourier_theorem_inverse_transform",
]);

function classify(block: ConvertedBlock, file: string): Section {
  if (genericCellulationIds.has(block.id)) return "finite-cell-complex-data";
  if ([
    "finite_graph_definition_endpoint_labels",
    "finite_graph_definition_input",
    "formal_high_temperature_definition_boundary_parity",
    "formal_high_temperature_definition_even_subsets",
    "formal_high_temperature_definition_even_polynomial",
  ].includes(block.id)) return "finite-graph-even-subgraphs";
  if (block.id === "quotient_tower_definition_two_stage_finite_quotient_tower_input") return "two-stage-group-quotient-input";
  if (genericHomologyIds.has(block.id)) return "f2-chain-homology";
  if (homologyPolynomialIds.has(block.id)) return "homology-class-even-subgraph-polynomials";
  if (genericFourierIds.has(block.id)) return "finite-fourier-analysis";
  if (file === "finite-fourier-duality.ts") return "primal-dual-homology";
  if (block.id === "arithmetic_tools_definition_prime_exponent_logarithmic_group") return "prime-exponent-encoding";
  if (block.id === "quotient_tower_definition_positive_rational_logarithmic_value_map") return "prime-exponent-encoding";
  if (file === "about-article-scope.ts") return "hyperbolic-regular-types";
  if (file === "finite-cellulation.ts" && block.id === "finite_cellulation_definition_hyperbolic_regular_type_set") return "hyperbolic-regular-types";
  if (file === "finite-cellulation.ts" && block.id.startsWith("finite_cellulation_theorem_hyperbolic_regular_type_")) return "hyperbolic-regular-types";
  if (file === "finite-cellulation.ts" && block.id.includes("product_difference_")) return "product-difference-classification";
  if (file === "finite-quotient-lattice.ts" && block.id !== "finite_quotient_lattice_theorem_fixed_quotient_ising_partition_polynomial") return "finite-quotient-hyperbolic-lattice";
  if (block.id === "finite_quotient_lattice_theorem_fixed_quotient_ising_partition_polynomial") return "ising-partition-polynomial";
  if (file === "main-text.ts") return "ising-partition-polynomial";
  if (file === "arithmetic-invariants.ts") return "fixed-lattice-arithmetic";
  if (file === "quotient-tower.ts") return "quotient-tower-comparison";
  throw new Error(`出版分類が未定義: ${file}: ${block.id}`);
}

function nodeReferences(node: Node): string[] {
  if (node.type === "ref") return [node.target];
  if (node.type === "paragraph") return node.children.flatMap(nodeReferences);
  if (node.type === "list") return node.items.flatMap((item) => item.flatMap(nodeReferences));
  if (node.type === "math" || node.type === "displayMath") {
    return [...node.tex.matchAll(/\\blkref\{([^}]+)\}/g)]
      .map((match) => match[1])
      .filter((target): target is string => target !== undefined);
  }
  return [];
}

function dependencies(block: ConvertedBlock, labelOwner: Map<string, string>): Set<string> {
  if (block.kind === "heading" || block.kind === "figure") return new Set();
  const labels = [...block.statement, ...(block.proof ?? [])].flatMap(nodeReferences);
  const manualDependencies: Record<string, readonly string[]> = {
    finite_graph_definition_input: ["finite_graph_definition_endpoint_labels"],
    formal_high_temperature_definition_boundary_parity: ["finite_graph_definition_input"],
    formal_high_temperature_definition_even_subsets: ["formal_high_temperature_definition_boundary_parity"],
    formal_high_temperature_definition_even_polynomial: ["formal_high_temperature_definition_even_subsets"],
    finite_graph_definition_spin_reversal: ["finite_graph_definition_spin_labels"],
    finite_graph_definition_spin_configurations: ["finite_graph_definition_spin_labels"],
    finite_graph_definition_broken_edges: ["finite_graph_definition_spin_configurations"],
    finite_graph_definition_multiplicity: ["finite_graph_definition_broken_edges"],
    finite_graph_definition_partition_polynomial: ["finite_graph_definition_multiplicity"],
    finite_graph_claim_coefficient_expansion: ["finite_graph_definition_partition_polynomial"],
  };
  return new Set([
    ...labels.map((label) => labelOwner.get(label)).filter((id): id is string => id !== undefined),
    ...(manualDependencies[block.id] ?? []),
  ]);
}

function topologicalSort(blocks: ConvertedBlock[], labelOwner: Map<string, string>): ConvertedBlock[] {
  const ids = new Set(blocks.map((block) => block.id));
  const pending = new Map(blocks.map((block, index) => [block.id, { block, index, deps: new Set([...dependencies(block, labelOwner)].filter((id) => ids.has(id))) }]));
  const result: ConvertedBlock[] = [];
  while (pending.size > 0) {
    const ready = [...pending.values()].filter(({ deps }) => deps.size === 0).sort((left, right) => left.index - right.index);
    if (ready.length === 0) throw new Error(`章内依存関係に循環がある: ${[...pending.keys()].join(", ")}`);
    for (const { block } of ready) {
      pending.delete(block.id);
      result.push(block);
      for (const value of pending.values()) value.deps.delete(block.id);
    }
  }
  return result;
}

export function organizePublication(rawFiles: ContentFile[]): ContentFile[] {
  const all = rawFiles.flatMap(({ file, blocks }) => blocks.map((block) => ({ file, block })));
  const byId = new Map(all.map(({ block }) => [block.id, block]));
  const labelOwner = new Map(all.flatMap(({ block }) => block.labels.map((label) => [label, block.id] as const)));
  const content = all.filter(({ file, block }) => file !== "publication-structure.ts" && block.kind !== "heading");
  const expectedIdDigests = new Map<string, string>([
    ["about-article-scope.ts", "2385be547690edfaab9bd458fd0aec851bb3149a649886db47bb57ce27533419"],
    ["arithmetic-invariants.ts", "6103d558036852103be49ebc56d5d646bee632e3138cb5f83bc0e16f4bc66027"],
    ["arithmetic-tools.ts", "cafe20754d06ecb0b246b66effbcae672dc3bd928370dd991dc18d1112c522c0"],
    ["finite-cellulation.ts", "cfff3fa6d456242279b044556bffcce96c68fe912b4fadf6a45ea1424c47259c"],
    ["finite-fourier-duality.ts", "be9e8ad799f3e204f41d15cf0cf48ddd5c1566060767231f53f149a0b14a7737"],
    ["finite-quotient-lattice.ts", "ddb785f46921b5aa5563e671dfb73bcf5a621e0ac59d80d3afeb3377080715fc"],
    ["homology-sector-expansion.ts", "4ca22cc43e6820be8df6f2a9dca2820fd56bf5f8032c663bfdace44f40c70b98"],
    ["main-text.ts", "86f1872004ff2ba2312525592346506a8f4f2dca95c0b0f04f9a88e703141e2c"],
    ["quotient-tower.ts", "5a4d172961818ee149dda139b6046a49b50b8dbc2d8f2ab009b43e20815b8048"],
  ]);
  for (const [file, expected] of expectedIdDigests) {
    const ids = content.filter((entry) => entry.file === file).map(({ block }) => block.id).sort();
    const actual = createHash("sha256").update(ids.join("\n")).digest("hex");
    if (actual !== expected) throw new Error(`出版分類境界の再レビューが必要: ${file}: ブロック ID 集合が変更された`);
  }
  const unexpectedFiles = new Set(content.map((entry) => entry.file).filter((file) => !expectedIdDigests.has(file)));
  if (unexpectedFiles.size > 0) throw new Error(`出版分類されていない本文ファイル: ${[...unexpectedFiles].join(", ")}`);
  const classified = new Map<Section, ConvertedBlock[]>(sectionOrder.map((section) => [section, []]));
  const prefaceIds = content.filter(({ file }) => file === "about-article-scope.ts").map(({ block }) => block.id);
  for (const { file, block } of content) {
    if (!prefaceIds.includes(block.id)) classified.get(classify(block, file))!.push(block);
  }

  const rank = new Map(sectionOrder.map((section, index) => [section, index]));
  const sectionOf = new Map(content.map(({ file, block }) => [block.id, classify(block, file)]));
  for (const { block } of content) {
    const current = rank.get(sectionOf.get(block.id)!)!;
    for (const dependency of dependencies(block, labelOwner)) {
      const dependencySection = sectionOf.get(dependency);
      if (dependencySection !== undefined && rank.get(dependencySection)! > current) {
        throw new Error(`出版順が依存関係に反する: ${block.id} -> ${dependency} (${sectionOf.get(block.id)} -> ${dependencySection})`);
      }
    }
  }

  const preface = prefaceIds.map((id) => byId.get(id)).filter((block): block is ConvertedBlock => block !== undefined);
  if (preface.length !== prefaceIds.length) throw new Error("論文対象の冒頭定義群が見つからない");
  const blocks: ConvertedBlock[] = topologicalSort(preface, labelOwner);
  for (const section of sectionOrder) {
    for (const id of structureIds[section]) {
      const block = byId.get(id);
      if (block === undefined) throw new Error(`出版構造ブロックが見つからない: ${id}`);
      blocks.push(block);
    }
    blocks.push(...topologicalSort(classified.get(section)!, labelOwner));
  }
  const expected = content.length + Object.values(structureIds).flat().length;
  if (blocks.length !== expected || new Set(blocks.map((block) => block.id)).size !== expected) {
    throw new Error(`出版分類が全単射でない: expected=${expected}, actual=${blocks.length}`);
  }
  return [{ file: "publication-order", blocks }];
}
