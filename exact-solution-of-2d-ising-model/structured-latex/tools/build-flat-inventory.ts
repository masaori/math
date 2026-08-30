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
  "transfer_matrix_005c_claim_end_preserves_matrix_exponential",
  "TV1_hatZ_hatY_010_definition_clifford_group",
]);
const nonPrerequisiteReferenceLabelsById = new Map<string, Set<string>>([
  ["calc_formulae_006_definition_of_cc", new Set(["abs_basic_properties", "matrix_exp_series_converges"])],
  ["linear_space_general_000_definition_kronecker_product", new Set(["kronecker_product_rule", "tensor_basis"])],
  ["TV1_hatZ_hatY_001_claim_commutator_H_Z_Y", new Set(["why_008_applies_only_to_minus_sector"])],
  ["TV1_hatZ_hatY_027_claim_eigenvector_A_theta", new Set(["A_theta_is_identity_when_gamma2_zero"])],
]);
const forwardNavigationReviewById = new Map<string, Map<string, string>>([
  ["calculation_formulae_definition_set_and_algebra_notation", new Map([["definition_of_cc", "既存の複素数定義への案内"]])],
  ["calc_formulae_006_definition_of_cc", new Map([["abs_basic_properties", "後続利用への案内"], ["matrix_exp_series_converges", "後続利用への案内"]])],
  ["TV1_hatZ_hatY_010a_claim_V2_not_in_clifford_group", new Map([["def_T_g", "後続の比較対象への案内"]])],
  ["TV1_hatZ_hatY_030_definition_fermi", new Map([["T_V_eq_T_Vprime_on_hatZ_hatY", "後続利用への案内"], ["T_Vprime_fixes_hatZ_hatY_when_gamma2_zero", "例外処理への案内"], ["critical_condition_c1_eq_s1_c2", "例外条件への案内"]])],
  ["freeenergy_002_claim_gamma_is_continuous", new Map([["riemann_sum_to_integral", "後続利用への案内"]])],
  ["evensector_002_claim_antiperiodic_exp_sum", new Map([["def_check_index_set", "後続表記への案内"]])],
  ["evensector_003_definition_half_integer_modes", new Map([["def_check_index_set", "後続表記への案内"], ["periodicity_of_check_fermi", "後続利用への案内"]])],
  ["evensector_003a_definition_check_index_set", new Map([["anticommutator_of_check_Z_Y", "後続利用への案内"], ["periodicity_of_check_fermi", "後続利用への案内"]])],
  ["evenEigen_004_claim_trace_of_check_number_operator_product", new Map([["check_joint_eigenspace_decomposition", "後続対応への案内"]])],
  ["evenEigen_006_claim_eigenvalues_of_check_Vprime", new Map([["max_eigenvalue_of_V_plus_simple", "後続帰結への案内"]])],
  ["closing_002_claim_epsilon_eigenvalue_on_check_Q", new Map([["max_eigenvector_in_even_sector", "後続利用への案内"], ["trace_of_epsilon_V_plus", "後続の符号決定への案内"]])],
]);
const forwardPrerequisiteLabelsById = new Map<string, Set<string>>([
  ["exp_conjugation_proof_003_definition_M_n_C_convergence", new Set(["def_hermitian_positive_definite", "def_trace"])],
]);
const manualGranularityReviewById = new Map<string, string>([
  ["calc_formulae_014b_claim_arcsin_bijection", "円弧長に関する外部命題の証明を本文内の一ステップ一定理へ展開する余地がある。分類境界と依存順は確定している。"],
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

function blockTitleFormat(block: object): "text" | "tex" | null {
  if (!("title" in block) || block.title === null || typeof block.title !== "object") return null;
  return "tex" in block.title ? "tex" : "text";
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
  const semanticPrerequisiteLabels: string[] = [];
  if (block.id !== "calculation_formulae_definition_set_and_algebra_notation" && /\\mathbb\s*(?:\{[NZR]\}|[NZR])/.test(inspected)) semanticPrerequisiteLabels.push("set_and_algebra_notation");
  if (!["calculation_formulae_definition_set_and_algebra_notation", "calc_formulae_006_definition_of_cc"].includes(block.id) && /\\mathbb\s*\{?C\}?/.test(inspected)) semanticPrerequisiteLabels.push("definition_of_cc");
  const rawReferenceLabels = [...new Set([...statementReferenceLabels, ...proofReferenceLabels, ...semanticPrerequisiteLabels])].sort();
  const configuredExclusions = nonPrerequisiteReferenceLabelsById.get(block.id) ?? new Set<string>();
  const forwardStatementReferenceLabels = statementReferenceLabels.filter((label) => {
    const ownerId = labelOwners.get(label);
    return ownerId !== undefined && blockPositionById.get(ownerId)! > blockPositionById.get(block.id)!;
  });
  const navigationReview = forwardNavigationReviewById.get(block.id) ?? new Map<string, string>();
  const forwardPrerequisites = forwardPrerequisiteLabelsById.get(block.id) ?? new Set<string>();
  const reviewedLabels = new Set([...navigationReview.keys(), ...forwardPrerequisites]);
  const forwardReviewMatches = forwardStatementReferenceLabels.every((label) => reviewedLabels.has(label))
    && [...reviewedLabels].every((label) => forwardStatementReferenceLabels.includes(label));
  const forwardStatementReferenceReview = navigationReview.size === 0 ? null : Object.fromEntries(navigationReview);
  const reviewedForwardNavigationLabels = forwardReviewMatches ? [...navigationReview.keys()] : [];
  const excludedReferenceLabels = new Set([...configuredExclusions, ...reviewedForwardNavigationLabels]);
  const dependsOnLabels = rawReferenceLabels.filter((label) => !excludedReferenceLabels.has(label));
  for (const label of semanticPrerequisiteLabels) if (!dependsOnLabels.includes(label)) {
    throw new Error(`記号使用から導いた意味的前提が依存辺にありません: ${block.id} -> ${label}`);
  }
  const dependsOnEntryIds = [...new Set(dependsOnLabels.map((label) => labelOwners.get(label))
    .filter((id): id is string => id !== undefined && id !== block.id && targetIds.has(id)))].sort();
  return {
    id: block.id, kind: block.kind, title: blockTitle(block), titleFormat: blockTitleFormat(block), labels: block.labels, sourceFile: file,
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
      status: abstractVocabularyMatches.length === 0 && forwardStatementReferenceLabels.length === 0 && !manualGranularityReviewById.has(block.id)
        ? "自動検査で主題に適合"
        : "具体的な行列計算への展開またはブロック分割を要する",
      criterion: "複素数と有限行列の成分・和・積・極限を、依存先から順に高校生が追える粒度で説明する",
      abstractVocabularyMatches,
      inspectedCharacterCount: inspected.length,
      forwardNavigationMixedIntoStatement: forwardStatementReferenceLabels.length > 0 && !forwardReviewMatches,
      inspectedFields: ["title", "statement", "proof"],
      manualReview: manualGranularityReviewById.get(block.id) ?? null,
    },
    dependsOnLabels, dependsOnEntryIds, semanticPrerequisiteLabels,
    referenceLabelsNotUsedAsPrerequisites: [...excludedReferenceLabels].sort(),
    forwardStatementReferenceLabelsNotUsedAsPrerequisites: reviewedForwardNavigationLabels,
    forwardStatementReferenceLabelsUsedAsPrerequisites: [...forwardPrerequisites].sort(),
    forwardStatementReferenceReview,
    blockSplitRequiredBeforeFinalOrdering: forwardStatementReferenceLabels.length > 0 && !forwardReviewMatches,
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
const unresolvedBlockSplits = entries.filter((entry) => entry.blockSplitRequiredBeforeFinalOrdering);
if (unresolvedBlockSplits.length > 0) {
  throw new Error(`未レビューの前方参照が残っています: ${unresolvedBlockSplits.map(({ id }) => id).join(", ")}`);
}
const toolEntries = entries.filter((entry) => entry.provisionalFinalChapter === "数学的道具立て");
const groupRules: [string, RegExp][] = [
  ["三角関数の評価・有限和・積分", /^(critical_008|critical_009|critical_010|freeenergy_004)/],
  ["トレース・共役転置・正定値性", /^eigenvalues_of_V_|^maxeig_005|frobenius|exp_conjugation_proof_003/],
  ["可逆行列・線型写像との対応・共役変換", /^transfer_matrix_005|^TV1_hatZ_hatY_011|^TV1_hatZ_hatY_009|^TV1_hatZ_hatY_010|exp_conjugation_proof_005|^calculation_formulae_046/],
  ["行列指数関数と交換子計算", /^exp_linear_map_|exp_conjugation_proof_(004|008|010)|^bridge_003|^TV1_hatZ_hatY_004/],
  ["数ベクトル・行列の長さと収束", /^linear_space_general_00(2b|2c|3|3b|3c|3d)/],
  ["クロネッカー積と多因子基底", /^linear_space_general_000|^linear_space_general_001/],
  ["有限行列・Pauli行列・交換子", /^linear_space_general_002_|^linear_space_general_004|^Z_Y_anticommutation_|calc_formulae_00[345]|calculation_formulae_047/],
  ["絶対値・偏角・複素平方根", /^calculation_formulae_03[1-9]|^calculation_formulae_04[0-4]/],
  ["角度・極座標・複素数の積と商", /^calc_formulae_01[1-9]|^calculation_formulae_02[2-9]|^calculation_formulae_030/],
  ["集合記号と複素数の直交座標計算", /set_and_algebra_notation|^calc_formulae_00[6-9]|^calc_formulae_010|^calculation_formulae_045|complex_conjugate/],
  ["実数の平方根・指数関数・双曲線関数", /^calc_formulae_000|^calc_formulae_001|^calc_formulae_002|^calc_formulae_definition_cosh_sinh|^critical_001/],
];
const groupOf = (entry: typeof entries[number]): string => {
  const matches = groupRules.filter(([, pattern]) => pattern.test(entry.id)).map(([name]) => name);
  if (matches.length !== 1) throw new Error(`数学的道具の分類規則一致数が1ではありません: ${entry.id}: ${matches.join(", ")}`);
  return matches[0]!;
};
const groupDescriptions = new Map([
  ["集合記号と複素数の直交座標計算", { input: "既知の自然数・整数・実数の集合と実数の四則演算", output: "集合と演算付き構造の区別、複素数を実数対として計算する規則", reason: "冒頭から記号の所属と演算を曖昧にせず、行列成分の計算へ進むため。" }],
  ["実数の平方根・指数関数・双曲線関数", { input: "非負実数と実数の級数", output: "平方根、指数関数、cosh・sinhの計算公式", reason: "行列成分に現れる係数を初等的な実数計算へ戻すため。" }],
  ["角度・極座標・複素数の積と商", { input: "平面上の実数対と円弧", output: "角度、極座標、複素数の積・逆数・商", reason: "複素固有値の位相を図形と四則演算で追うため。" }],
  ["絶対値・偏角・複素平方根", { input: "複素数の極座標表示", output: "絶対値、偏角、平方根とそれらの積・逆数の公式", reason: "固有値の大きさと平方根の枝を明示して計算するため。" }],
  ["クロネッカー積と多因子基底", { input: "2次の複素行列と2次元数ベクトル", output: "具体的なクロネッカー積、その積・転置・基底", reason: "抽象テンソル積を使わず、大きな行列を小さな行列の成分から組み立てるため。" }],
  ["有限行列・Pauli行列・交換子", { input: "有限複素行列と行列積", output: "分解、共役、交換子・反交換子、Pauli行列の積", reason: "後章の全操作を手で追える有限行列の掛け算へ落とすため。" }],
  ["数ベクトル・行列の長さと収束", { input: "複素行列の成分と有限和", output: "成分から定めるノルム、不等式、成分ごとの収束と完備性", reason: "無限級数を使う箇所でも、各成分の誤差を追える形にするため。" }],
  ["行列指数関数と交換子計算", { input: "有限行列、行列積、ノルム収束", output: "行列指数関数、可換積公式、交換子の反復による共役公式", reason: "転送行列の指数表示を、有限行列の級数と積の計算だけで扱うため。" }],
  ["可逆行列・線型写像との対応・共役変換", { input: "可逆な複素行列、行列単位、数ベクトルの基底", output: "行列と作用の一対一対応、逆行列による共役作用、Pauli/Clifford行列群", reason: "行列の式とベクトルへの作用を同じ成分表で行き来し、対称性を左右から掛ける計算で追うため。" }],
  ["トレース・共役転置・正定値性", { input: "複素行列、共役転置、固有ベクトル", output: "トレース公式、Frobenius内積、エルミート性、正定値性とCauchy–Schwarz評価", reason: "最大固有値と重複度を、成分和と二次式の符号から判定するため。" }],
  ["三角関数の評価・有限和・積分", { input: "連続な実数関数、有限和、初等的な三角関数の不等式", output: "リーマン和の極限、積分の閉形式と上下評価", reason: "有限サイズの行列計算から自由エネルギーと臨界挙動を読み取る最後の計算に必要なため。" }],
]);
const mathematicalToolGroups = [...groupDescriptions].map(([name, description]) => ({
  name, ...description,
  entryIds: toolEntries.filter((entry) => groupOf(entry) === name).sort((a, b) => a.dependencyPlacement!.chapterOrder - b.dependencyPlacement!.chapterOrder).map(({ id }) => id),
}));
const groupedToolIds = mathematicalToolGroups.flatMap(({ entryIds }) => entryIds);
if (groupedToolIds.length !== toolEntries.length || new Set(groupedToolIds).size !== toolEntries.length) {
  throw new Error("数学的道具立ての分類群が全項目を一意に被覆していません");
}
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
  classificationStatus: "全項目の分類・説明粒度・ブロック境界を再検証し、章内依存順と数学的道具立ての分類群を確定済み。",
  entryCount: entries.length,
  chapterEntryCounts: Object.fromEntries(finalChapters.map((chapter) => [chapter, entries.filter((entry) => entry.provisionalFinalChapter === chapter).length])),
  mathematicalToolGroups,
  explanationGranularityReview: {
    reviewedEntryCount: entries.length,
    criterion: "高度な抽象理論を導入せず、複素数と有限行列の具体的な計算を依存先から順に追えること",
    flaggedEntryIds: entries.filter((entry) =>
      entry.explanationGranularityReview.abstractVocabularyMatches.length > 0 || entry.explanationGranularityReview.forwardNavigationMixedIntoStatement || entry.explanationGranularityReview.manualReview !== null
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
