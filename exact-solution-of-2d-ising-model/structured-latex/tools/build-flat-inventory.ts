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

type FiniteMatrixToolBoundary = {
  nonPrerequisiteReferenceLabels?: string[];
  statementDomain: string;
  rationale: string;
};

type AnalyticMatrixToolBoundary = {
  closure: "実数解析への脱出を伴う";
  directRealAnalysisInputs: string[];
  directRealAnalysisInputExcludedLabels?: string[];
  realAnalysisPropagationExcludedLabels?: string[];
  statementDomain: string;
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

const finiteMatrixToolBoundaryById = new Map<string, FiniteMatrixToolBoundary>([
  ["linear_space_general_000_definition_kronecker_product", {
    nonPrerequisiteReferenceLabels: ["kronecker_product_rule", "tensor_basis"],
    statementDomain: "有限次元複素ベクトル空間と有限複素行列",
    rationale: "成分によるクロネッカー積の定義であり、後続の積公式と基底定理への参照は前提ではなく利用先の案内である。",
  }],
  ["linear_space_general_000b_claim_kronecker_product_rule", {
    statementDomain: "有限複素行列",
    rationale: "クロネッカー積の定義と有限和だけで積公式を示す。",
  }],
  ["linear_space_general_000c_claim_kronecker_multilinear", {
    statementDomain: "有限複素行列",
    rationale: "クロネッカー積の定義から成分ごとの有限な四則演算だけで多重線型性を示す。",
  }],
  ["linear_space_general_001_theorem_tensor_product_basis", {
    statementDomain: "有限次元複素ベクトル空間",
    rationale: "標準基底とクロネッカー積の多重線型性から有限個の基底を具体的に構成する。",
  }],
  ["linear_space_general_002_claim_scalar_identity_commutes", {
    statementDomain: "現行 statement は任意の体上の有限正方行列（複素行列を含む）",
    rationale: "スカラー行列と有限正方行列の成分計算だけで閉じる。現行の体 K による一般化は、最終的な複素行列への具体化時に別途確認する。",
  }],
  ["linear_space_general_004_lemma_centralizer_is_scalar", {
    statementDomain: "有限次元複素ベクトル空間と有限複素行列",
    rationale: "クロネッカー積で構成した行列単位との有限な交換関係だけから中心化する行列をスカラー行列に限定する。",
  }],
]);

const analyticMatrixToolBoundaryById = new Map<string, AnalyticMatrixToolBoundary>([
  ["linear_space_general_002b_definition_matrix_norm", {
    closure: "実数解析への脱出を伴う",
    directRealAnalysisInputs: ["実数列の収束概念"],
    realAnalysisPropagationExcludedLabels: ["def_abs_arg"],
    statementDomain: "有限次元の実・複素数ベクトル空間と有限正方行列、および実数列の収束",
    rationale: "Frobenius ノルムの平方根と複素絶対値を使う。偏角は参照先ブロックに同居するだけで、この定義の前提ではない。",
  }],
  ["linear_space_general_002c_claim_matrix_norm_triangle_inequality", {
    closure: "実数解析への脱出を伴う",
    directRealAnalysisInputs: [
      "実数列の極限の和",
      "非負定数を 0 収束列で上から抑える極限・順序則",
    ],
    realAnalysisPropagationExcludedLabels: ["def_abs_arg"],
    statementDomain: "有限次元の実・複素正方行列と、その実数値 Frobenius ノルム",
    rationale: "複素絶対値・非負実数の平方根・実数の順序を使ってノルムの基本性質を示す。偏角そのものは使わない。",
  }],
  ["linear_space_general_003_claim_matrix_norm_submultiplicativity", {
    closure: "実数解析への脱出を伴う",
    directRealAnalysisInputs: [],
    directRealAnalysisInputExcludedLabels: [
      "def_matrix_norm",
      "matrix_norm_triangle_inequality",
    ],
    statementDomain: "有限次元の実・複素正方行列と、その実数値 Frobenius ノルム",
    rationale: "有限和の Cauchy--Schwarz 型評価は代数的だが、実数解析へ脱出するノルムの定義と基本性質を前提とする。",
  }],
  ["linear_space_general_003c_claim_matrix_norm_vector_bound", {
    closure: "実数解析への脱出を伴う",
    directRealAnalysisInputs: [],
    directRealAnalysisInputExcludedLabels: [
      "def_matrix_norm",
      "matrix_norm_triangle_inequality",
    ],
    statementDomain: "有限次元の実・複素数ベクトルと有限正方行列、およびそれらの実数値 Frobenius ノルム",
    rationale: "数ベクトルを一列目に埋め込んだ有限行列の劣乗法性へ帰着するため、ノルムの解析的前提を推移的に引き継ぐ。",
  }],
  ["linear_space_general_003d_claim_matrix_completeness", {
    closure: "実数解析への脱出を伴う",
    directRealAnalysisInputs: [
      "実数の完備性（実数 Cauchy 列の収束）",
      "0 に収束する実数列の平方も 0 に収束すること",
      "有限個の実数列の極限と有限和の交換",
      "収束する実数列は Cauchy 列であること",
      "非負項級数の部分和と極限の順序、および極限への不等式の移行",
    ],
    directRealAnalysisInputExcludedLabels: ["matrix_norm_triangle_inequality"],
    statementDomain: "有限次元の実・複素正方行列からなるノルム空間と、その Cauchy 列・無限級数",
    rationale: "実数の完備性を直接使い、複素数列と有限行列列の完備性および絶対収束判定へ移す。",
  }],
  ["linear_space_general_003b_claim_matrix_multiplication_continuity", {
    closure: "実数解析への脱出を伴う",
    directRealAnalysisInputs: ["0 に収束する実数列の定数倍も 0 に収束すること"],
    statementDomain: "有限次元の実・複素正方行列の収束と固定行列による右乗算",
    rationale: "行列ノルムの劣乗法性から実数列の極限評価へ帰着するため、ノルムの解析的前提を推移的に引き継ぐ。",
  }],
]);

const directRealAnalysisInputsById = new Map<string, string[]>(
  [...calculationFormulaBoundaryById, ...analyticMatrixToolBoundaryById]
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
const isingSemanticPattern = /Ising|イジング|spin|スピン|site|サイト|lattice|格子|transfer|転送|sector|セクター|momentum|運動量|fermion|フェルミオン/i;
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
const configuredFiniteMatrixToolIds = new Set(finiteMatrixToolBoundaryById.keys());
for (const id of configuredFiniteMatrixToolIds) {
  const entry = baseEntryById.get(id);
  if (entry === undefined) throw new Error(`有限複素行列の道具群の所有ブロックが存在しません: ${id}`);
  if (entry.sourceFile !== "002_linear_space_general.ts") {
    throw new Error(`有限複素行列の道具群が線型空間一般ファイルにありません: ${id}: ${entry.sourceFile}`);
  }
  if (entry.provisionalFinalChapter !== "数学的道具立て") {
    throw new Error(`有限複素行列の道具群が数学的道具立てへ仮分類されていません: ${id}`);
  }
}
const reviewedFiniteMatrixToolEntries = [...configuredFiniteMatrixToolIds]
  .map((id) => baseEntryById.get(id)!)
  .sort((left, right) => left.id.localeCompare(right.id));
const reviewedFiniteMatrixToolLabels = new Set<string>(
  reviewedFiniteMatrixToolEntries.flatMap(({ labels }) => labels),
);
const configuredAnalyticMatrixToolIds = new Set(analyticMatrixToolBoundaryById.keys());
for (const id of configuredAnalyticMatrixToolIds) {
  const entry = baseEntryById.get(id);
  if (entry === undefined) throw new Error(`解析的行列道具群の所有ブロックが存在しません: ${id}`);
  if (entry.sourceFile !== "002_linear_space_general.ts") {
    throw new Error(`解析的行列道具群が線型空間一般ファイルにありません: ${id}: ${entry.sourceFile}`);
  }
  if (entry.provisionalFinalChapter !== "数学的道具立て") {
    throw new Error(`解析的行列道具群が数学的道具立てへ仮分類されていません: ${id}`);
  }
  if (entry.classificationEvidence.isingSemanticMatches.length > 0) {
    throw new Error(`解析的行列道具群にイジング固有語彙が混入しています: ${id}`);
  }
}
const reviewedAnalyticMatrixToolEntries = [...configuredAnalyticMatrixToolIds]
  .map((id) => baseEntryById.get(id)!)
  .sort((left, right) => left.id.localeCompare(right.id));
const reviewedAnalyticMatrixToolLabels = new Set<string>(
  reviewedAnalyticMatrixToolEntries.flatMap(({ labels }) => labels),
);
const reviewedCalculationFormulaLabels = new Set<string>(
  reviewedCalculationFormulaEntries.flatMap(({ labels }) => labels),
);
const semanticPrerequisiteLabelsById = new Map<string, string[]>();
for (const entry of baseEntries) {
  const calculationBoundary = calculationFormulaBoundaryById.get(entry.id);
  const finiteMatrixBoundary = finiteMatrixToolBoundaryById.get(entry.id);
  const analyticMatrixBoundary = analyticMatrixToolBoundaryById.get(entry.id);
  const excluded = [
    ...(calculationBoundary?.nonPrerequisiteReferenceLabels ?? []),
    ...(finiteMatrixBoundary?.nonPrerequisiteReferenceLabels ?? []),
  ];
  const implicit = calculationBoundary?.implicitPrerequisiteLabels ?? [];
  const realAnalysisPropagationExcluded = calculationBoundary?.realAnalysisPropagationExcludedLabels ?? [];
  realAnalysisPropagationExcluded.push(
    ...(analyticMatrixBoundary?.realAnalysisPropagationExcludedLabels ?? []),
  );
  if (new Set(excluded).size !== excluded.length) {
    throw new Error(`前提でない参照ラベルが重複しています: ${entry.id}`);
  }
  if (new Set(implicit).size !== implicit.length) {
    throw new Error(`暗黙の前提ラベルが重複しています: ${entry.id}`);
  }
  if (new Set(realAnalysisPropagationExcluded).size !== realAnalysisPropagationExcluded.length) {
    throw new Error(`実数解析伝播を除外するラベルが重複しています: ${entry.id}`);
  }
  const directRealAnalysisInputExcluded = [
    ...(analyticMatrixBoundary?.directRealAnalysisInputExcludedLabels ?? []),
  ];
  if (new Set(directRealAnalysisInputExcluded).size !== directRealAnalysisInputExcluded.length) {
    throw new Error(`直接実数解析入力を除外するラベルが重複しています: ${entry.id}`);
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
  for (const label of directRealAnalysisInputExcluded) {
    if (!entry.dependsOnLabels.includes(label)) {
      throw new Error(`直接実数解析入力を除外するラベルが raw ref に存在しません: ${entry.id}: ${label}`);
    }
    const ownerId = labelOwners.get(label);
    if (ownerId === undefined) {
      throw new Error(`直接実数解析入力を除外するラベルの所有者が存在しません: ${entry.id}: ${label}`);
    }
    if ((directRealAnalysisInputsById.get(ownerId) ?? []).length === 0) {
      throw new Error(`直接実数解析入力を除外する参照先に直接入力がありません: ${entry.id}: ${label}: ${ownerId}`);
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
const finiteMatrixToolOutsideDependencies = reviewedFiniteMatrixToolEntries.flatMap(({ id }) =>
  (semanticPrerequisiteLabelsById.get(id) ?? [])
    .filter((label) => !reviewedFiniteMatrixToolLabels.has(label))
    .map((label) => ({ entryId: id, label, ownerId: labelOwners.get(label) ?? null })),
);
if (finiteMatrixToolOutsideDependencies.length > 0) {
  throw new Error(
    `有限複素行列の道具群に外部前提があります: ${finiteMatrixToolOutsideDependencies
      .map(({ entryId, label, ownerId }) => `${entryId}:${label}:${ownerId ?? "所有者なし"}`)
      .join(",")}`,
  );
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
  inheritedDirectInputExcludedOwnerIds = new Set<string>(),
): TransitiveRealAnalysisDependency[] {
  if (visiting.has(entryId)) return [];
  const nextVisiting = new Set(visiting).add(entryId);
  const dependencies: TransitiveRealAnalysisDependency[] = [];
  const propagationExcludedLabels = new Set(
    [
      ...(calculationFormulaBoundaryById.get(entryId)?.realAnalysisPropagationExcludedLabels ?? []),
      ...(analyticMatrixToolBoundaryById.get(entryId)?.realAnalysisPropagationExcludedLabels ?? []),
    ],
  );
  const directInputExcludedOwnerIds = new Set(
    inheritedDirectInputExcludedOwnerIds,
  );
  for (const label of analyticMatrixToolBoundaryById.get(entryId)?.directRealAnalysisInputExcludedLabels ?? []) {
    const ownerId = labelOwners.get(label);
    if (ownerId === undefined) {
      throw new Error(`直接実数解析入力を除外するラベルの所有者が存在しません: ${entryId}: ${label}`);
    }
    directInputExcludedOwnerIds.add(ownerId);
  }
  for (const label of semanticPrerequisiteLabelsById.get(entryId) ?? []) {
    if (propagationExcludedLabels.has(label)) continue;
    const ownerId = labelOwners.get(label);
    if (ownerId === undefined) throw new Error(`意味的前提ラベルの所有者が存在しません: ${entryId}: ${label}`);
    const directInputs = directRealAnalysisInputsById.get(ownerId);
    if (directInputs !== undefined && !directInputExcludedOwnerIds.has(ownerId)) {
      dependencies.push({
        sourceId: ownerId,
        sourceLabels: [...(baseEntryById.get(ownerId)?.labels ?? [])],
        directInputs,
        pathLabels: [label],
      });
    }
    for (const nested of transitiveRealAnalysisDependencies(
      ownerId,
      nextVisiting,
      directInputExcludedOwnerIds,
    )) {
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
  const finiteMatrixBoundary = finiteMatrixToolBoundaryById.get(entry.id);
  const analyticMatrixBoundary = analyticMatrixToolBoundaryById.get(entry.id);
  if (boundary === undefined && finiteMatrixBoundary === undefined && analyticMatrixBoundary === undefined) return entry;
  if (finiteMatrixBoundary !== undefined) {
    const nonPrerequisiteReferenceLabels = new Set(
      finiteMatrixBoundary.nonPrerequisiteReferenceLabels ?? [],
    );
    const prerequisiteLabels = semanticPrerequisiteLabelsById.get(entry.id) ?? [];
    const insideDependencyLabels = prerequisiteLabels
      .filter((label) => reviewedFiniteMatrixToolLabels.has(label))
      .sort();
    const outsideDependencyLabels = prerequisiteLabels
      .filter((label) => !reviewedFiniteMatrixToolLabels.has(label))
      .sort();
    return {
      ...entry,
      finiteMatrixToolBoundaryReview: {
        statementDomain: finiteMatrixBoundary.statementDomain,
        rationale: finiteMatrixBoundary.rationale,
        finalChapter: "数学的道具立て",
        dependencyBoundary: {
          insideReviewedFiniteMatrixToolLabels: insideDependencyLabels,
          outsideReviewedFiniteMatrixToolLabels: outsideDependencyLabels,
          referenceLabelsNotUsedAsPrerequisites: [...nonPrerequisiteReferenceLabels].sort(),
          outsideReviewedFiniteMatrixToolOwners: outsideDependencyLabels
            .map((label) => ({ label, ownerId: labelOwners.get(label) ?? null })),
        },
        isingSemanticVocabulary: {
          matches: entry.classificationEvidence.isingSemanticMatches,
          contaminated: entry.classificationEvidence.isingSemanticMatches.length > 0,
          inspectedFields: ["title", "statement", "proof"],
        },
      },
    };
  }
  if (analyticMatrixBoundary !== undefined) {
    const prerequisiteLabels = semanticPrerequisiteLabelsById.get(entry.id) ?? [];
    const insideDependencyLabels = prerequisiteLabels
      .filter((label) => reviewedAnalyticMatrixToolLabels.has(label))
      .sort();
    const outsideDependencyLabels = prerequisiteLabels
      .filter((label) => !reviewedAnalyticMatrixToolLabels.has(label))
      .sort();
    const directRealAnalysisInputs = directRealAnalysisInputsById.get(entry.id) ?? [];
    const transitiveDependencies = transitiveRealAnalysisDependencies(entry.id);
    if (directRealAnalysisInputs.length === 0 && transitiveDependencies.length === 0) {
      throw new Error(`解析的行列道具群から実数解析へ到達できません: ${entry.id}`);
    }
    return {
      ...entry,
      analyticMatrixToolBoundaryReview: {
        closure: analyticMatrixBoundary.closure,
        statementDomain: analyticMatrixBoundary.statementDomain,
        rationale: analyticMatrixBoundary.rationale,
        directRealAnalysisInputs,
        transitiveRealAnalysisDependencies: transitiveDependencies,
        finalChapter: "数学的道具立て",
        dependencyBoundary: {
          insideReviewedAnalyticMatrixToolLabels: insideDependencyLabels,
          outsideReviewedAnalyticMatrixToolLabels: outsideDependencyLabels,
          realAnalysisPropagationExcludedLabels: [
            ...(analyticMatrixBoundary.realAnalysisPropagationExcludedLabels ?? []),
          ].sort(),
          directRealAnalysisInputExcludedLabels: [
            ...(analyticMatrixBoundary.directRealAnalysisInputExcludedLabels ?? []),
          ].sort(),
          outsideReviewedAnalyticMatrixToolOwners: outsideDependencyLabels
            .map((label) => ({ label, ownerId: labelOwners.get(label) ?? null })),
        },
        isingSemanticVocabulary: {
          matches: entry.classificationEvidence.isingSemanticMatches,
          contaminated: entry.classificationEvidence.isingSemanticMatches.length > 0,
          inspectedFields: ["title", "statement", "proof"],
        },
      },
    };
  }
  if (boundary === undefined) throw new Error(`計算公式群の境界情報がありません: ${entry.id}`);
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
  finiteMatrixToolBoundaryReview: {
    status: "クロネッカー積・その基底・スカラー行列・中心化に属する道具群について、依存境界とイジング固有語彙混入をブロック単位で確定した。",
    reviewedEntryCount: reviewedFiniteMatrixToolEntries.length,
    isingContaminatedEntryCount: reviewedFiniteMatrixToolEntries.filter(
      ({ classificationEvidence }) => classificationEvidence.isingSemanticMatches.length > 0,
    ).length,
    outsideDependencyLabelCount: finiteMatrixToolOutsideDependencies.length,
    classificationRule: "イジング模型を参照せず、有限次元のベクトル・行列の成分計算だけで statement と proof の意味が閉じるものを数学的道具立てに置く。",
    reviewedEntryIds: reviewedFiniteMatrixToolEntries.map(({ id }) => id),
  },
  analyticMatrixToolBoundaryReview: {
    status: "数ベクトル・行列ノルム、劣乗法性、ベクトル評価、完備性、行列乗算の連続性について、実数解析への脱出と依存境界をブロック単位で確定した。",
    reviewedEntryCount: reviewedAnalyticMatrixToolEntries.length,
    realAnalysisEscapeEntryCount: reviewedAnalyticMatrixToolEntries.filter(
      ({ id }) => analyticMatrixToolBoundaryById.get(id)?.closure === "実数解析への脱出を伴う",
    ).length,
    isingContaminatedEntryCount: reviewedAnalyticMatrixToolEntries.filter(
      ({ classificationEvidence }) => classificationEvidence.isingSemanticMatches.length > 0,
    ).length,
    classificationRule: "有限次元の成分計算だけで証明の主要部分を記述できても、実数値ノルム・極限・Cauchy 列・無限級数が非負実数の平方根または実数の完備性へ依存するものは、数学的道具立てに置いたまま実数解析への脱出を明記する。",
    reviewedEntryIds: reviewedAnalyticMatrixToolEntries.map(({ id }) => id),
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
