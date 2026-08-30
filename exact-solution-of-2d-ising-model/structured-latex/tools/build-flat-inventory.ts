import { mkdirSync, writeFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";
import { loadContentFiles } from "./content-modules.ts";

const projectDir = join(dirname(fileURLToPath(import.meta.url)), "..", "..");
const outputPath = join(projectDir, "docs", "organization", "flat-inventory.json");
const finalChapters = ["数学的道具立て", "2次元イジングモデル"] as const;
type FinalChapter = typeof finalChapters[number];
const mathematicalToolFiles = new Set([
  "000_calculation_formulae_00_09.ts", "000_calculation_formulae_10_19.ts",
  "000_calculation_formulae_20_29.ts", "000_calculation_formulae_30_44.ts",
  "000_calculation_formulae_45_46.ts", "002_linear_space_general.ts",
  "003_exp_linear_map.ts", "005_exp_conjugation_proof.ts",
]);
const mathematicalToolEntryIdsOutsideToolFiles = new Set([
  "eigenvalues_of_V_001_definition_trace",
  "eigenvalues_of_V_002_claim_trace_properties",
  "eigenvalues_of_V_003_claim_trace_of_idempotent",
  "eigenvalues_of_V_011_definition_hermitian_positive_definite",
  "eigenvalues_of_V_012_claim_star_is_norm_preserving",
  "eigenvalues_of_V_013_claim_exp_hermitian_positive_definite",
  "bridge_003_claim_exp_of_diagonal",
  "maxeig_005_claim_psd_cauchy_schwarz",
  "freeenergy_004_theorem_riemann_sum_to_integral",
  "critical_001_claim_cosh_addition_and_half_angle",
  "critical_008_claim_elementary_sine_bounds",
  "critical_009_claim_closed_form_log_integral",
  "critical_010_claim_sine_integral_two_sided",
  "Z_Y_anticommutation_000a_claim_pauli_matrix_products",
  "Z_Y_anticommutation_000b_claim_tensor_anticommutation_single_site",
  "TV1_hatZ_hatY_004_claim_sinh_cosh_taylor",
  "TV1_hatZ_hatY_009_definition_invertible_elements",
  "TV1_hatZ_hatY_011_definition_T_g",
  "TV1_hatZ_hatY_011a_claim_injectivity_of_T",
  "transfer_matrix_005_definition_end_isomorphism",
  "transfer_matrix_005b_claim_end_is_algebra_isomorphism",
  "TV1_hatZ_hatY_010_definition_clifford_group",
]);
const nonPrerequisiteReferenceLabelsById = new Map<string, Set<string>>([
  ["calc_formulae_006_definition_of_cc", new Set(["abs_basic_properties", "matrix_exp_series_converges"])],
  ["linear_space_general_000_definition_kronecker_product", new Set(["kronecker_product_rule", "tensor_basis"])],
  ["TV1_hatZ_hatY_001_claim_commutator_H_Z_Y", new Set(["why_008_applies_only_to_minus_sector"])],
  ["TV1_hatZ_hatY_027_claim_eigenvector_A_theta", new Set(["A_theta_is_identity_when_gamma2_zero"])],
]);
const isingPattern = /Ising|イジング|spin|スピン|lattice|格子|site|サイト|transfer|転送|sector|セクター|momentum|運動量|fermion|フェルミオン/i;
const abstractPatterns = [
  { name: "リー群", pattern: /Lie\s*group|リー群/i },
  { name: "リー環", pattern: /Lie\s*algebra|リー環/i },
  { name: "抽象テンソル積", pattern: /abstract\s+tensor|抽象テンソル積/i },
  { name: "一般の体・環", pattern: /\\mathbb\{K\}|K :=|Mat\([^)]*,K\)|任意の体|一般の体|一般の環/i },
  { name: "抽象線型写像", pattern: /\\mathrm\{End\}|線型写像|linear\s+map/i },
  { name: "群の一般論", pattern: /群|group/i },
];

function collectTargets(value: unknown, targets = new Set<string>()): Set<string> {
  if (Array.isArray(value)) for (const item of value) collectTargets(item, targets);
  else if (value !== null && typeof value === "object") {
    const record = value as Record<string, unknown>;
    if (record.type === "ref" && typeof record.target === "string") targets.add(record.target);
    for (const child of Object.values(record)) collectTargets(child, targets);
  }
  return targets;
}

function blockTitle(block: object): string | null {
  if (!("title" in block) || block.title === null || typeof block.title !== "object") return null;
  if ("text" in block.title && typeof block.title.text === "string") return block.title.text;
  if ("tex" in block.title && typeof block.title.tex === "string") return block.title.tex;
  return null;
}

function stronglyConnectedComponents(nodes: string[], dependencies: Map<string, string[]>): string[][] {
  let index = 0;
  const indices = new Map<string, number>();
  const low = new Map<string, number>();
  const stack: string[] = [];
  const active = new Set<string>();
  const components: string[][] = [];
  function visit(node: string): void {
    indices.set(node, index); low.set(node, index); index += 1; stack.push(node); active.add(node);
    for (const dependency of dependencies.get(node) ?? []) {
      if (!indices.has(dependency)) { visit(dependency); low.set(node, Math.min(low.get(node)!, low.get(dependency)!)); }
      else if (active.has(dependency)) low.set(node, Math.min(low.get(node)!, indices.get(dependency)!));
    }
    if (low.get(node) !== indices.get(node)) return;
    const component: string[] = [];
    while (stack.length > 0) {
      const member = stack.pop()!; active.delete(member); component.push(member);
      if (member === node) break;
    }
    components.push(component.sort());
  }
  for (const node of [...nodes].sort()) if (!indices.has(node)) visit(node);
  return components;
}

function topologicalComponents(components: string[][], dependencies: Map<string, string[]>): string[][] {
  const owner = new Map<string, number>();
  components.forEach((component, i) => component.forEach((node) => owner.set(node, i)));
  const dependents = new Map<number, Set<number>>();
  const counts = new Map(components.map((_, i) => [i, 0]));
  for (const [node, prerequisites] of dependencies) for (const prerequisite of prerequisites) {
    const from = owner.get(prerequisite)!; const to = owner.get(node)!;
    if (from === to) continue;
    const targets = dependents.get(from) ?? new Set<number>();
    if (!targets.has(to)) { targets.add(to); dependents.set(from, targets); counts.set(to, counts.get(to)! + 1); }
  }
  const compare = (a: number, b: number) => components[a]!.join("\u0000").localeCompare(components[b]!.join("\u0000"));
  const ready = [...counts].filter(([, count]) => count === 0).map(([i]) => i).sort(compare);
  const result: string[][] = [];
  while (ready.length > 0) {
    const current = ready.shift()!; result.push(components[current]!);
    for (const dependent of dependents.get(current) ?? []) {
      counts.set(dependent, counts.get(dependent)! - 1);
      if (counts.get(dependent) === 0) { ready.push(dependent); ready.sort(compare); }
    }
  }
  if (result.length !== components.length) throw new Error("縮約依存グラフの順序を確定できません");
  return result;
}

const files = await loadContentFiles();
const allBlocks = files.flatMap(({ file, blocks }) => blocks.map((block) => ({ file, block })));
const targetBlocks = allBlocks.filter(({ block }) => ["definition", "claim", "theorem"].includes(block.kind));
const targetIds = new Set(targetBlocks.map(({ block }) => block.id));
const labelOwners = new Map<string, string>();
const blockPositionById = new Map(allBlocks.map(({ block }, position) => [block.id, position]));
for (const { block } of allBlocks) for (const label of block.labels) {
  if (labelOwners.has(label)) throw new Error(`ラベル所有者が重複しています: ${label}`);
  labelOwners.set(label, block.id);
}
const incoming = new Map<string, number>();
for (const { block } of allBlocks) for (const target of collectTargets(block)) incoming.set(target, (incoming.get(target) ?? 0) + 1);

const baseEntries = targetBlocks.map(({ file, block }) => {
  const record = block as unknown as Record<string, unknown>;
  const inspected = JSON.stringify({ title: record.title, statement: record.statement, proof: record.proof });
  const isingSemanticMatches = [...new Set(inspected.match(isingPattern) ?? [])].sort();
  const abstractVocabularyMatches = abstractPatterns.filter(({ pattern }) => pattern.test(inspected)).map(({ name }) => name);
  const toolCandidate = mathematicalToolFiles.has(file) || mathematicalToolEntryIdsOutsideToolFiles.has(block.id);
  const chapter: FinalChapter = toolCandidate && isingSemanticMatches.length === 0
    ? "数学的道具立て" : "2次元イジングモデル";
  const statementReferenceLabels = [...collectTargets(record.statement)].sort();
  const proofReferenceLabels = [...collectTargets(record.proof)].sort();
  const rawReferenceLabels = [...new Set([...statementReferenceLabels, ...proofReferenceLabels])].sort();
  const configuredExclusions = nonPrerequisiteReferenceLabelsById.get(block.id) ?? new Set<string>();
  const forwardStatementReferenceLabels = statementReferenceLabels.filter((label) => {
    const ownerId = labelOwners.get(label);
    return ownerId !== undefined && blockPositionById.get(ownerId)! > blockPositionById.get(block.id)!;
  });
  const excludedReferenceLabels = new Set([...configuredExclusions, ...forwardStatementReferenceLabels]);
  const dependsOnLabels = rawReferenceLabels.filter((label) => !excludedReferenceLabels.has(label));
  const dependsOnEntryIds = [...new Set(dependsOnLabels.map((label) => labelOwners.get(label))
    .filter((id): id is string => id !== undefined && id !== block.id && targetIds.has(id)))].sort();
  return {
    id: block.id, kind: block.kind, title: blockTitle(block), labels: block.labels, sourceFile: file,
    sourceOrdinal: block.origin?.ordinal ?? null, provisionalFinalChapter: chapter,
    classificationEvidence: {
      mathematicalToolCandidateFile: mathematicalToolFiles.has(file),
      mathematicalToolCandidateEntry: mathematicalToolEntryIdsOutsideToolFiles.has(block.id),
      incomingReferenceCount: block.labels.reduce((sum, label) => sum + (incoming.get(label) ?? 0), 0),
      isingSemanticMatches,
      rule: "項目ごとの意味レビューで一般的な複素数・行列計算と確認され、内容にイジング固有語彙がなければ数学的道具立て、それ以外は2次元イジングモデル",
      rationale: chapter === "数学的道具立て"
        ? "イジング模型を仮定せず、複素数・有限行列の具体的な定義または計算として再利用できる。"
        : "対象の意味または導入目的がスピン・格子・転送行列などイジング模型の構成に依存する。",
    },
    explanationGranularityReview: {
      status: abstractVocabularyMatches.length === 0 && forwardStatementReferenceLabels.length === 0
        ? "自動検査で主題に適合"
        : "具体的な行列計算への展開またはブロック分割を要する",
      criterion: "複素数と有限行列の成分・和・積・極限を、依存先から順に高校生が追える粒度で説明する",
      abstractVocabularyMatches,
      inspectedCharacterCount: inspected.length,
      forwardNavigationMixedIntoStatement: forwardStatementReferenceLabels.length > 0,
      inspectedFields: ["title", "statement", "proof"],
    },
    dependsOnLabels, dependsOnEntryIds,
    referenceLabelsNotUsedAsPrerequisites: [...excludedReferenceLabels].sort(),
    forwardStatementReferenceLabelsNotUsedAsPrerequisites: forwardStatementReferenceLabels,
    blockSplitRequiredBeforeFinalOrdering: forwardStatementReferenceLabels.length > 0,
  };
});
const entryById = new Map(baseEntries.map((entry) => [entry.id, entry]));
const chapterStructures = finalChapters.map((chapter) => {
  const chapterEntries = baseEntries.filter((entry) => entry.provisionalFinalChapter === chapter);
  const chapterIds = new Set(chapterEntries.map(({ id }) => id));
  const dependencies = new Map(chapterEntries.map(({ id, dependsOnEntryIds }) => [id, dependsOnEntryIds.filter((x) => chapterIds.has(x))]));
  const ordered = topologicalComponents(stronglyConnectedComponents([...chapterIds], dependencies), dependencies);
  return {
    chapter, entryCount: chapterEntries.length, dependencyDirection: "prerequisite から dependent へ",
    topologicalOrder: ordered.map((entryIds, i) => ({ order: i + 1, entryIds, inseparableDependencyUnit: entryIds.length > 1 })),
    crossChapterPrerequisites: chapterEntries.flatMap((entry) => entry.dependsOnEntryIds
      .filter((id) => entryById.get(id)?.provisionalFinalChapter !== chapter)
      .map((prerequisiteId) => ({ dependentId: entry.id, prerequisiteId }))),
  };
});
const toolStructure = chapterStructures.find(({ chapter }) => chapter === "数学的道具立て")!;
if (toolStructure.crossChapterPrerequisites.length > 0) throw new Error(`数学的道具立てが後章を前提にしています: ${JSON.stringify(toolStructure.crossChapterPrerequisites)}`);
const order = new Map<string, { chapterOrder: number; dependencyUnitEntryIds: string[] }>();
for (const structure of chapterStructures) for (const unit of structure.topologicalOrder) for (const id of unit.entryIds) {
  order.set(id, { chapterOrder: unit.order, dependencyUnitEntryIds: unit.entryIds });
}
const entries = baseEntries.map((entry) => ({ ...entry, dependencyPlacement: order.get(entry.id) }));
const allDependencyLabels = allBlocks.flatMap(({ block }) => [...collectTargets(block)]);
const dependencySupportNodes = allBlocks.filter(({ block }) => !targetIds.has(block.id)).map(({ file, block }) => ({
  id: block.id, kind: block.kind, title: blockTitle(block), labels: block.labels, sourceFile: file,
  dependsOnLabels: [...collectTargets(block)].sort(),
}));
const inventory = {
  schemaVersion: 2,
  scope: "exact-solution-of-2d-ising-model/structured-latex/content の全 definition・claim・theorem",
  organizingTheme: "高校生でも読める具体的な複素数・行列計算として2次元イジング模型の厳密解を積み上げる",
  withdrawnBoundaryAxes: ["実数解析への脱出を伴う道具／有限複素行列だけで閉じる道具", "可算／非可算"],
  boundaryRule: "章境界は対象の意味がイジング模型に依存するかだけで定め、解析や集合の濃度は章・節境界に使わない。",
  finalChapters,
  classificationStatus: `全項目の分類と説明粒度を再検証済み。章内依存順はブロック分割候補${entries.filter((entry) => entry.blockSplitRequiredBeforeFinalOrdering).length}件を残す暫定順。`,
  entryCount: entries.length,
  chapterEntryCounts: Object.fromEntries(finalChapters.map((chapter) => [chapter, entries.filter((entry) => entry.provisionalFinalChapter === chapter).length])),
  explanationGranularityReview: {
    reviewedEntryCount: entries.length,
    criterion: "高度な抽象理論を導入せず、複素数と有限行列の具体的な計算を依存先から順に追えること",
    flaggedEntryIds: entries.filter((entry) =>
      entry.explanationGranularityReview.abstractVocabularyMatches.length > 0 || entry.explanationGranularityReview.forwardNavigationMixedIntoStatement
    ).map(({ id }) => id),
  },
  mathematicalToolSemanticContaminationReview: {
    inspectedEntryCount: entries.filter((entry) => entry.provisionalFinalChapter === "数学的道具立て").length,
    contaminatedEntryIds: entries.filter((entry) => entry.provisionalFinalChapter === "数学的道具立て" && entry.classificationEvidence.isingSemanticMatches.length > 0).map(({ id }) => id),
  },
  chapterStructures,
  dependencySupportNodeCount: dependencySupportNodes.length,
  unnamedEntryIds: entries.filter(({ title }) => title === null).map(({ id }) => id),
  unlabeledEntryIds: entries.filter(({ labels }) => labels.length === 0).map(({ id }) => id),
  unresolvedInventoryDependencies: [...new Set(allDependencyLabels)].filter((label) => !labelOwners.has(label)).sort(),
  entries, dependencySupportNodes,
};
mkdirSync(dirname(outputPath), { recursive: true });
writeFileSync(outputPath, `${JSON.stringify(inventory, null, 2)}\n`);
console.log(`wrote ${entries.length} entries to ${outputPath}`);
