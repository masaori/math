import { createHash } from "node:crypto";
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
  "TV1_hatZ_hatY_011a_claim_center_of_invertible_matrices_is_scalar",
  "TV1_hatZ_hatY_011a_claim_injectivity_of_T",
  "transfer_matrix_005_definition_end_isomorphism",
  "transfer_matrix_005b_claim_end_is_algebra_isomorphism",
  "transfer_matrix_005c_claim_end_preserves_matrix_exponential",
  "transfer_matrix_claim_end_acts_on_kronecker_products",
  "TV1_hatZ_hatY_010_definition_clifford_group",
]);
const matrixExponentialConjugationSectionEntryIds = [
  "exp_conjugation_proof_010_theorem_matrix_exp_conjugation",
  "exp_conjugation_proof_008_theorem_exp_ad_series",
] as const;
const matrixExponentialConjugationExpectedInternalDependencies = new Map<string, string[]>([
  ["exp_conjugation_proof_010_theorem_matrix_exp_conjugation", []],
  ["exp_conjugation_proof_008_theorem_exp_ad_series", [
    "exp_conjugation_proof_010_theorem_matrix_exp_conjugation",
  ]],
]);
const matrixExponentialConjugationExpectedContentSha256 = new Map<string, string>([
  ["exp_conjugation_proof_010_theorem_matrix_exp_conjugation", "64229f938d8d19d12dd93c396ec488b8f44803a7f0f9d00b6c4b3ce8a115a867"],
  ["exp_conjugation_proof_008_theorem_exp_ad_series", "c9e30902311cd76998b6716da76e040f081a0b4dcad42a5f1ad6d99331ab999b"],
]);
const matrixExponentialConjugationExpectedExternalInputEntryIds = [
  "calc_formulae_006_definition_of_cc",
  "calculation_formulae_definition_set_and_algebra_notation",
  "exp_conjugation_proof_004_theorem_ad_binomial",
  "exp_conjugation_proof_005_definition_ad_X_Ad_g_matrix",
  "exp_linear_map_000a_claim_real_exp_series_converges",
  "exp_linear_map_000b_claim_matrix_exp_series_converges",
  "exp_linear_map_001_theorem_exp_series_pointwise_converges",
  "exp_linear_map_002_definition_exp_of_endomorphism",
  "exp_linear_map_003_theorem_exp_product_formula_commuting_matrices",
  "exp_linear_map_004_theorem_exp_zero_is_identity",
  "linear_space_general_002b_definition_matrix_norm",
  "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
  "linear_space_general_003_claim_matrix_norm_submultiplicativity",
  "linear_space_general_003d_claim_matrix_completeness",
].sort();
const matrixLinearMapCorrespondenceSectionEntryIds = [
  "transfer_matrix_005_definition_end_isomorphism",
  "transfer_matrix_005b_claim_end_is_algebra_isomorphism",
  "transfer_matrix_005c_claim_end_preserves_matrix_exponential",
  "transfer_matrix_claim_end_acts_on_kronecker_products",
] as const;
const matrixLinearMapCorrespondenceExpectedInternalDependencies = new Map<string, string[]>([
  ["transfer_matrix_005_definition_end_isomorphism", []],
  ["transfer_matrix_005b_claim_end_is_algebra_isomorphism", [
    "transfer_matrix_005_definition_end_isomorphism",
  ]],
  ["transfer_matrix_005c_claim_end_preserves_matrix_exponential", [
    "transfer_matrix_005_definition_end_isomorphism",
    "transfer_matrix_005b_claim_end_is_algebra_isomorphism",
  ]],
  ["transfer_matrix_claim_end_acts_on_kronecker_products", [
    "transfer_matrix_005_definition_end_isomorphism",
  ]],
]);
const matrixLinearMapCorrespondenceExpectedContentSha256 = new Map<string, string>([
  ["transfer_matrix_005_definition_end_isomorphism", "651f3dbd8a1ace2d2c641c9424fb4148011370c9100f9887ab06b9696e18d52a"],
  ["transfer_matrix_005b_claim_end_is_algebra_isomorphism", "1a9ecef9cd59f12d82071b4c248e4319f7c9be8e3f42cf1bc9289737d9e5d033"],
  ["transfer_matrix_005c_claim_end_preserves_matrix_exponential", "6b163e3b366800fd0dcda4eec827fa428e8721922ff5b3e064127c321b4d62c0"],
  ["transfer_matrix_claim_end_acts_on_kronecker_products", "1a2d1ad2a81a5e00bb14c44c0527fe6bd668077325112d62a4a0e4278960c019"],
]);
const matrixLinearMapCorrespondenceExpectedExternalInputEntryIds = [
  "calc_formulae_006_definition_of_cc",
  "calculation_formulae_definition_set_and_algebra_notation",
  "exp_linear_map_001_theorem_exp_series_pointwise_converges",
  "exp_linear_map_002_definition_exp_of_endomorphism",
  "linear_space_general_000_definition_kronecker_product",
  "linear_space_general_000b_claim_kronecker_product_rule",
  "linear_space_general_000c_claim_kronecker_multilinear",
  "linear_space_general_001_theorem_tensor_product_basis",
].sort();
const matrixLinearMapCorrespondenceExpectedExternalInputContentSha256 = new Map<string, string>([
  ["calculation_formulae_definition_set_and_algebra_notation", "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"],
  ["calc_formulae_006_definition_of_cc", "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"],
  ["linear_space_general_000_definition_kronecker_product", "cb60348ee4a6bdfc5b4d4e4dc7124aed4f3a9f4e4c5593c03ad6511884cc55f8"],
  ["linear_space_general_000b_claim_kronecker_product_rule", "59404eda021b5d904e2248530a586d168aea7d32d03451a45a17bb2f8b583a21"],
  ["linear_space_general_000c_claim_kronecker_multilinear", "e06631c60e429b8e755520b8069138cab273e66c4946ec5a46c83dc4293738a7"],
  ["linear_space_general_001_theorem_tensor_product_basis", "59e2b9e24e79916e00dfe666d29bdee556ea3479b16e89d9912457ff3bea0609"],
  ["exp_linear_map_001_theorem_exp_series_pointwise_converges", "2edea69b2935e8d7678d2b7d4b34edbfcb0faa8ccaff86cea76d70a57d2ed814"],
  ["exp_linear_map_002_definition_exp_of_endomorphism", "6d1e05adbfc624b89b429dda12fd2afb5818d6a62fa9f18d3801a2bca1506098"],
]);
const invertibleMatrixConjugationSectionEntryIds = [
  "TV1_hatZ_hatY_009_definition_invertible_elements",
  "TV1_hatZ_hatY_011_definition_T_g",
  "TV1_hatZ_hatY_011a_claim_center_of_invertible_matrices_is_scalar",
  "TV1_hatZ_hatY_011a_claim_injectivity_of_T",
] as const;
const invertibleMatrixConjugationExpectedInternalDependencies = new Map<string, string[]>([
  ["TV1_hatZ_hatY_009_definition_invertible_elements", []],
  ["TV1_hatZ_hatY_011_definition_T_g", [
    "TV1_hatZ_hatY_009_definition_invertible_elements",
  ]],
  ["TV1_hatZ_hatY_011a_claim_center_of_invertible_matrices_is_scalar", [
    "TV1_hatZ_hatY_009_definition_invertible_elements",
  ]],
  ["TV1_hatZ_hatY_011a_claim_injectivity_of_T", [
    "TV1_hatZ_hatY_009_definition_invertible_elements",
    "TV1_hatZ_hatY_011_definition_T_g",
    "TV1_hatZ_hatY_011a_claim_center_of_invertible_matrices_is_scalar",
  ]],
]);
const invertibleMatrixConjugationExpectedContentSha256 = new Map<string, string>([
  ["TV1_hatZ_hatY_009_definition_invertible_elements", "31432b10d571100575fc2bddf157032908bf0996d21d3f77860b0dc613fd7533"],
  ["TV1_hatZ_hatY_011_definition_T_g", "5f2b17e53697b3403829f55a1b07c6c85da5db2f0683d5e0d821ac74ac5baeb4"],
  ["TV1_hatZ_hatY_011a_claim_center_of_invertible_matrices_is_scalar", "36a619c070399daf4e9acddd4cc7c0b7c1b285ba09e5abd36ecc9f4d23bcafaa"],
  ["TV1_hatZ_hatY_011a_claim_injectivity_of_T", "31eb30aa17a1240d5b78d3f1ccddc35af6843ad3b1be767250f2496e8620cb67"],
]);
const invertibleMatrixConjugationExpectedExternalInputEntryIds = [
  "calc_formulae_006_definition_of_cc",
  "linear_space_general_000b_claim_kronecker_product_rule",
  "linear_space_general_000c_claim_kronecker_multilinear",
  "linear_space_general_001_theorem_tensor_product_basis",
  "linear_space_general_002_claim_scalar_identity_commutes",
  "linear_space_general_004_lemma_centralizer_is_scalar",
].sort();
const invertibleMatrixConjugationExpectedExternalInputContentSha256 = new Map<string, string>([
  ["calc_formulae_006_definition_of_cc", "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"],
  ["linear_space_general_000b_claim_kronecker_product_rule", "59404eda021b5d904e2248530a586d168aea7d32d03451a45a17bb2f8b583a21"],
  ["linear_space_general_000c_claim_kronecker_multilinear", "e06631c60e429b8e755520b8069138cab273e66c4946ec5a46c83dc4293738a7"],
  ["linear_space_general_001_theorem_tensor_product_basis", "59e2b9e24e79916e00dfe666d29bdee556ea3479b16e89d9912457ff3bea0609"],
  ["linear_space_general_002_claim_scalar_identity_commutes", "dac86df17efd7a9fb3cc6421cdb38343493e285c3b2ff479207ad72e26fba1d5"],
  ["linear_space_general_004_lemma_centralizer_is_scalar", "a1e7706dec1460c8b6da421c8f57cd5e62eb65328f76a3320022d946f3e39573"],
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
  const inspectedContentSha256 = createHash("sha256").update(inspected).digest("hex");
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
      inspectedContentSha256,
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
const matrixExponentialConjugationSectionIdSet = new Set<string>(matrixExponentialConjugationSectionEntryIds);
const matrixExponentialConjugationSectionEntries = matrixExponentialConjugationSectionEntryIds.map((id) => {
  const entry = entries.find((candidate) => candidate.id === id);
  if (entry === undefined) throw new Error(`行列指数関数による共役の節候補に必要な項目がありません: ${id}`);
  if (entry.provisionalFinalChapter !== "数学的道具立て") {
    throw new Error(`行列指数関数による共役の節候補が数学的道具立てにありません: ${id}`);
  }
  const actualInternalDependencies = entry.dependsOnEntryIds
    .filter((dependencyId) => matrixExponentialConjugationSectionIdSet.has(dependencyId))
    .sort();
  const expectedInternalDependencies = [...matrixExponentialConjugationExpectedInternalDependencies.get(id)!].sort();
  if (JSON.stringify(actualInternalDependencies) !== JSON.stringify(expectedInternalDependencies)) {
    throw new Error(`行列指数関数による共役の節候補の内部依存辺が変わりました: ${id}: ${JSON.stringify(actualInternalDependencies)}`);
  }
  if (entry.explanationGranularityReview.inspectedContentSha256 !== matrixExponentialConjugationExpectedContentSha256.get(id)) {
    throw new Error(`行列指数関数による共役の節候補のレビュー済み本文が変わりました: ${id}`);
  }
  return entry;
});
const matrixExponentialConjugationSectionOrders = matrixExponentialConjugationSectionEntries
  .map((entry) => entry.dependencyPlacement!.chapterOrder);
if (!matrixExponentialConjugationSectionOrders.every((chapterOrder, index) =>
  index === 0 || chapterOrder === matrixExponentialConjugationSectionOrders[index - 1]! + 1)) {
  throw new Error(`行列指数関数による共役の節候補が章内依存順の連続区間ではありません: ${JSON.stringify(matrixExponentialConjugationSectionOrders)}`);
}
const matrixExponentialConjugationInternalDependencyTargets = new Set(
  [...matrixExponentialConjugationExpectedInternalDependencies.values()].flat(),
);
const matrixExponentialConjugationTerminalEntryIds = matrixExponentialConjugationSectionEntryIds
  .filter((id) => !matrixExponentialConjugationInternalDependencyTargets.has(id));
if (JSON.stringify(matrixExponentialConjugationTerminalEntryIds) !== JSON.stringify(["exp_conjugation_proof_008_theorem_exp_ad_series"])) {
  throw new Error(`行列指数関数による共役の節候補が節末の系へ閉じていません: ${JSON.stringify(matrixExponentialConjugationTerminalEntryIds)}`);
}
const matrixExponentialConjugationExternalInputEntryIds = [...new Set(
  matrixExponentialConjugationSectionEntries.flatMap((entry) => entry.dependsOnEntryIds)
    .filter((id) => !matrixExponentialConjugationSectionIdSet.has(id)),
)].sort((a, b) => order.get(a)!.chapterOrder - order.get(b)!.chapterOrder);
if (JSON.stringify([...matrixExponentialConjugationExternalInputEntryIds].sort())
  !== JSON.stringify(matrixExponentialConjugationExpectedExternalInputEntryIds)) {
  throw new Error(`行列指数関数による共役の節候補の外部入力が変わりました: ${JSON.stringify(matrixExponentialConjugationExternalInputEntryIds)}`);
}
const matrixLinearMapCorrespondenceSectionIdSet = new Set<string>(matrixLinearMapCorrespondenceSectionEntryIds);
const matrixLinearMapCorrespondenceSectionEntries = matrixLinearMapCorrespondenceSectionEntryIds.map((id) => {
  const entry = entries.find((candidate) => candidate.id === id);
  if (entry === undefined) throw new Error(`行列と線型写像の対応の節候補に必要な項目がありません: ${id}`);
  if (entry.provisionalFinalChapter !== "数学的道具立て") {
    throw new Error(`行列と線型写像の対応の節候補が数学的道具立てにありません: ${id}`);
  }
  const actualInternalDependencies = entry.dependsOnEntryIds
    .filter((dependencyId) => matrixLinearMapCorrespondenceSectionIdSet.has(dependencyId))
    .sort();
  const expectedInternalDependencies = [...matrixLinearMapCorrespondenceExpectedInternalDependencies.get(id)!].sort();
  if (JSON.stringify(actualInternalDependencies) !== JSON.stringify(expectedInternalDependencies)) {
    throw new Error(`行列と線型写像の対応の節候補の内部依存辺が変わりました: ${id}: ${JSON.stringify(actualInternalDependencies)}`);
  }
  if (entry.explanationGranularityReview.inspectedContentSha256 !== matrixLinearMapCorrespondenceExpectedContentSha256.get(id)) {
    throw new Error(`行列と線型写像の対応の節候補のレビュー済み本文が変わりました: ${id}`);
  }
  return entry;
});
const matrixLinearMapCorrespondenceSectionOrders = matrixLinearMapCorrespondenceSectionEntries
  .map((entry) => entry.dependencyPlacement!.chapterOrder);
if (!matrixLinearMapCorrespondenceSectionOrders.every((chapterOrder, index) =>
  index === 0 || chapterOrder === matrixLinearMapCorrespondenceSectionOrders[index - 1]! + 1)) {
  throw new Error(`行列と線型写像の対応の節候補が章内依存順の連続区間ではありません: ${JSON.stringify(matrixLinearMapCorrespondenceSectionOrders)}`);
}
const matrixLinearMapCorrespondenceInternalDependencyTargets = new Set(
  [...matrixLinearMapCorrespondenceExpectedInternalDependencies.values()].flat(),
);
const matrixLinearMapCorrespondenceTerminalEntryIds = matrixLinearMapCorrespondenceSectionEntryIds
  .filter((id) => !matrixLinearMapCorrespondenceInternalDependencyTargets.has(id));
if (JSON.stringify(matrixLinearMapCorrespondenceTerminalEntryIds)
  !== JSON.stringify([
    "transfer_matrix_005c_claim_end_preserves_matrix_exponential",
    "transfer_matrix_claim_end_acts_on_kronecker_products",
  ])) {
  throw new Error(`行列と線型写像の対応の節候補が二つの節末出力へ閉じていません: ${JSON.stringify(matrixLinearMapCorrespondenceTerminalEntryIds)}`);
}
const matrixLinearMapCorrespondenceExternalInputEntryIds = [...new Set(
  matrixLinearMapCorrespondenceSectionEntries.flatMap((entry) => entry.dependsOnEntryIds)
    .filter((id) => !matrixLinearMapCorrespondenceSectionIdSet.has(id)),
)].sort((a, b) => order.get(a)!.chapterOrder - order.get(b)!.chapterOrder);
if (JSON.stringify([...matrixLinearMapCorrespondenceExternalInputEntryIds].sort())
  !== JSON.stringify(matrixLinearMapCorrespondenceExpectedExternalInputEntryIds)) {
  throw new Error(`行列と線型写像の対応の節候補の外部入力が変わりました: ${JSON.stringify(matrixLinearMapCorrespondenceExternalInputEntryIds)}`);
}
for (const id of matrixLinearMapCorrespondenceExternalInputEntryIds) {
  const entry = entries.find((candidate) => candidate.id === id)!;
  if (entry.explanationGranularityReview.inspectedContentSha256
    !== matrixLinearMapCorrespondenceExpectedExternalInputContentSha256.get(id)) {
    throw new Error(`行列と線型写像の対応の節候補の外部入力本文が変わりました: ${id}`);
  }
}
const invertibleMatrixConjugationSectionIdSet = new Set<string>(invertibleMatrixConjugationSectionEntryIds);
const invertibleMatrixConjugationSectionEntries = invertibleMatrixConjugationSectionEntryIds.map((id) => {
  const entry = entries.find((candidate) => candidate.id === id);
  if (entry === undefined) throw new Error(`可逆行列と共役写像の節候補に必要な項目がありません: ${id}`);
  if (entry.provisionalFinalChapter !== "数学的道具立て") {
    throw new Error(`可逆行列と共役写像の節候補が数学的道具立てにありません: ${id}`);
  }
  const actualInternalDependencies = entry.dependsOnEntryIds
    .filter((dependencyId) => invertibleMatrixConjugationSectionIdSet.has(dependencyId))
    .sort();
  const expectedInternalDependencies = [...invertibleMatrixConjugationExpectedInternalDependencies.get(id)!].sort();
  if (JSON.stringify(actualInternalDependencies) !== JSON.stringify(expectedInternalDependencies)) {
    throw new Error(`可逆行列と共役写像の節候補の内部依存辺が変わりました: ${id}: ${JSON.stringify(actualInternalDependencies)}`);
  }
  if (entry.explanationGranularityReview.inspectedContentSha256 !== invertibleMatrixConjugationExpectedContentSha256.get(id)) {
    throw new Error(`可逆行列と共役写像の節候補のレビュー済み本文が変わりました: ${id}`);
  }
  return entry;
});
const invertibleMatrixConjugationSectionOrders = invertibleMatrixConjugationSectionEntries
  .map((entry) => entry.dependencyPlacement!.chapterOrder);
if (!invertibleMatrixConjugationSectionOrders.every((chapterOrder, index) =>
  index === 0 || chapterOrder === invertibleMatrixConjugationSectionOrders[index - 1]! + 1)) {
  throw new Error(`可逆行列と共役写像の節候補が章内依存順の連続区間ではありません: ${JSON.stringify(invertibleMatrixConjugationSectionOrders)}`);
}
const invertibleMatrixConjugationInternalDependencyTargets = new Set(
  [...invertibleMatrixConjugationExpectedInternalDependencies.values()].flat(),
);
const invertibleMatrixConjugationTerminalEntryIds = invertibleMatrixConjugationSectionEntryIds
  .filter((id) => !invertibleMatrixConjugationInternalDependencyTargets.has(id));
if (JSON.stringify(invertibleMatrixConjugationTerminalEntryIds)
  !== JSON.stringify(["TV1_hatZ_hatY_011a_claim_injectivity_of_T"])) {
  throw new Error(`可逆行列と共役写像の節候補が節末の主定理へ閉じていません: ${JSON.stringify(invertibleMatrixConjugationTerminalEntryIds)}`);
}
const invertibleMatrixConjugationExternalInputEntryIds = [...new Set(
  invertibleMatrixConjugationSectionEntries.flatMap((entry) => entry.dependsOnEntryIds)
    .filter((id) => !invertibleMatrixConjugationSectionIdSet.has(id)),
)].sort((a, b) => order.get(a)!.chapterOrder - order.get(b)!.chapterOrder);
if (JSON.stringify([...invertibleMatrixConjugationExternalInputEntryIds].sort())
  !== JSON.stringify(invertibleMatrixConjugationExpectedExternalInputEntryIds)) {
  throw new Error(`可逆行列と共役写像の節候補の外部入力が変わりました: ${JSON.stringify(invertibleMatrixConjugationExternalInputEntryIds)}`);
}
for (const id of invertibleMatrixConjugationExternalInputEntryIds) {
  const entry = entries.find((candidate) => candidate.id === id)!;
  if (entry.explanationGranularityReview.inspectedContentSha256
    !== invertibleMatrixConjugationExpectedExternalInputContentSha256.get(id)) {
    throw new Error(`可逆行列と共役写像の節候補の外部入力本文が変わりました: ${id}`);
  }
}
const mathematicalToolSectionBoundaries = [{
  name: "行列指数関数による共役の級数公式",
  chapter: "数学的道具立て",
  status: "構造確定・本文粒度未解決",
  entryIds: matrixExponentialConjugationSectionEntryIds,
  input: [
    "複素数と有限複素行列の四則演算、交換子作用とその二項展開",
    "行列ノルムと完備性",
    "実数・行列・行列作用の指数級数、その収束、可換行列の指数関数の積公式",
  ],
  externalInputEntryIds: matrixExponentialConjugationExternalInputEntryIds,
  output: [
    "行列指数関数による共役を反復交換子の指数級数で表す主定理",
    "主定理の右辺を項ごとに明示する系",
  ],
  mainTheorem: "行列版の指数関数による共役公式",
  mainTheoremEntryId: "exp_conjugation_proof_010_theorem_matrix_exp_conjugation",
  concludingCorollary: "主定理の反復交換子級数を項ごとに明示する系",
  concludingCorollaryEntryId: "exp_conjugation_proof_008_theorem_exp_ad_series",
  boundaryEvidence: "章内依存順の連続する二項であり、行列版の共役公式を主定理とし、その右辺を項ごとに明示する系で節を閉じる。外部入力・内部依存辺・本文 fingerprint・連続性・節末の一意性を生成時に固定検査する。",
  readabilityStatus: "二項とも具体的な行列計算への展開またはブロック分割を要するため、節境界だけを確定し、本文完成とは扱わない。",
}, {
  name: "行列と線型写像の対応",
  chapter: "数学的道具立て",
  status: "構造確定・本文粒度未解決",
  entryIds: matrixLinearMapCorrespondenceSectionEntryIds,
  input: [
    "複素数、有限複素行列、数ベクトル、線型写像",
    "具体的なクロネッカー積、その積と多重線型性、クロネッカー積で作る行列単位と数ベクトルの基底",
    "行列と線型写像の指数級数",
  ],
  externalInputEntryIds: matrixLinearMapCorrespondenceExternalInputEntryIds,
  output: [
    "行列単位を基底上の線型写像へ送る写像の具体的な定義",
    "その写像が積と単位元を保つ全単射であるという主定理",
    "クロネッカー積で作る行列が各因子の数ベクトルへ成分ごとに作用する公式",
    "行列表示と線型写像表示の間で指数関数が保たれる系",
  ],
  mainTheorem: "行列表示から線型写像表示への写像は単位的な複素代数の同型である",
  mainTheoremEntryId: "transfer_matrix_005b_claim_end_is_algebra_isomorphism",
  concludingCorollary: "行列表示と線型写像表示の間で指数関数が保たれる系",
  concludingCorollaryEntryId: "transfer_matrix_005c_claim_end_preserves_matrix_exponential",
  boundaryEvidence: "章内依存順の連続する四項であり、対応の定義から積と単位元を保つ全単射という主定理へ進み、クロネッカー積の作用公式と指数関数保存の系という二つの出力で節を閉じる。外部入力とその本文 fingerprint、内部依存辺、節内本文 fingerprint、連続性、二つの節末出力を生成時に固定検査する。",
  readabilityStatus: "四項とも線型写像の抽象語彙を含むため、節境界だけを確定し、定義内の基底・基底作用・対応の分割を含む本文完成とは扱わない。",
}, {
  name: "可逆行列と共役写像",
  chapter: "数学的道具立て",
  status: "構造確定・本文粒度確認済み",
  entryIds: invertibleMatrixConjugationSectionEntryIds,
  input: [
    "複素数と有限複素行列の和・積・単位行列",
    "具体的なクロネッカー積の積と多重線型性、およびクロネッカー積で作る行列単位の基底",
    "スカラー倍した単位行列が全行列と可換すること",
    "全行列と可換する複素行列がスカラー倍した単位行列に限ること",
  ],
  externalInputEntryIds: invertibleMatrixConjugationExternalInputEntryIds,
  output: [
    "可逆行列と逆行列の具体的な定義および積・逆元・スカラー単位行列に関する基本性質",
    "可逆行列による共役写像の定義",
    "可逆行列全体の中で全可逆行列と可換する元が非零スカラー倍の単位行列に限ること",
    "二つの共役写像が等しいことと、それらを定める可逆行列が非零スカラー倍だけ異なることの同値",
  ],
  mainTheorem: "可逆行列による共役写像は、それを定める行列の非零スカラー倍を除いて単射である",
  mainTheoremEntryId: "TV1_hatZ_hatY_011a_claim_injectivity_of_T",
  boundaryEvidence: "章内依存順の連続する四項であり、可逆元の定義から共役写像の定義と可逆行列全体の可換元の特徴付けへ進み、両者を使う定数倍を除いた単射性の主定理で節を閉じる。外部入力とその本文 fingerprint、内部依存辺、節内本文 fingerprint、連続性、節末出力の一意性を生成時に固定検査する。",
  readabilityStatus: "四項とも複素数と有限行列の具体的な計算で書かれ、現行の説明粒度検査に合格している。未定義だった特性多項式・固有値・行列式による可逆化を削除し、明示的な逆行列をもつ行列単位の摂動だけを使う証明へ置き換えた。",
}];
const toolEntries = entries.filter((entry) => entry.provisionalFinalChapter === "数学的道具立て");
const groupRules: [string, RegExp][] = [
  ["三角関数の評価・有限和・積分", /^(critical_008|critical_009|critical_010|freeenergy_004)/],
  ["トレース・共役転置・正定値性", /^eigenvalues_of_V_|^maxeig_005|frobenius|exp_conjugation_proof_003/],
  ["可逆行列・線型写像との対応・共役変換", /^transfer_matrix_005|^transfer_matrix_claim_end_|^TV1_hatZ_hatY_011|^TV1_hatZ_hatY_009|^TV1_hatZ_hatY_010|exp_conjugation_proof_005|^calculation_formulae_046/],
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
  schemaVersion: 3,
  scope: "exact-solution-of-2d-ising-model/structured-latex/content の全 definition・claim・theorem",
  organizingTheme: "高校生でも読める具体的な複素数・行列計算として2次元イジング模型の厳密解を積み上げる",
  withdrawnBoundaryAxes: ["実数解析への脱出を伴う道具／有限複素行列だけで閉じる道具", "可算／非可算"],
  boundaryRule: "章境界は対象の意味がイジング模型に依存するかだけで定め、解析や集合の濃度は章・節境界に使わない。",
  finalChapters,
  classificationStatus: "全項目の分類・説明粒度・ブロック境界を再検証し、章内依存順と数学的道具立ての分類群を確定済み。",
  entryCount: entries.length,
  chapterEntryCounts: Object.fromEntries(finalChapters.map((chapter) => [chapter, entries.filter((entry) => entry.provisionalFinalChapter === chapter).length])),
  mathematicalToolGroups,
  mathematicalToolSectionBoundaries,
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
