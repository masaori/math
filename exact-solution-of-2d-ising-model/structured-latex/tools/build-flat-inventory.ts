import { createHash } from "node:crypto";
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

type MatrixExponentialToolBoundary = AnalyticMatrixToolBoundary;

type MatrixExponentialToolBoundaryWithPaths = MatrixExponentialToolBoundary & {
  realAnalysisPropagationExcludedPaths?: string[][];
};

type ExpConjugationToolBoundary = {
  closure: "実数解析への脱出を伴う" | "有限複素行列だけで閉じる";
  directRealAnalysisInputs: string[];
  directRealAnalysisInputExcludedLabels?: string[];
  realAnalysisPropagationExcludedLabels?: string[];
  realAnalysisPropagationExcludedPaths?: string[][];
  statementDomain: string;
  rationale: string;
  highSchoolReadabilityRationale: string;
  reviewedContentFingerprint?: string;
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

const matrixExponentialToolBoundaryById = new Map<string, MatrixExponentialToolBoundaryWithPaths>([
  ["exp_linear_map_000a_claim_real_exp_series_converges", {
    closure: "実数解析への脱出を伴う",
    directRealAnalysisInputs: [
      "実数のアルキメデス性（完備性から従う）",
      "単調非減少かつ上に有界な実数列の収束（実数の完備性）",
      "単調収束列の極限と上限の一致",
      "実数列の極限の差",
    ],
    statementDomain: "非負実数上の指数級数、その部分和と剰余",
    rationale: "上限性質に基づく単調収束定理とアルキメデス性を直接使って、指数級数の収束と剰余評価を示す。",
  }],
  ["exp_linear_map_000b_claim_matrix_exp_series_converges", {
    closure: "実数解析への脱出を伴う",
    directRealAnalysisInputs: ["単調非減少かつ上に有界な実数列の収束（実数の完備性）"],
    directRealAnalysisInputExcludedLabels: ["matrix_norm_triangle_inequality"],
    statementDomain: "有限次元の実・複素正方行列、その実数値 Frobenius ノルムと行列級数",
    rationale: "行列級数を実指数級数で評価し、行列空間の完備性と絶対収束判定を使う。三角不等式から使うのは有限和とスカラー倍の性質であり、その証明に同居する極限則は使わない。",
  }],
  ["exp_linear_map_001_theorem_exp_series_pointwise_converges", {
    closure: "実数解析への脱出を伴う",
    directRealAnalysisInputs: [
      "実数列のはさみうちの原理",
      "0 に収束する実数列の定数倍も 0 に収束すること",
      "有限個の実数列の極限と有限和の交換",
      "単調非減少かつ上に有界な実数列の収束（実数の完備性）",
    ],
    statementDomain: "有限次元の実・複素正方行列、数ベクトル、行列上の線型写像と、それらの指数級数の各点収束",
    rationale: "行列指数級数のノルム収束を数ベクトル・成分へ移す際に実数列のはさみうちを使い、線型写像の指数級数では単調有界収束と有限和の極限則を直接使う。",
  }],
  ["exp_linear_map_002_definition_exp_of_endomorphism", {
    closure: "実数解析への脱出を伴う",
    directRealAnalysisInputs: [],
    statementDomain: "有限次元の実・複素正方行列と、行列空間上の線型写像",
    rationale: "行列と行列上の線型写像の指数関数を、先行するノルム収束・各点収束と極限一意性に基づいて定義する。",
  }],
  ["exp_linear_map_003_theorem_exp_product_formula_commuting_matrices", {
    closure: "実数解析への脱出を伴う",
    directRealAnalysisInputs: [
      "無限大へ発散する自然数添字に沿った 0 収束列も 0 に収束すること",
      "0 に収束する実数列の有限和・非負定数倍も 0 に収束すること",
    ],
    realAnalysisPropagationExcludedPaths: [["def_exp", "exp_converges"]],
    statementDomain: "有限次元の可換な実・複素正方行列と、その指数関数",
    rationale: "二項定理と有限行列計算に加え、指数級数の剰余を発散する添字で評価し、ノルム収束列の積と有限和の極限を使う。",
  }],
  ["exp_linear_map_004_theorem_exp_zero_is_identity", {
    closure: "実数解析への脱出を伴う",
    directRealAnalysisInputs: [
      "収束級数から有限個の初項を分離すること",
      "収束する行列級数の項別スカラー倍",
    ],
    realAnalysisPropagationExcludedPaths: [["def_exp", "exp_converges"]],
    statementDomain: "有限次元の零行列・単位行列と、その指数関数",
    rationale: "有限な零行列計算そのものに加え、指数関数を定める収束行列級数の初項分離と項別スカラー倍を使う。",
  }],
]);

const expConjugationToolBoundaryById = new Map<string, ExpConjugationToolBoundary>([
  ["exp_conjugation_proof_003_definition_M_n_C_convergence", {
    closure: "実数解析への脱出を伴う",
    directRealAnalysisInputs: [],
    directRealAnalysisInputExcludedLabels: ["matrix_norm_triangle_inequality"],
    realAnalysisPropagationExcludedPaths: [["frobenius_inner_product_axioms", "def_abs_arg"]],
    reviewedContentFingerprint: "491cfaa6e64bf02edbbf1981e85da9c26842fe35b840e329dbc9b63a38b4d8ed",
    statementDomain: "有限複素正方行列、その Frobenius 内積・実数値ノルム・行列列と行列級数",
    rationale: "内積と随伴は有限複素行列の代数で定まるが、ノルムの平方根、実数列で定める収束、行列空間の完備性へ依存する。ノルムの基本性質から使うのは正定値性・斉次性・三角不等式であり、同じ参照先にある極限一意性は使わない。Frobenius 内積の性質は、内積の定義を前提にする一方、ノルムを非負実数値として定義できることの証明を担うため、両ブロックを同一節の不可分な依存単位として扱う。Frobenius 内積の性質から使う絶対値は大きさだけで、偏角・逆三角関数へは進まない。",
    highSchoolReadabilityRationale: "複素共役、随伴、トレース、内積、ノルム、収束を成分表示から順に定義し、解析へ移る箇所を本文中で明示している。",
  }],
  ["exp_conjugation_proof_003b_claim_frobenius_inner_product_axioms", {
    closure: "実数解析への脱出を伴う",
    directRealAnalysisInputs: [],
    directRealAnalysisInputExcludedLabels: [
      "def_matrix_norm",
      "matrix_norm_triangle_inequality",
    ],
    realAnalysisPropagationExcludedLabels: [
      "def_abs_arg",
      "def_frobenius_inner_product",
    ],
    reviewedContentFingerprint: "01f1fd118fe322f17aebad727a8c671fd4e9c88b9d0a1cee144779ee7d0c17c7",
    statementDomain: "有限複素正方行列、その Frobenius 内積と実数値ノルム",
    rationale: "共役対称性・線型性と、内積の自己評価を絶対値平方の有限和へ書き直す成分恒等式までは有限複素行列の代数で閉じる。正定値性の零判定・ノルムとの一致、および Cauchy--Schwarz と三角不等式は複素絶対値、非負実数の平方根、実数の順序を使うため、ブロック全体は実数解析への脱出を伴う。絶対値から偏角へは進まず、内積・ノルムの定義と基本性質に同居する収束概念・完備性・極限則も使わない。",
    highSchoolReadabilityRationale: "複素共役と有限和を成分ごとに展開し、Cauchy--Schwarz を非負なノルム平方の評価へ帰着しているため、参照先の絶対値・平方根・実数順序から順に追跡できる。",
  }],
  ["exp_conjugation_proof_004_theorem_ad_binomial", {
    closure: "有限複素行列だけで閉じる",
    directRealAnalysisInputs: [],
    statementDomain: "有限次元の実・複素正方行列、その交換子と有限回反復",
    rationale: "交換子の再帰、有限和、二項係数、行列積の結合律と分配律だけを使う帰納法で閉じ、極限・完備性・無限級数を使わない。",
    highSchoolReadabilityRationale: "交換子と反復を具体的に定義し、基底段階と帰納段階を有限和の添字変換まで一段ずつ展開している。",
  }],
  ["exp_conjugation_proof_005_definition_ad_X_Ad_g_matrix", {
    closure: "有限複素行列だけで閉じる",
    directRealAnalysisInputs: [],
    realAnalysisPropagationExcludedLabels: ["def_frobenius_inner_product"],
    reviewedContentFingerprint: "930af3abd137c24cd733790389e704b29fc6806d67db2ab194870211238a0dfd",
    statementDomain: "有限複素正方行列、交換子作用、および正則行列による共役作用",
    rationale: "交換子、行列積、逆行列から二つの作用を定義する有限代数で閉じる。行列空間の参照から使うのは集合 M(n;C) の記号だけであり、同じ参照先にある内積・ノルム・収束の解析的部分は使わない。",
    highSchoolReadabilityRationale: "抽象的な Lie 群・Lie 環を導入せず、行列の積・差・逆行列だけで写像と逆写像を具体的に確かめている。",
  }],
  ["exp_conjugation_proof_010_theorem_matrix_exp_conjugation", {
    closure: "実数解析への脱出を伴う",
    directRealAnalysisInputs: [
      "収束する実数列は有界であること",
      "有界な実数列と 0 に収束する実数列の積は 0 に収束すること",
      "無限大へ発散する自然数添字に沿った 0 収束列も 0 に収束すること",
      "0 に収束する実数列の有限和・非負定数倍も 0 に収束すること",
      "非負実数列を 0 収束列で上から抑えるはさみうちの原理",
    ],
    statementDomain: "有限次元の複素正方行列、その指数関数、交換子作用の指数関数とノルム収束",
    rationale: "交換子の二項展開と有限二重和が代数的な中心だが、行列指数級数と線型写像の指数級数の収束、実指数級数の剰余、収束列の積・和・添字変更・はさみうちを使う。極限一意性は matrix_norm_triangle_inequality (4) を参照する推移的前提であり、ラベルを持たない直接入力へ重ねて数えない。",
    highSchoolReadabilityRationale: "Lie 理論を経由せず、部分和 P_N・Q_N と有限な添字集合をその場で定義し、差のノルムを実指数級数の剰余で抑える過程を順に示す。本文冒頭で後段の極限則と参照先も明示している。",
  }],
]);

const expConjugationTopologyReviewedContentFingerprintById = new Map<string, string>([
  ["exp_conjugation_proof_003_definition_M_n_C_convergence", "491cfaa6e64bf02edbbf1981e85da9c26842fe35b840e329dbc9b63a38b4d8ed"],
  ["exp_conjugation_proof_003b_claim_frobenius_inner_product_axioms", "01f1fd118fe322f17aebad727a8c671fd4e9c88b9d0a1cee144779ee7d0c17c7"],
  ["exp_conjugation_proof_004_theorem_ad_binomial", "1189ebfc4acfbd008bae561121cac2508419b50ec024620615f25520109c7b9e"],
  ["exp_conjugation_proof_005_definition_ad_X_Ad_g_matrix", "930af3abd137c24cd733790389e704b29fc6806d67db2ab194870211238a0dfd"],
  ["exp_conjugation_proof_010_theorem_matrix_exp_conjugation", "64229f938d8d19d12dd93c396ec488b8f44803a7f0f9d00b6c4b3ce8a115a867"],
]);

const directRealAnalysisInputsById = new Map<string, string[]>(
  [
    ...calculationFormulaBoundaryById,
    ...analyticMatrixToolBoundaryById,
    ...matrixExponentialToolBoundaryById,
    ...expConjugationToolBoundaryById,
  ]
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

function reviewContentFingerprint(block: object): string {
  const semanticBlock = block as Record<string, unknown>;
  return createHash("sha256")
    .update(JSON.stringify({
      title: semanticBlock.title,
      statement: semanticBlock.statement,
      proof: semanticBlock.proof,
    }))
    .digest("hex");
}

const files = await loadContentFiles();
const allBlocks = files.flatMap(({ file, blocks }) => blocks.map((block) => ({ file, block })));
const reviewContentFingerprintById = new Map(
  allBlocks.map(({ block }) => [block.id, reviewContentFingerprint(block)]),
);
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
      const heuristicMathematicalTool = mathematicalToolFiles.has(file) && reuseCount >= 2 && isingSemanticMatches.length === 0;
      const semanticBoundaryReviewOverride =
        expConjugationToolBoundaryById.has(block.id) &&
        !heuristicMathematicalTool &&
        isingSemanticMatches.length === 0;
      const mathematicalTool = heuristicMathematicalTool || semanticBoundaryReviewOverride;
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
          ...(semanticBoundaryReviewOverride ? { semanticBoundaryReviewOverride: true } : {}),
          rule: semanticBoundaryReviewOverride
            ? "イジング固有語彙がなく、確定済みの数学的道具立てブロックの意味的前提となるため、参照利用が1件でも本文レビューを優先"
            : "道具候補ファイルかつ参照利用が2件以上かつイジング固有語彙なし",
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
const reviewedMatrixExponentialCandidateIds = new Set(
  baseEntries
    .filter(
      ({ sourceFile, provisionalFinalChapter }) =>
        sourceFile === "003_exp_linear_map.ts" && provisionalFinalChapter === "数学的道具立て",
    )
    .map(({ id }) => id),
);
const configuredMatrixExponentialToolIds = new Set(matrixExponentialToolBoundaryById.keys());
const missingMatrixExponentialToolReviewIds = [...reviewedMatrixExponentialCandidateIds]
  .filter((id) => !configuredMatrixExponentialToolIds.has(id))
  .sort();
const staleMatrixExponentialToolReviewIds = [...configuredMatrixExponentialToolIds]
  .filter((id) => !reviewedMatrixExponentialCandidateIds.has(id))
  .sort();
if (missingMatrixExponentialToolReviewIds.length > 0 || staleMatrixExponentialToolReviewIds.length > 0) {
  throw new Error(
    `行列指数関数の境界レビュー割当が棚卸し対象と一致しません。未割当=${missingMatrixExponentialToolReviewIds.join(",") || "なし"}; 対象外=${staleMatrixExponentialToolReviewIds.join(",") || "なし"}`,
  );
}
for (const id of configuredMatrixExponentialToolIds) {
  const entry = baseEntryById.get(id);
  if (entry === undefined) throw new Error(`行列指数関数の道具群の所有ブロックが存在しません: ${id}`);
  if (entry.sourceFile !== "003_exp_linear_map.ts") {
    throw new Error(`行列指数関数の道具群が線型写像の exp ファイルにありません: ${id}: ${entry.sourceFile}`);
  }
  if (entry.provisionalFinalChapter !== "数学的道具立て") {
    throw new Error(`行列指数関数の道具群が数学的道具立てへ仮分類されていません: ${id}`);
  }
  if (entry.classificationEvidence.isingSemanticMatches.length > 0) {
    throw new Error(`行列指数関数の道具群にイジング固有語彙が混入しています: ${id}`);
  }
}
const reviewedMatrixExponentialToolEntries = [...configuredMatrixExponentialToolIds]
  .map((id) => baseEntryById.get(id)!)
  .sort((left, right) => left.id.localeCompare(right.id));
const reviewedMatrixExponentialToolLabels = new Set<string>(
  reviewedMatrixExponentialToolEntries.flatMap(({ labels }) => labels),
);
const reviewedExpConjugationCandidateIds = new Set(
  baseEntries
    .filter(
      ({ sourceFile, provisionalFinalChapter }) =>
        sourceFile === "005_exp_conjugation_proof.ts" && provisionalFinalChapter === "数学的道具立て",
    )
    .map(({ id }) => id),
);
const configuredExpConjugationToolIds = new Set(expConjugationToolBoundaryById.keys());
const missingExpConjugationToolReviewIds = [...reviewedExpConjugationCandidateIds]
  .filter((id) => !configuredExpConjugationToolIds.has(id))
  .sort();
const staleExpConjugationToolReviewIds = [...configuredExpConjugationToolIds]
  .filter((id) => !reviewedExpConjugationCandidateIds.has(id))
  .sort();
if (missingExpConjugationToolReviewIds.length > 0 || staleExpConjugationToolReviewIds.length > 0) {
  throw new Error(
    `指数関数による共役の境界レビュー割当が棚卸し対象と一致しません。未割当=${missingExpConjugationToolReviewIds.join(",") || "なし"}; 対象外=${staleExpConjugationToolReviewIds.join(",") || "なし"}`,
  );
}
const configuredExpConjugationFingerprints = new Map<string, string>();
for (const id of configuredExpConjugationToolIds) {
  const entry = baseEntryById.get(id);
  const boundary = expConjugationToolBoundaryById.get(id)!;
  if (entry === undefined) throw new Error(`指数関数による共役の道具群の所有ブロックが存在しません: ${id}`);
  if (entry.sourceFile !== "005_exp_conjugation_proof.ts") {
    throw new Error(`指数関数による共役の道具群が共役公式ファイルにありません: ${id}: ${entry.sourceFile}`);
  }
  if (entry.provisionalFinalChapter !== "数学的道具立て") {
    throw new Error(`指数関数による共役の道具群が数学的道具立てへ仮分類されていません: ${id}`);
  }
  if (entry.classificationEvidence.isingSemanticMatches.length > 0) {
    throw new Error(`指数関数による共役の道具群にイジング固有語彙が混入しています: ${id}`);
  }
  const hasSemanticExclusion =
    (boundary.directRealAnalysisInputExcludedLabels?.length ?? 0) > 0 ||
    (boundary.realAnalysisPropagationExcludedLabels?.length ?? 0) > 0 ||
    (boundary.realAnalysisPropagationExcludedPaths?.length ?? 0) > 0;
  const configuredFingerprint = boundary.reviewedContentFingerprint;
  if (hasSemanticExclusion && configuredFingerprint === undefined) {
    throw new Error(`意味的除外を持つ共役道具にレビュー済み本文 fingerprint がありません: ${id}`);
  }
  if (!hasSemanticExclusion && configuredFingerprint !== undefined) {
    throw new Error(`意味的除外を持たない共役道具に不要なレビュー済み本文 fingerprint があります: ${id}`);
  }
  if (configuredFingerprint !== undefined) {
    if (!/^[0-9a-f]{64}$/.test(configuredFingerprint)) {
      throw new Error(`レビュー済み本文 fingerprint が小文字 SHA-256 ではありません: ${id}: ${configuredFingerprint}`);
    }
    const actualFingerprint = reviewContentFingerprintById.get(id);
    if (actualFingerprint === undefined) {
      throw new Error(`レビュー済み本文 fingerprint の対象ブロックが存在しません: ${id}`);
    }
    if (configuredFingerprint !== actualFingerprint) {
      throw new Error(
        `意味的除外を持つ共役道具の本文がレビュー後に変化しました: ${id}: 設定=${configuredFingerprint}: 現在=${actualFingerprint}`,
      );
    }
    configuredExpConjugationFingerprints.set(id, configuredFingerprint);
  }
}
const expConjugationFingerprintOwners = new Map<string, string>();
for (const [id, fingerprint] of configuredExpConjugationFingerprints) {
  const previousOwnerId = expConjugationFingerprintOwners.get(fingerprint);
  if (previousOwnerId !== undefined) {
    throw new Error(`共役道具のレビュー済み本文 fingerprint が重複しています: ${fingerprint}: ${previousOwnerId},${id}`);
  }
  expConjugationFingerprintOwners.set(fingerprint, id);
}
const reviewedExpConjugationToolEntries = [...configuredExpConjugationToolIds]
  .map((id) => baseEntryById.get(id)!)
  .sort((left, right) => left.id.localeCompare(right.id));
const topologyFingerprintIds = [...expConjugationTopologyReviewedContentFingerprintById.keys()].sort();
const reviewedExpConjugationIds = reviewedExpConjugationToolEntries.map(({ id }) => id).sort();
if (JSON.stringify(topologyFingerprintIds) !== JSON.stringify(reviewedExpConjugationIds)) {
  throw new Error(
    `共役道具のトポロジー用 fingerprint がレビュー対象5件と一致しません: fingerprint=${topologyFingerprintIds.join(",")}: レビュー=${reviewedExpConjugationIds.join(",")}`,
  );
}
for (const [id, configuredFingerprint] of expConjugationTopologyReviewedContentFingerprintById) {
  if (!/^[0-9a-f]{64}$/.test(configuredFingerprint)) {
    throw new Error(`共役道具のトポロジー用 fingerprint が小文字 SHA-256 ではありません: ${id}: ${configuredFingerprint}`);
  }
  const actualFingerprint = reviewContentFingerprintById.get(id);
  if (actualFingerprint !== configuredFingerprint) {
    throw new Error(
      `共役道具のトポロジー確定後に本文が変化しました: ${id}: 設定=${configuredFingerprint}: 現在=${actualFingerprint ?? "対象なし"}`,
    );
  }
}
const reviewedExpConjugationToolLabels = new Set<string>(
  reviewedExpConjugationToolEntries.flatMap(({ labels }) => labels),
);
const reviewedCalculationFormulaLabels = new Set<string>(
  reviewedCalculationFormulaEntries.flatMap(({ labels }) => labels),
);
const semanticPrerequisiteLabelsById = new Map<string, string[]>();
for (const entry of baseEntries) {
  const calculationBoundary = calculationFormulaBoundaryById.get(entry.id);
  const finiteMatrixBoundary = finiteMatrixToolBoundaryById.get(entry.id);
  const analyticMatrixBoundary = analyticMatrixToolBoundaryById.get(entry.id);
  const matrixExponentialBoundary = matrixExponentialToolBoundaryById.get(entry.id);
  const expConjugationBoundary = expConjugationToolBoundaryById.get(entry.id);
  const excluded = [
    ...(calculationBoundary?.nonPrerequisiteReferenceLabels ?? []),
    ...(finiteMatrixBoundary?.nonPrerequisiteReferenceLabels ?? []),
  ];
  const implicit = calculationBoundary?.implicitPrerequisiteLabels ?? [];
  const realAnalysisPropagationExcluded = calculationBoundary?.realAnalysisPropagationExcludedLabels ?? [];
  realAnalysisPropagationExcluded.push(
    ...(analyticMatrixBoundary?.realAnalysisPropagationExcludedLabels ?? []),
    ...(matrixExponentialBoundary?.realAnalysisPropagationExcludedLabels ?? []),
    ...(expConjugationBoundary?.realAnalysisPropagationExcludedLabels ?? []),
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
    ...(matrixExponentialBoundary?.directRealAnalysisInputExcludedLabels ?? []),
    ...(expConjugationBoundary?.directRealAnalysisInputExcludedLabels ?? []),
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
const frobeniusDefinitionId = "exp_conjugation_proof_003_definition_M_n_C_convergence";
const frobeniusPropertiesId = "exp_conjugation_proof_003b_claim_frobenius_inner_product_axioms";
const frobeniusDefinitionLabel = "def_frobenius_inner_product";
const frobeniusPropertiesLabel = "frobenius_inner_product_axioms";
const frobeniusDefinitionRawDependencies = baseEntryById.get(frobeniusDefinitionId)?.dependsOnLabels ?? [];
const frobeniusPropertiesRawDependencies = baseEntryById.get(frobeniusPropertiesId)?.dependsOnLabels ?? [];
const frobeniusDefinitionSemanticPrerequisites = semanticPrerequisiteLabelsById.get(frobeniusDefinitionId) ?? [];
const frobeniusPropertiesSemanticPrerequisites = semanticPrerequisiteLabelsById.get(frobeniusPropertiesId) ?? [];
if (
  !frobeniusDefinitionRawDependencies.includes(frobeniusPropertiesLabel) ||
  !frobeniusPropertiesRawDependencies.includes(frobeniusDefinitionLabel)
) {
  throw new Error("Frobenius 内積の定義と性質の raw 相互参照が本文から失われています");
}
if (
  !frobeniusDefinitionSemanticPrerequisites.includes(frobeniusPropertiesLabel) ||
  !frobeniusPropertiesSemanticPrerequisites.includes(frobeniusDefinitionLabel)
) {
  throw new Error("Frobenius 内積の定義と性質が、意味的にも相互依存する同一節単位になっていません");
}
const expConjugationContractedVertices = [
  {
    name: "Frobenius 内積の定義と性質からなる不可分な依存単位",
    entryIds: [frobeniusDefinitionId, frobeniusPropertiesId],
  },
  {
    name: "交換子の二項展開",
    entryIds: ["exp_conjugation_proof_004_theorem_ad_binomial"],
  },
  {
    name: "交換子作用・共役作用の定義",
    entryIds: ["exp_conjugation_proof_005_definition_ad_X_Ad_g_matrix"],
  },
  {
    name: "行列指数共役公式",
    entryIds: ["exp_conjugation_proof_010_theorem_matrix_exp_conjugation"],
  },
] as const;
const expConjugationContractedVertexByEntryId = new Map<string, string>();
for (const vertex of expConjugationContractedVertices) {
  for (const entryId of vertex.entryIds) {
    if (expConjugationContractedVertexByEntryId.has(entryId)) {
      throw new Error(`共役道具の縮約頂点に重複したブロックがあります: ${entryId}`);
    }
    expConjugationContractedVertexByEntryId.set(entryId, vertex.name);
  }
}
const contractedExpConjugationEntryIds = [...expConjugationContractedVertexByEntryId.keys()].sort();
const reviewedExpConjugationEntryIds = reviewedExpConjugationToolEntries.map(({ id }) => id).sort();
if (JSON.stringify(contractedExpConjugationEntryIds) !== JSON.stringify(reviewedExpConjugationEntryIds)) {
  throw new Error(
    `共役道具の縮約対象がレビュー対象5件と一致しません: 縮約=${contractedExpConjugationEntryIds.join(",")}: レビュー=${reviewedExpConjugationEntryIds.join(",")}`,
  );
}
const expConjugationContractedEdgeKeys = new Set<string>();
for (const dependentEntry of reviewedExpConjugationToolEntries) {
  const dependentVertex = expConjugationContractedVertexByEntryId.get(dependentEntry.id)!;
  for (const prerequisiteLabel of semanticPrerequisiteLabelsById.get(dependentEntry.id) ?? []) {
    const prerequisiteEntryId = labelOwners.get(prerequisiteLabel);
    if (prerequisiteEntryId === undefined || !expConjugationContractedVertexByEntryId.has(prerequisiteEntryId)) {
      continue;
    }
    const prerequisiteVertex = expConjugationContractedVertexByEntryId.get(prerequisiteEntryId)!;
    if (prerequisiteVertex !== dependentVertex) {
      expConjugationContractedEdgeKeys.add(`${prerequisiteVertex}\u0000${dependentVertex}`);
    }
  }
}
const expectedExpConjugationContractedEdgeKeys = new Set([
  "Frobenius 内積の定義と性質からなる不可分な依存単位\u0000交換子作用・共役作用の定義",
  "交換子の二項展開\u0000交換子作用・共役作用の定義",
  "交換子の二項展開\u0000行列指数共役公式",
  "交換子作用・共役作用の定義\u0000行列指数共役公式",
]);
const missingExpConjugationContractedEdges = [...expectedExpConjugationContractedEdgeKeys]
  .filter((edgeKey) => !expConjugationContractedEdgeKeys.has(edgeKey));
const unexpectedExpConjugationContractedEdges = [...expConjugationContractedEdgeKeys]
  .filter((edgeKey) => !expectedExpConjugationContractedEdgeKeys.has(edgeKey));
if (missingExpConjugationContractedEdges.length > 0 || unexpectedExpConjugationContractedEdges.length > 0) {
  throw new Error(
    `共役道具の縮約後の意味的依存辺がレビュー確定時から変化しました: 欠落=${missingExpConjugationContractedEdges.join(",") || "なし"}: 追加=${unexpectedExpConjugationContractedEdges.join(",") || "なし"}`,
  );
}
const expConjugationContractedTopologicalOrder = expConjugationContractedVertices.map(({ name }) => name);
const expConjugationContractedTopologicalIndex = new Map<string, number>(
  expConjugationContractedTopologicalOrder.map((name, index) => [name, index]),
);
for (const edgeKey of expConjugationContractedEdgeKeys) {
  const [prerequisiteVertex, dependentVertex] = edgeKey.split("\u0000");
  if (prerequisiteVertex === undefined || dependentVertex === undefined) {
    throw new Error(`共役道具の縮約辺キーが不正です: ${edgeKey}`);
  }
  if (
    expConjugationContractedTopologicalIndex.get(prerequisiteVertex)! >=
    expConjugationContractedTopologicalIndex.get(dependentVertex)!
  ) {
    throw new Error(`共役道具の縮約後トポロジカル順が意味的前提に反します: ${prerequisiteVertex} -> ${dependentVertex}`);
  }
}
const expConjugationContractedEdges = [...expConjugationContractedEdgeKeys]
  .map((edgeKey) => {
    const [prerequisite, dependent] = edgeKey.split("\u0000");
    if (prerequisite === undefined || dependent === undefined) {
      throw new Error(`共役道具の縮約辺キーが不正です: ${edgeKey}`);
    }
    return { prerequisite, dependent };
  })
  .sort((left, right) =>
    expConjugationContractedTopologicalIndex.get(left.prerequisite)! -
      expConjugationContractedTopologicalIndex.get(right.prerequisite)! ||
    expConjugationContractedTopologicalIndex.get(left.dependent)! -
      expConjugationContractedTopologicalIndex.get(right.dependent)!
  );
for (const [entryId, boundary] of [
  ...matrixExponentialToolBoundaryById,
  ...expConjugationToolBoundaryById,
]) {
  const excludedPaths = boundary.realAnalysisPropagationExcludedPaths ?? [];
  const serializedPaths = excludedPaths.map((path) => path.join("->"));
  if (new Set(serializedPaths).size !== serializedPaths.length) {
    throw new Error(`実数解析伝播を除外する経路が重複しています: ${entryId}`);
  }
  for (const path of excludedPaths) {
    if (path.length < 2) {
      throw new Error(`実数解析伝播を除外する経路は2辺以上必要です: ${entryId}: ${path.join("->")}`);
    }
    let ownerId = entryId;
    for (const label of path) {
      if (!(semanticPrerequisiteLabelsById.get(ownerId) ?? []).includes(label)) {
        throw new Error(`実数解析伝播を除外する経路が意味的前提に存在しません: ${entryId}: ${path.join("->")}: ${ownerId}:${label}`);
      }
      const nextOwnerId = labelOwners.get(label);
      if (nextOwnerId === undefined) {
        throw new Error(`実数解析伝播を除外する経路の所有者が存在しません: ${entryId}: ${path.join("->")}: ${label}`);
      }
      ownerId = nextOwnerId;
    }
  }
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
const expConjugationLaterChapterDependencies = reviewedExpConjugationToolEntries.flatMap(({ id }) =>
  (semanticPrerequisiteLabelsById.get(id) ?? [])
    .map((label) => {
      const ownerId = labelOwners.get(label) ?? null;
      return {
        entryId: id,
        label,
        ownerId,
        provisionalFinalChapter: ownerId === null
          ? null
          : baseEntryById.get(ownerId)?.provisionalFinalChapter ?? null,
      };
    })
    .filter(({ provisionalFinalChapter }) => provisionalFinalChapter === "2次元イジングモデル"),
);

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
  rootEntryId = entryId,
  pathPrefix: string[] = [],
): TransitiveRealAnalysisDependency[] {
  if (visiting.has(entryId)) return [];
  const nextVisiting = new Set(visiting).add(entryId);
  const dependencies: TransitiveRealAnalysisDependency[] = [];
  const propagationExcludedLabels = new Set(
    [
      ...(calculationFormulaBoundaryById.get(entryId)?.realAnalysisPropagationExcludedLabels ?? []),
      ...(analyticMatrixToolBoundaryById.get(entryId)?.realAnalysisPropagationExcludedLabels ?? []),
      ...(matrixExponentialToolBoundaryById.get(entryId)?.realAnalysisPropagationExcludedLabels ?? []),
      ...(expConjugationToolBoundaryById.get(entryId)?.realAnalysisPropagationExcludedLabels ?? []),
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
  for (const label of matrixExponentialToolBoundaryById.get(entryId)?.directRealAnalysisInputExcludedLabels ?? []) {
    const ownerId = labelOwners.get(label);
    if (ownerId === undefined) {
      throw new Error(`直接実数解析入力を除外するラベルの所有者が存在しません: ${entryId}: ${label}`);
    }
    directInputExcludedOwnerIds.add(ownerId);
  }
  for (const label of expConjugationToolBoundaryById.get(entryId)?.directRealAnalysisInputExcludedLabels ?? []) {
    const ownerId = labelOwners.get(label);
    if (ownerId === undefined) {
      throw new Error(`直接実数解析入力を除外するラベルの所有者が存在しません: ${entryId}: ${label}`);
    }
    directInputExcludedOwnerIds.add(ownerId);
  }
  for (const label of semanticPrerequisiteLabelsById.get(entryId) ?? []) {
    if (propagationExcludedLabels.has(label)) continue;
    const pathLabels = [...pathPrefix, label];
    const rootExcludedPaths = [
      ...(matrixExponentialToolBoundaryById.get(rootEntryId)?.realAnalysisPropagationExcludedPaths ?? []),
      ...(expConjugationToolBoundaryById.get(rootEntryId)?.realAnalysisPropagationExcludedPaths ?? []),
    ];
    if (rootExcludedPaths.some((path) => path.join("->") === pathLabels.join("->"))) continue;
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
      rootEntryId,
      pathLabels,
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
  const matrixExponentialBoundary = matrixExponentialToolBoundaryById.get(entry.id);
  const expConjugationBoundary = expConjugationToolBoundaryById.get(entry.id);
  if (
    boundary === undefined &&
    finiteMatrixBoundary === undefined &&
    analyticMatrixBoundary === undefined &&
    matrixExponentialBoundary === undefined &&
    expConjugationBoundary === undefined
  ) return entry;
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
  if (matrixExponentialBoundary !== undefined) {
    const prerequisiteLabels = semanticPrerequisiteLabelsById.get(entry.id) ?? [];
    const insideDependencyLabels = prerequisiteLabels
      .filter((label) => reviewedMatrixExponentialToolLabels.has(label))
      .sort();
    const outsideDependencyLabels = prerequisiteLabels
      .filter((label) => !reviewedMatrixExponentialToolLabels.has(label))
      .sort();
    const directRealAnalysisInputs = directRealAnalysisInputsById.get(entry.id) ?? [];
    const transitiveDependencies = transitiveRealAnalysisDependencies(entry.id);
    if (directRealAnalysisInputs.length === 0 && transitiveDependencies.length === 0) {
      throw new Error(`行列指数関数の道具群から実数解析へ到達できません: ${entry.id}`);
    }
    return {
      ...entry,
      matrixExponentialToolBoundaryReview: {
        closure: matrixExponentialBoundary.closure,
        statementDomain: matrixExponentialBoundary.statementDomain,
        rationale: matrixExponentialBoundary.rationale,
        directRealAnalysisInputs,
        transitiveRealAnalysisDependencies: transitiveDependencies,
        finalChapter: "数学的道具立て",
        dependencyBoundary: {
          insideReviewedMatrixExponentialToolLabels: insideDependencyLabels,
          outsideReviewedMatrixExponentialToolLabels: outsideDependencyLabels,
          realAnalysisPropagationExcludedLabels: [
            ...(matrixExponentialBoundary.realAnalysisPropagationExcludedLabels ?? []),
          ].sort(),
          directRealAnalysisInputExcludedLabels: [
            ...(matrixExponentialBoundary.directRealAnalysisInputExcludedLabels ?? []),
          ].sort(),
          realAnalysisPropagationExcludedPaths: [
            ...(matrixExponentialBoundary.realAnalysisPropagationExcludedPaths ?? []),
          ].map((path) => [...path]),
          outsideReviewedMatrixExponentialToolOwners: outsideDependencyLabels
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
  if (expConjugationBoundary !== undefined) {
    const prerequisiteLabels = semanticPrerequisiteLabelsById.get(entry.id) ?? [];
    const insideDependencyLabels = prerequisiteLabels
      .filter((label) => reviewedExpConjugationToolLabels.has(label))
      .sort();
    const outsideDependencyLabels = prerequisiteLabels
      .filter((label) => !reviewedExpConjugationToolLabels.has(label))
      .sort();
    const directRealAnalysisInputs = directRealAnalysisInputsById.get(entry.id) ?? [];
    const transitiveDependencies = transitiveRealAnalysisDependencies(entry.id);
    const reachesRealAnalysis = directRealAnalysisInputs.length > 0 || transitiveDependencies.length > 0;
    if (expConjugationBoundary.closure === "有限複素行列だけで閉じる" && reachesRealAnalysis) {
      throw new Error(`有限分類の指数関数による共役の道具から実数解析へ到達します: ${entry.id}`);
    }
    if (expConjugationBoundary.closure === "実数解析への脱出を伴う" && !reachesRealAnalysis) {
      throw new Error(`解析分類の指数関数による共役の道具に直接入力も推移的入力もありません: ${entry.id}`);
    }
    const outsideDependencyOwners = outsideDependencyLabels
      .map((label) => {
        const ownerId = labelOwners.get(label) ?? null;
        return {
          label,
          ownerId,
          provisionalFinalChapter: ownerId === null
            ? null
            : baseEntryById.get(ownerId)?.provisionalFinalChapter ?? null,
        };
      });
    const laterChapterPrerequisites = outsideDependencyOwners
      .filter(({ provisionalFinalChapter }) => provisionalFinalChapter === "2次元イジングモデル");
    return {
      ...entry,
      expConjugationToolBoundaryReview: {
        closure: expConjugationBoundary.closure,
        statementDomain: expConjugationBoundary.statementDomain,
        rationale: expConjugationBoundary.rationale,
        highSchoolReadability: {
          status: "依存先から順に読めば高校生が追跡可能",
          rationale: expConjugationBoundary.highSchoolReadabilityRationale,
        },
        reviewedContentFingerprint: expConjugationBoundary.reviewedContentFingerprint ?? null,
        topologyReviewedContentFingerprint:
          expConjugationTopologyReviewedContentFingerprintById.get(entry.id)!,
        directRealAnalysisInputs,
        transitiveRealAnalysisDependencies: transitiveDependencies,
        finalChapter: "数学的道具立て",
        twoChapterPlacement: {
          mathematicalToolsFirstCompatible: laterChapterPrerequisites.length === 0,
          laterChapterPrerequisites,
        },
        dependencyBoundary: {
          insideReviewedExpConjugationToolLabels: insideDependencyLabels,
          outsideReviewedExpConjugationToolLabels: outsideDependencyLabels,
          realAnalysisPropagationExcludedLabels: [
            ...(expConjugationBoundary.realAnalysisPropagationExcludedLabels ?? []),
          ].sort(),
          directRealAnalysisInputExcludedLabels: [
            ...(expConjugationBoundary.directRealAnalysisInputExcludedLabels ?? []),
          ].sort(),
          realAnalysisPropagationExcludedPaths: [
            ...(expConjugationBoundary.realAnalysisPropagationExcludedPaths ?? []),
          ].map((path) => [...path]),
          outsideReviewedExpConjugationToolOwners: outsideDependencyOwners,
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
  matrixExponentialToolBoundaryReview: {
    status: "実指数級数、行列指数級数の収束、各点収束、指数関数の定義、可換行列の積公式、零行列の指数関数について、実数解析への脱出と依存境界をブロック単位で確定した。",
    reviewedEntryCount: reviewedMatrixExponentialToolEntries.length,
    realAnalysisEscapeEntryCount: reviewedMatrixExponentialToolEntries.filter(
      ({ id }) => matrixExponentialToolBoundaryById.get(id)?.closure === "実数解析への脱出を伴う",
    ).length,
    isingContaminatedEntryCount: reviewedMatrixExponentialToolEntries.filter(
      ({ classificationEvidence }) => classificationEvidence.isingSemanticMatches.length > 0,
    ).length,
    classificationRule: "指数級数を定義する極限・完備性、実数級数の剰余、行列級数のノルム収束を直接または依存先経由で使うものは、有限行列計算を主要部分に含んでも実数解析への脱出を伴うものとして数学的道具立てに置く。",
    reviewedEntryIds: reviewedMatrixExponentialToolEntries.map(({ id }) => id),
  },
  expConjugationToolBoundaryReview: {
    status: "行列空間のノルムと収束、Frobenius 内積の性質、交換子の二項展開、交換子作用・共役作用、行列指数共役公式について、実数解析への脱出、依存境界、二章配置、高校生可読性をブロック単位で確定した。Frobenius 内積の定義と性質を一頂点へ縮約し、意味的前提だけによるトポロジカル順を確定した。",
    frobeniusMutualReferenceBoundary: {
      rawMutualReferencePreserved: true,
      semanticMutualPrerequisitePreserved: true,
      stronglyConnectedEntryIds: [frobeniusDefinitionId, frobeniusPropertiesId],
      placement: "同じ節の不可分な依存単位として扱う",
      rationale: "性質命題は内積の定義を前提にし、定義ブロックはノルムが非負実数値として定まることを性質命題の正定値性に依存する。",
    },
    contractedSemanticDependencyOrder: {
      direction: "prerequisite から dependent へ",
      vertices: expConjugationContractedVertices.map(({ name, entryIds }) => ({
        name,
        entryIds: [...entryIds],
      })),
      edges: expConjugationContractedEdges,
      topologicalOrder: expConjugationContractedTopologicalOrder,
      rationale: "Frobenius 内積の不可分単位と交換子の二項展開を先に置き、両方を使う交換子作用・共役作用の定義、その定義と二項展開を使う行列指数共役公式の順に読む。外部入力は各頂点の依存境界に記録し、この5件内部の順序には意味的前提だけを使う。",
    },
    reviewedEntryCount: reviewedExpConjugationToolEntries.length,
    realAnalysisEscapeEntryCount: reviewedExpConjugationToolEntries.filter(
      ({ id }) => expConjugationToolBoundaryById.get(id)?.closure === "実数解析への脱出を伴う",
    ).length,
    finiteComplexMatrixEntryCount: reviewedExpConjugationToolEntries.filter(
      ({ id }) => expConjugationToolBoundaryById.get(id)?.closure === "有限複素行列だけで閉じる",
    ).length,
    isingContaminatedEntryCount: reviewedExpConjugationToolEntries.filter(
      ({ classificationEvidence }) => classificationEvidence.isingSemanticMatches.length > 0,
    ).length,
    mathematicalToolsFirstIncompatibleDependencyCount: expConjugationLaterChapterDependencies.length,
    mathematicalToolsFirstIncompatibleDependencies: expConjugationLaterChapterDependencies,
    highSchoolReadableEntryCount: reviewedExpConjugationToolEntries.length,
    semanticExclusionFingerprintCount: configuredExpConjugationFingerprints.size,
    topologyReviewedContentFingerprintCount:
      expConjugationTopologyReviewedContentFingerprintById.size,
    classificationRule: "交換子と共役の有限代数だけで閉じるものと、実数値ノルム・極限・完備性・指数級数を直接または依存先経由で使うものを分ける。イジング固有語彙を含まないものを数学的道具立てに置き、数学的道具立てから後章への意味的前提依存が0件であることを二章配置の適合条件として検査する。",
    reviewedEntryIds: reviewedExpConjugationToolEntries.map(({ id }) => id),
  },
  realAnalysisDependencySources: [...directRealAnalysisInputsById]
    .map(([id, directInputs]) => ({
      id,
      labels: [...(baseEntryById.get(id)?.labels ?? [])],
      reviewedCalculationFormula: reviewedCalculationFormulaIds.has(id),
      reviewedAnalyticMatrixTool: configuredAnalyticMatrixToolIds.has(id),
      reviewedMatrixExponentialTool: configuredMatrixExponentialToolIds.has(id),
      reviewedExpConjugationTool: configuredExpConjugationToolIds.has(id),
      directInputs,
    }))
    .sort((left, right) => left.id.localeCompare(right.id)),
  entries,
  dependencySupportNodes,
};

mkdirSync(dirname(outputPath), { recursive: true });
writeFileSync(outputPath, `${JSON.stringify(inventory, null, 2)}\n`);
console.log(`wrote ${entries.length} entries to ${outputPath}`);
