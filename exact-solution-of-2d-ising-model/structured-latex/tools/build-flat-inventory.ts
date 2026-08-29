import { mkdirSync, writeFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

import { loadContentFiles } from "./content-modules.ts";

const projectDir = join(dirname(fileURLToPath(import.meta.url)), "..", "..");
const outputPath = join(projectDir, "docs", "organization", "flat-inventory.json");
const mathematicalToolFiles = new Set([
  "000_calculation_formulae_00_09.ts",
  "000_calculation_formulae_10_19.ts",
  "000_calculation_formulae_20_29.ts",
  "000_calculation_formulae_30_44.ts",
  "000_calculation_formulae_45_46.ts",
  "002_linear_space_general.ts",
  "003_exp_linear_map.ts",
  "005_exp_conjugation_proof.ts",
]);

type CalculationFormulaBoundary = {
  closure: "実数解析への脱出を伴う" | "有限複素行列だけで閉じる";
  directRealAnalysisInputs: string[];
  implicitPrerequisiteLabels?: string[];
  nonPrerequisiteReferenceLabels?: string[];
  realAnalysisPropagationExcludedLabels?: string[];
  rationale: string;
};

const calculationFormulaBoundaryById = new Map<string, CalculationFormulaBoundary>([
  ["calc_formulae_000b_claim_cosh_sinh_basic_properties", {
    closure: "実数解析への脱出を伴う",
    directRealAnalysisInputs: [
      "実指数関数の乗法性 exp(x)exp(y)=exp(x+y)",
      "実指数関数の単位元での値 exp(0)=1",
      "実指数関数の正値性 exp(x)>0",
      "実指数関数の狭義単調増加性",
    ],
    rationale: "statement が実指数関数の解析的性質を外部入力として明示する。",
  }],
  ["calc_formulae_000c_claim_sqrt_nonnegative_existence_uniqueness", {
    closure: "実数解析への脱出を伴う",
    directRealAnalysisInputs: ["実数の完備性（上限性質）"],
    realAnalysisPropagationExcludedLabels: ["cosh_sinh_basic_properties"],
    rationale: "proof が非可算集合 R の完備性への移行を明示する。",
  }],
  ["calc_formulae_001_sqrt_nonnegative_real", {
    closure: "実数解析への脱出を伴う",
    directRealAnalysisInputs: [],
    rationale: "非負実数の平方根の存在と一意性に依存する。",
  }],
  ["calc_formulae_003_matrix_decomposition", {
    closure: "有限複素行列だけで閉じる", directRealAnalysisInputs: [], rationale: "有限複素行列の積だけを使う。",
  }],
  ["calc_formulae_005_matrix_conjugation", {
    closure: "有限複素行列だけで閉じる", directRealAnalysisInputs: [], rationale: "有限複素行列の積・和・逆行列だけを使う。",
  }],
  ["calc_formulae_006_definition_of_cc", {
    closure: "有限複素行列だけで閉じる",
    directRealAnalysisInputs: [],
    nonPrerequisiteReferenceLabels: ["abs_basic_properties", "matrix_exp_series_converges"],
    rationale: "R の対の有限な四則演算として C を定義する。statement 内の二つの参照は、この定義を後で使う箇所の案内であって前提ではない。",
  }],
  ["calc_formulae_007_inclusion_rr_to_cc", {
    closure: "有限複素行列だけで閉じる",
    directRealAnalysisInputs: [],
    implicitPrerequisiteLabels: ["definition_of_cc"],
    rationale: "C の定義のもとで x を (x,0) へ送る有限な代数的写像である。",
  }],
  ["calc_formulae_016_definition_angle_equivalence_class", {
    closure: "有限複素行列だけで閉じる", directRealAnalysisInputs: [], rationale: "実数上の同値関係と商集合だけを使い、完備性・極限・連続性を使わない。",
  }],
  ["calc_formulae_016b_claim_angle_section_existence_uniqueness", {
    closure: "実数解析への脱出を伴う",
    directRealAnalysisInputs: ["実数のアルキメデス性（完備性から従う）"],
    rationale: "proof が有理数体の代数だけでは閉じない箇所を明示する。",
  }],
  ["calc_formulae_017_definition_section_of_angle_representation", {
    closure: "実数解析への脱出を伴う", directRealAnalysisInputs: [], rationale: "角度切断の存在と一意性に依存する。",
  }],
  ["calc_formulae_019_definition_polar_equivalence_class", {
    closure: "有限複素行列だけで閉じる",
    directRealAnalysisInputs: [],
    implicitPrerequisiteLabels: ["angle_equivalence_class"],
    rationale: "角度表現の同値類を使って実数対上の同値関係と商集合を定める。",
  }],
  ["calculation_formulae_022_definition_operations_on_polar_representation", {
    closure: "有限複素行列だけで閉じる",
    directRealAnalysisInputs: [],
    implicitPrerequisiteLabels: ["angle_equivalence_class", "polar_equivalence_class"],
    rationale: "二つの同値類の定義のもとで極座標表現上の有限な積・逆元を定める。",
  }],
  ["calculation_formulae_023_claim_multiplicative_group_of_polar_representation", {
    closure: "有限複素行列だけで閉じる", directRealAnalysisInputs: [], rationale: "極座標表現の有限な代数演算だけを使う。",
  }],
  ["calculation_formulae_024_claim_multiplicative_group_of_complex_numbers", {
    closure: "有限複素行列だけで閉じる", directRealAnalysisInputs: [], rationale: "複素数の有限な乗法計算だけを使う。",
  }],
  ["calculation_formulae_025_claim_complex_numbers_form_a_field", {
    closure: "有限複素行列だけで閉じる", directRealAnalysisInputs: [], rationale: "複素数の有限な四則演算だけを使う。",
  }],
  ["calculation_formulae_027_definition_phi_polar", {
    closure: "実数解析への脱出を伴う",
    directRealAnalysisInputs: ["逆三角関数 arctan"],
    implicitPrerequisiteLabels: [
      "definition_of_cc",
      "definition_of_sqrt_r_positive",
      "polar_equivalence_class",
    ],
    rationale: "非負実数の平方根と極座標表現は暗黙前提ラベルから辿り、ラベルを持たない arctan だけを直接解析入力とする。",
  }],
  ["calculation_formulae_028_definition_phi_cartesian", {
    closure: "実数解析への脱出を伴う",
    directRealAnalysisInputs: ["三角関数 sin・cos と周期性"],
    implicitPrerequisiteLabels: ["definition_of_cc", "polar_equivalence_class"],
    rationale: "複素数と極座標表現は暗黙前提ラベルから辿り、ラベルを持たない sin・cos と周期性を直接解析入力とする。",
  }],
  ["calculation_formulae_029_claim_isomorphism_of_phi_cartesian", {
    closure: "実数解析への脱出を伴う", directRealAnalysisInputs: [], rationale: "平方根・逆三角関数・三角関数を使う写像に依存する。",
  }],
  ["calculation_formulae_030_definition_first_and_second_projections", {
    closure: "有限複素行列だけで閉じる",
    directRealAnalysisInputs: [],
    implicitPrerequisiteLabels: ["polar_equivalence_class"],
    rationale: "極座標表現の同値類からの有限な座標射影だけを使う。",
  }],
  ["calculation_formulae_031_definition_abs_arg", {
    closure: "実数解析への脱出を伴う",
    directRealAnalysisInputs: [],
    implicitPrerequisiteLabels: [
      "def_phi_polar",
      "definition_of_cc",
      "first_and_second_projections",
      "section_of_angle_representation",
    ],
    rationale: "絶対値と偏角が使う極座標写像・座標射影・角度切断を暗黙前提ラベルから辿る。",
  }],
  ["calculation_formulae_031b_claim_abs_basic_properties", {
    closure: "実数解析への脱出を伴う",
    directRealAnalysisInputs: [],
    realAnalysisPropagationExcludedLabels: ["def_abs_arg", "def_phi_polar"],
    rationale: "絶対値・極座標写像・非負実数の平方根に依存する。ただし偏角と極座標写像の角度成分は使わない。",
  }],
  ["calculation_formulae_036_claim_arg_of_reciprocal", {
    closure: "実数解析への脱出を伴う", directRealAnalysisInputs: [], rationale: "偏角と角度切断に依存する。",
  }],
  ["calculation_formulae_038_definition_sqrt_of_complex_number", {
    closure: "実数解析への脱出を伴う",
    directRealAnalysisInputs: [],
    implicitPrerequisiteLabels: [
      "def_phi_cartesian",
      "def_phi_polar",
      "definition_of_cc",
      "definition_of_sqrt_r_positive",
      "first_and_second_projections",
      "polar_equivalence_class",
      "section_of_angle_representation",
    ],
    rationale: "複素平方根が使う非負実数の平方根・角度切断・二つの極座標写像を暗黙前提ラベルから辿る。",
  }],
  ["calculation_formulae_039_claim_sqrt_expansion_via_polar", {
    closure: "実数解析への脱出を伴う", directRealAnalysisInputs: [], rationale: "非負実数の平方根・角度切断・極座標写像に依存する。",
  }],
  ["calculation_formulae_040_claim_sqrt_commutativity_condition", {
    closure: "実数解析への脱出を伴う", directRealAnalysisInputs: [], rationale: "複素平方根・偏角・角度切断に依存する。",
  }],
  ["calculation_formulae_041_claim_sqrt_squared_is_original", {
    closure: "実数解析への脱出を伴う", directRealAnalysisInputs: [], rationale: "非負実数の平方根と複素平方根に依存する。",
  }],
  ["calculation_formulae_042_claim_square_of_sqrt", {
    closure: "実数解析への脱出を伴う", directRealAnalysisInputs: [], rationale: "複素平方根と偏角に依存する。",
  }],
  ["calculation_formulae_043_claim_sqrt_of_reciprocal", {
    closure: "実数解析への脱出を伴う", directRealAnalysisInputs: [], rationale: "非負実数・複素数の平方根と角度切断に依存する。",
  }],
  ["calculation_formulae_045_theorem_euler_formula_cos_sin", {
    closure: "実数解析への脱出を伴う",
    directRealAnalysisInputs: ["Euler の公式と三角関数の偶奇性"],
    implicitPrerequisiteLabels: ["definition_of_cc"],
    rationale: "proof が Euler の公式と sin・cos の解析的事実を外部入力として使う。",
  }],
  ["calculation_formulae_046_claim_conjugation_is_ring_homomorphism", {
    closure: "有限複素行列だけで閉じる", directRealAnalysisInputs: [], rationale: "有限複素行列の共役計算だけを使う。",
  }],
]);

const directRealAnalysisInputsById = new Map<string, string[]>(
  [...calculationFormulaBoundaryById]
    .filter(([, boundary]) => boundary.directRealAnalysisInputs.length > 0)
    .map(([id, boundary]) => [id, boundary.directRealAnalysisInputs]),
);
directRealAnalysisInputsById.set("calc_formulae_012_definition_arc_length", ["実曲線の弧長"]);
directRealAnalysisInputsById.set("calc_formulae_014_definition_inverse_trig_functions", [
  "実三角関数の連続性と逆関数の存在",
]);
directRealAnalysisInputsById.set("calc_formulae_015_claim_cos_arctan_sin_arctan", [
  "逆三角関数 arctan と三角関数 sin・cos",
]);

function collectTargets(value: unknown, targets = new Set<string>()): Set<string> {
  if (Array.isArray(value)) {
    for (const item of value) collectTargets(item, targets);
  } else if (value !== null && typeof value === "object") {
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

const files = await loadContentFiles();
const allBlocks = files.flatMap(({ file, blocks }) => blocks.map((block) => ({ file, block })));
const incomingReferenceCount = new Map<string, number>();
for (const { block } of allBlocks) {
  for (const target of collectTargets(block)) {
    incomingReferenceCount.set(target, (incomingReferenceCount.get(target) ?? 0) + 1);
  }
}
const isingSemanticPattern = /Ising|イジング|spin|スピン|lattice|格子|transfer|転送|sector|セクター|momentum|運動量|fermion|フェルミオン/i;
const baseEntries = files.flatMap(({ file, blocks }) =>
  blocks
    .filter(({ kind }) => kind === "definition" || kind === "claim" || kind === "theorem")
    .map((block) => {
      const semanticBlock = block as unknown as Record<string, unknown>;
      const serialized = JSON.stringify({
        title: semanticBlock.title,
        statement: semanticBlock.statement,
        proof: semanticBlock.proof,
      });
      const reuseCount = block.labels.reduce(
        (sum, label) => sum + (incomingReferenceCount.get(label) ?? 0),
        0,
      );
      const isingSemanticMatches = [...new Set(serialized.match(isingSemanticPattern) ?? [])].sort();
      const mathematicalTool = mathematicalToolFiles.has(file) && reuseCount >= 2 && isingSemanticMatches.length === 0;
      return {
        id: block.id,
        kind: block.kind,
        title: blockTitle(block),
        labels: block.labels,
        sourceFile: file,
        sourceOrdinal: block.origin?.ordinal ?? null,
        provisionalFinalChapter: mathematicalTool ? "数学的道具立て" : "2次元イジングモデル",
        classificationEvidence: {
          mathematicalToolCandidateFile: mathematicalToolFiles.has(file),
          incomingReferenceCount: reuseCount,
          isingSemanticMatches,
          rule: "道具候補ファイルかつ参照利用が2件以上かつイジング固有語彙なし",
        },
        dependsOnLabels: [...collectTargets(block)].sort(),
      };
    }),
);

const labelOwners = new Map<string, string>();
for (const { blocks } of files) {
  for (const block of blocks) for (const label of block.labels) labelOwners.set(label, block.id);
}
const baseEntryById = new Map(baseEntries.map((entry) => [entry.id, entry]));
for (const id of directRealAnalysisInputsById.keys()) {
  if (!baseEntryById.has(id)) throw new Error(`直接実数解析入力の所有ブロックが存在しません: ${id}`);
}
const reviewedCalculationFormulaEntries = baseEntries.filter(
  ({ sourceFile, provisionalFinalChapter }) =>
    sourceFile.startsWith("000_calculation_formulae_") && provisionalFinalChapter === "数学的道具立て",
);
const reviewedCalculationFormulaIds = new Set(reviewedCalculationFormulaEntries.map(({ id }) => id));
const configuredCalculationFormulaIds = new Set(calculationFormulaBoundaryById.keys());
const missingCalculationFormulaReviewIds = [...reviewedCalculationFormulaIds]
  .filter((id) => !configuredCalculationFormulaIds.has(id))
  .sort();
const staleCalculationFormulaReviewIds = [...configuredCalculationFormulaIds]
  .filter((id) => !reviewedCalculationFormulaIds.has(id))
  .sort();
if (missingCalculationFormulaReviewIds.length > 0 || staleCalculationFormulaReviewIds.length > 0) {
  throw new Error(
    `計算公式群の境界レビュー割当が棚卸し対象と一致しません。未割当=${missingCalculationFormulaReviewIds.join(",") || "なし"}; 対象外=${staleCalculationFormulaReviewIds.join(",") || "なし"}`,
  );
}
const reviewedCalculationFormulaLabels = new Set<string>(
  reviewedCalculationFormulaEntries.flatMap(({ labels }) => labels),
);
const semanticPrerequisiteLabelsById = new Map<string, string[]>();
for (const entry of baseEntries) {
  const boundary = calculationFormulaBoundaryById.get(entry.id);
  const excluded = boundary?.nonPrerequisiteReferenceLabels ?? [];
  const implicit = boundary?.implicitPrerequisiteLabels ?? [];
  const realAnalysisPropagationExcluded = boundary?.realAnalysisPropagationExcludedLabels ?? [];
  if (new Set(excluded).size !== excluded.length) {
    throw new Error(`前提でない参照ラベルが重複しています: ${entry.id}`);
  }
  if (new Set(implicit).size !== implicit.length) {
    throw new Error(`暗黙の前提ラベルが重複しています: ${entry.id}`);
  }
  if (new Set(realAnalysisPropagationExcluded).size !== realAnalysisPropagationExcluded.length) {
    throw new Error(`実数解析伝播を除外するラベルが重複しています: ${entry.id}`);
  }
  for (const label of excluded) {
    if (!entry.dependsOnLabels.includes(label)) {
      throw new Error(`前提でない参照ラベルが raw ref に存在しません: ${entry.id}: ${label}`);
    }
    if (!labelOwners.has(label)) {
      throw new Error(`前提でない参照ラベルの所有者が存在しません: ${entry.id}: ${label}`);
    }
  }
  for (const label of implicit) {
    if (entry.dependsOnLabels.includes(label)) {
      throw new Error(`暗黙の前提ラベルが raw ref と重複しています: ${entry.id}: ${label}`);
    }
    if (!labelOwners.has(label)) {
      throw new Error(`暗黙の前提ラベルの所有者が存在しません: ${entry.id}: ${label}`);
    }
  }
  const excludedSet = new Set(excluded);
  const semanticPrerequisiteLabels = [
    ...entry.dependsOnLabels.filter((label) => !excludedSet.has(label)),
    ...implicit,
  ].sort();
  for (const label of realAnalysisPropagationExcluded) {
    if (!semanticPrerequisiteLabels.includes(label)) {
      throw new Error(`実数解析伝播を除外するラベルが意味的前提に存在しません: ${entry.id}: ${label}`);
    }
  }
  semanticPrerequisiteLabelsById.set(entry.id, semanticPrerequisiteLabels);
}

type TransitiveRealAnalysisDependency = {
  sourceId: string;
  sourceLabels: string[];
  directInputs: string[];
  pathLabels: string[];
};

function transitiveRealAnalysisDependencies(
  entryId: string,
  visiting = new Set<string>(),
): TransitiveRealAnalysisDependency[] {
  if (visiting.has(entryId)) return [];
  const nextVisiting = new Set(visiting).add(entryId);
  const dependencies: TransitiveRealAnalysisDependency[] = [];
  const propagationExcludedLabels = new Set(
    calculationFormulaBoundaryById.get(entryId)?.realAnalysisPropagationExcludedLabels ?? [],
  );
  for (const label of semanticPrerequisiteLabelsById.get(entryId) ?? []) {
    if (propagationExcludedLabels.has(label)) continue;
    const ownerId = labelOwners.get(label);
    if (ownerId === undefined) throw new Error(`意味的前提ラベルの所有者が存在しません: ${entryId}: ${label}`);
    const directInputs = directRealAnalysisInputsById.get(ownerId);
    if (directInputs !== undefined) {
      dependencies.push({
        sourceId: ownerId,
        sourceLabels: [...(baseEntryById.get(ownerId)?.labels ?? [])],
        directInputs,
        pathLabels: [label],
      });
    }
    for (const nested of transitiveRealAnalysisDependencies(ownerId, nextVisiting)) {
      dependencies.push({ ...nested, pathLabels: [label, ...nested.pathLabels] });
    }
  }
  const shortestPathBySource = new Map<string, TransitiveRealAnalysisDependency>();
  for (const dependency of dependencies) {
    const current = shortestPathBySource.get(dependency.sourceId);
    const dependencyPath = dependency.pathLabels.join("->");
    const currentPath = current?.pathLabels.join("->") ?? "";
    if (
      current === undefined ||
      dependency.pathLabels.length < current.pathLabels.length ||
      (dependency.pathLabels.length === current.pathLabels.length && dependencyPath < currentPath)
    ) {
      shortestPathBySource.set(dependency.sourceId, dependency);
    }
  }
  return [...shortestPathBySource.values()].sort((left, right) => left.sourceId.localeCompare(right.sourceId));
}

const entries = baseEntries.map((entry) => {
  const boundary = calculationFormulaBoundaryById.get(entry.id);
  if (boundary === undefined) return entry;
  const nonPrerequisiteReferenceLabels = new Set(boundary.nonPrerequisiteReferenceLabels ?? []);
  const implicitPrerequisiteLabels = [...(boundary.implicitPrerequisiteLabels ?? [])].sort();
  const realAnalysisPropagationExcludedLabels = [
    ...(boundary.realAnalysisPropagationExcludedLabels ?? []),
  ].sort();
  const prerequisiteLabels = semanticPrerequisiteLabelsById.get(entry.id) ?? [];
  const insideDependencyLabels = prerequisiteLabels
    .filter((label) => reviewedCalculationFormulaLabels.has(label))
    .sort();
  const outsideDependencyLabels = prerequisiteLabels
    .filter((label) => !reviewedCalculationFormulaLabels.has(label))
    .sort();
  const directRealAnalysisInputs = directRealAnalysisInputsById.get(entry.id) ?? [];
  const transitiveDependencies = transitiveRealAnalysisDependencies(entry.id);
  const reachesRealAnalysis = directRealAnalysisInputs.length > 0 || transitiveDependencies.length > 0;
  if (boundary.closure === "有限複素行列だけで閉じる" && reachesRealAnalysis) {
    throw new Error(`有限分類から実数解析へ到達します: ${entry.id}`);
  }
  if (boundary.closure === "実数解析への脱出を伴う" && !reachesRealAnalysis) {
    throw new Error(`実数解析分類に直接入力も推移的入力もありません: ${entry.id}`);
  }
  return {
    ...entry,
    calculationFormulaBoundaryReview: {
      closure: boundary.closure,
      rationale: boundary.rationale,
      directRealAnalysisInputs,
      transitiveRealAnalysisDependencies: transitiveDependencies,
      dependencyBoundary: {
        insideReviewedCalculationFormulaLabels: insideDependencyLabels,
        outsideReviewedCalculationFormulaLabels: outsideDependencyLabels,
        implicitPrerequisiteLabels,
        referenceLabelsNotUsedAsPrerequisites: [...nonPrerequisiteReferenceLabels].sort(),
        realAnalysisPropagationExcludedLabels,
        outsideReviewedCalculationFormulaOwners: outsideDependencyLabels
          .map((label) => ({ label, ownerId: labelOwners.get(label) ?? null })),
      },
      isingSemanticVocabulary: {
        matches: entry.classificationEvidence.isingSemanticMatches,
        contaminated: entry.classificationEvidence.isingSemanticMatches.length > 0,
        inspectedFields: ["title", "statement", "proof"],
      },
    },
  };
});
const allDependencyLabels = allBlocks.flatMap(({ block }) => [...collectTargets(block)]);
const unresolvedInventoryDependencies = [...new Set(allDependencyLabels)]
  .filter((label) => !labelOwners.has(label))
  .sort();
const dependencySupportNodes = allBlocks
  .filter(({ block }) => !entries.some(({ id }) => id === block.id))
  .map(({ file, block }) => ({
    id: block.id,
    kind: block.kind,
    title: blockTitle(block),
    labels: block.labels,
    sourceFile: file,
    dependsOnLabels: [...collectTargets(block)].sort(),
  }));

const inventory = {
  schemaVersion: 1,
  scope: "exact-solution-of-2d-ising-model/structured-latex/content の definition・claim・theorem",
  finalChapters: ["数学的道具立て", "2次元イジングモデル"],
  classificationStatus: "初回のブロック単位仮分類。分類根拠を各項目へ保存し、境界レビューを継続する。",
  entryCount: entries.length,
  dependencySupportNodeCount: dependencySupportNodes.length,
  unnamedEntryIds: entries.filter(({ title }) => title === null).map(({ id }) => id),
  unlabeledEntryIds: entries.filter(({ labels }) => labels.length === 0).map(({ id }) => id),
  unresolvedInventoryDependencies,
  calculationFormulaBoundaryReview: {
    status: "数学的道具立てへ仮分類した計算公式群について、実数解析への脱出、依存境界、イジング固有語彙混入をブロック単位で確定した。",
    reviewedEntryCount: reviewedCalculationFormulaEntries.length,
    realAnalysisEscapeEntryCount: reviewedCalculationFormulaEntries.filter(
      ({ id }) => calculationFormulaBoundaryById.get(id)?.closure === "実数解析への脱出を伴う",
    ).length,
    finiteComplexMatrixEntryCount: reviewedCalculationFormulaEntries.filter(
      ({ id }) => calculationFormulaBoundaryById.get(id)?.closure === "有限複素行列だけで閉じる",
    ).length,
    classificationRule: "完備性・アルキメデス性・実指数関数・三角関数・逆三角関数・Euler公式を直接または依存先経由で使うものを実数解析への脱出とし、それらを使わず有限回の複素数・複素行列・商集合の代数操作だけで閉じるものを有限複素行列側とする。",
    reviewedEntryIds: [...reviewedCalculationFormulaIds].sort(),
  },
  realAnalysisDependencySources: [...directRealAnalysisInputsById]
    .map(([id, directInputs]) => ({
      id,
      labels: [...(baseEntryById.get(id)?.labels ?? [])],
      reviewedCalculationFormula: reviewedCalculationFormulaIds.has(id),
      directInputs,
    }))
    .sort((left, right) => left.id.localeCompare(right.id)),
  entries,
  dependencySupportNodes,
};

mkdirSync(dirname(outputPath), { recursive: true });
writeFileSync(outputPath, `${JSON.stringify(inventory, null, 2)}\n`);
console.log(`wrote ${entries.length} entries to ${outputPath}`);
