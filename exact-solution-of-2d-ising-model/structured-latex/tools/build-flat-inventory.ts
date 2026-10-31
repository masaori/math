/**
 * 複素行列版の本文 `content/` の全 definition・claim・theorem を棚卸しし、
 * `docs/organization/flat-inventory.json` へ書き出す。
 *
 * 棚卸しが決めるもの:
 * - 各項目が「数学的道具立て」か「2次元イジングモデル」か（イジング模型を参照せずに定義・主張できるか）。
 * - 各項目の依存（本文の参照と、記号の使用から導く意味的な前提）。
 * - イジング側の各項目が、承認済みの章立て（`chapter-plan.ts`）のどの章に入るか。章の順に、各章のゴールの
 *   ブロックから依存閉包を取り、まだどの章にも入っていない項をその章へ入れる。したがって各章は、
 *   それより前の章と数学的道具立てだけを使う。どの章のゴールからも辿れない項は、どの章にも入れない。
 * - 各章の項目を、章の中の依存順（同順位は本文の現在の並び）に並べた列と、本文でその章の見出しの下に
 *   既に置かれている項目。
 */
import { createHash } from "node:crypto";
import { mkdirSync, writeFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";
import { mathematicalToolPartTitle, plannedParts } from "./chapter-plan.ts";
import { loadContentFiles, TRAILING_CONTENT_FILES } from "./content-modules.ts";

const classifications = ["数学的道具立て", "2次元イジングモデル"] as const;
type Classification = typeof classifications[number];


const projectDir = join(dirname(fileURLToPath(import.meta.url)), "..", "..");
const outputPath = join(projectDir, "docs", "organization", "flat-inventory.json");
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
  "TV1_hatZ_hatY_015_claim_linearity_of_T",
  "transfer_matrix_005_definition_end_isomorphism",
  "transfer_matrix_005b_claim_end_is_algebra_isomorphism",
  "transfer_matrix_005c_claim_end_preserves_matrix_exponential",
  "transfer_matrix_claim_end_acts_on_kronecker_products",
]);
const nonPrerequisiteReferenceLabelsById = new Map<string, Set<string>>([
  ["calc_formulae_006_definition_of_cc", new Set(["abs_basic_properties", "matrix_exp_series_converges"])],
  ["linear_space_general_000_definition_kronecker_product", new Set(["kronecker_product_rule", "tensor_basis"])],
  ["transfer_matrix_003_claim_V1_in_Z_Y_epsilon", new Set(["theorem_exp_product"])],
]);
const explicitSemanticPrerequisiteLabelsById = new Map<string, Set<string>>([
  // 数式内の\\crefにある根拠を、意味的な直接入力として保持する。
  ["closing_010_theorem_onsager_exact_solution", new Set(["epsilon_commutes_with_W", "def_sector_rayleigh_sup"])],
  ["partition_function_2d_ising_004_claim_partition_function_via_transfer_matrix", new Set(["theorem_exp_product"])],
  ["Z_Y_anticommutation_000a_claim_pauli_matrix_products", new Set(["mat_mult"])],
  ["calc_formulae_004_action_on_matrix_pair", new Set(["mat_mult"])],
  ["maxeig_009_claim_partition_function_sandwich", new Set(["Z_equals_trace_of_W", "trace_power_sandwich"])],
  ["maxeig_008_claim_trace_power_sandwich", new Set(["moment_log_convexity", "psd_cauchy_schwarz"])],
  ["maxeig_007_claim_operator_bound", new Set(["def_matrix_norm", "psd_cauchy_schwarz", "def_rayleigh_sup"])],
  ["maxeig_006_definition_rayleigh_sup", new Set(["def_matrix_norm"])],
  ["maxeig_003_claim_W_is_positive_definite", new Set(["def_symmetrized_transfer_matrix"])],
  ["closing_005_claim_open_chain_spin_sums_positive", new Set(["cosh_sinh_basic_properties"])],
  ["Z_Y_anticommutation_000b_claim_tensor_anticommutation_single_site", new Set(["kronecker_product_rule", "kronecker_multilinear"])],
  ["exp_conjugation_proof_010_theorem_matrix_exp_conjugation", new Set(["theorem_exp_product", "theorem_exp_zero"])],
  ["evensectorT_claim_V1_plus_half_invertible", new Set(["matrix_exp_conjugation"])],
  ["bridge_claim_V1_pm_square_root_squares_to_V1_pm", new Set(["def_V1_plus", "theorem_exp_product"])],
  ["evenEigen_002_claim_check_number_operator_idempotent", new Set([
    "anticommutator_of_check_psi",
    "def_check_number_operator",
  ])],
]);
const forwardNavigationReviewById = new Map<string, Map<string, string>>([
  ["calculation_formulae_definition_set_and_algebra_notation", new Map([["definition_of_cc", "既存の複素数定義への案内"]])],
  ["calc_formulae_006_definition_of_cc", new Map([["abs_basic_properties", "後続利用への案内"], ["matrix_exp_series_converges", "後続利用への案内"]])],
  ["freeenergy_002_claim_gamma_is_continuous", new Map([["riemann_sum_to_integral", "後続利用への案内"]])],
  ["evenEigen_004_claim_trace_of_check_number_operator_product", new Map([["check_joint_eigenspace_decomposition", "後続対応への案内"]])],
  // 「二乗が V_1^{(+)} に等しいことは〜で示す」という、直後の主張への案内の一文。定義の中身は exp(iK_1H_1^{(+)}/2) で閉じている。
  ["bridge_definition_V1_pm_square_root", new Map([["V1_plus_square_root_property", "後続帰結への案内"]])],
  ["evenEigen_006_claim_eigenvalues_of_check_Vprime", new Map([["max_eigenvalue_of_V_plus_simple", "後続帰結への案内"]])],
  ["closing_002_claim_epsilon_eigenvalue_on_check_Q", new Map([["max_eigenvector_in_even_sector", "後続利用への案内"], ["trace_of_epsilon_V_plus", "後続の符号決定への案内"]])],
]);
const forwardPrerequisiteLabelsById = new Map<string, Set<string>>([
  ["exp_linear_map_003_theorem_exp_product_formula_commuting_matrices", new Set(["ad_binomial"])],
  ["exp_conjugation_proof_003b_claim_frobenius_inner_product_axioms", new Set(["def_hermitian_positive_definite", "def_trace"])],
  ["exp_conjugation_proof_003_definition_M_n_C_convergence", new Set(["def_hermitian_positive_definite", "def_trace"])],
  // 行列の積の定義は成分が複素数であることを前提にする。複素数の定義は本文では後ろに置かれているが、
  // 依存順では先行する（提示順と依存順が食い違う箇所であり、案内ではなく前提である）。
  ["calc_formulae_003_matrix_decomposition", new Set(["definition_of_cc"])],
]);
const manualGranularityReviewById = new Map<string, string>([
  ["TV1_hatZ_hatY_004_claim_sinh_cosh_taylor", "LLMによる検証: x の実数所属と双曲線正弦・余弦の定義への参照を補ったが、二つの級数等式には証明が全くない。添字 n の所属集合が明示されず、階乗と無限和の定義も入力に無いため、主張自体の定義可能性も未完である。実指数関数の級数表示と全実数での収束、正負の引数の級数を偶数次・奇数次へ分ける有限部分和と極限の議論、和と差を2で割る計算、二等式の主張分割と各行参照が未完である。対象にラベルがなく参照数も零だが、後続のテイラー係数抽出はこの展開を四回適用しても依存未接続であり、転送行列の橋渡しは展開を別の双曲線関数の主張へ誤帰属し、偶セクターの作用はラベル欠落のため式を再掲したと記録している。零の引数を含め、ラベル・下流依存・必要な定義と証明を補った後に依存と閉包を再判定する。"],
  ["TV1_hatZ_hatY_009_definition_invertible_elements", "LLMによる検証: M>=1 の所属と、行列積・複素係数の演算への参照を補った。可逆元・逆元・可逆元全体の定義、逆元一意性と四つの性質が同居する。行列積の結合律と単位元の具体的根拠、複素数の逆元の適用、有限行列の二箇所への同時代入、各行参照と主張分割が未解決である。逆元一意性の五段の計算と積の両側逆元、M>=1 を保持し、前提補完と分割後に依存と閉包を再判定する。"],
  ["linear_space_general_004_lemma_centralizer_is_scalar", "LLMによる検証: 行列積と複素係数の演算への参照を補った。行列単位の定義と積公式・単位行列の展開を経て、可換性から係数を比較する。生成族の元数と次元から基底を結論する前提は既存の基底入力でも未証明であり、本項の2次の場合にも適用根拠が必要である。多重添字の有限和への分配・各因子への反復適用、二箇所の同時代入と係数比較の各行参照の分割が未解決である。M=1を保持し、前提補完と分割後に依存と閉包を再判定する。"],
  ["maxeig_005_claim_psd_cauchy_schwarz", "LLMによる検証: 行列積と実数包含への参照を補った。一般のn次とn×1の数ベクトルの通常転置の定義および演算法則は未提示であり、既存の2の冪次の転置だけでは適用範囲を満たさない。実行列の演算を複素成分の式へ接続する根拠、二次式への展開での分配と転置の同時適用、対称性から交叉項が等しいことの成分計算、実数の四則演算の分割と各行参照が未解決である。a>0とa=0の双方の計算とb=0への背理法は実在し、半正定値性からa>=0を得て場合を尽くす説明を補い、前提補完と分割後に依存と閉包を再判定する。"],
  ["transfer_matrix_005_definition_end_isomorphism", "LLMによる検証: 数ベクトル空間・標準基底・行列単位・多重添字基底と、それらから基底上の値を指定して二つの線型写像を定める定義群が同居する。End(F) を F 上の C-線型自己写像全体として定める説明、基底上の値から線型写像を一意に拡張できる根拠、有限基底による展開と線型性への接続、定義群の分割と各行参照が未解決である。ここでの行列作用は通常の行列積を追加入力にせず、定義した end(A)(f) を意味する。前提補完と分割後に依存と閉包を再判定する。"],

  ["exp_conjugation_proof_010_theorem_matrix_exp_conjugation", "LLMによる検証: 成分積・複素演算・実数包含・劣乗法性への明示参照を補った。級数収束・共役公式・正則性の三群の主張と部分和や添字集合・ノルム評価の補題が同居する。零次を含む四場合と添字全単射の逆写像、両側の逆元積は本文に実在する。有限和と二箇所の同時代入、実数列の有界性・部分列・極限法則の前提、符号付き冪と成分演算への適用行参照の分割が未解決であり、前提補完と分割後に依存と閉包を再判定する。"],

  ["exp_linear_map_003_theorem_exp_product_formula_commuting_matrices", "LLMによる検証: 行列積・複素演算・実数包含・非負平方根と、二項係数の定義およびPascalの関係式を示す反復交換子の準備への参照を補った。可換な冪と二項展開、有限添字集合の比較と剰余評価、二つの因子が変わる積の収束を一項に含む。Pascalの計算は参照先に存在し、必要な補題としての分離と適用行の参照が未整備である。有限和の展開・添字全単射・両箇所の同時代入、実数の平方根比較と極限法則、成分演算法則への接続と各行参照を未解決に記録する。零次と零のノルム、N=0で空となる添字範囲は本文にある規約を保ち、前提補完と分割後に依存と閉包を再判定する。"],
  ["bridge_003_claim_exp_of_diagonal", "LLMによる検証: 行列積・複素演算・実数包含・非負平方根への参照を補った。複素成分d_kに非負実数の指数級数の定理を適用しており、その定理だけでは複素数の指数e^{d_k}の定義と収束を与えない。この定義・証明の接続は未完である。非対角成分について「左側が常に0」は差の絶対値を指すなら不正確で、部分和の非対角成分が0であることと極限からの結論を区別する必要がある。成分冪の定義と帰納法、有限線型結合と非負平方比較、同時適用と各行参照の分割も未解決であり、零成分と零次を保って補完後に依存と閉包を再判定する。"],
  ["exp_linear_map_002_definition_exp_of_endomorphism", "LLMによる検証: 行列積と実数係数の包含への参照を補った。行列の冪と指数、線型写像の反復と指数の定義が同居する。冪の再帰は本項に実在するが先行する収束証明より前への提示が必要である。実行列と複素行列の成分演算の接続、入力の実数完備性と極限法則、定義群の分割と各行参照が未解決であり、零次と零の引数を保ち、補完後に依存と閉包を再判定する。"],
  ["eigenvalues_of_V_013_claim_exp_hermitian_positive_definite", "LLMによる検証: 指数定義・可換指数積・零行列指数と、成分計算で使う共役・ノルム・絶対値・実数包含・トレースへの欠落参照を補った。指数の正定値性と合同変換・正の定数倍・トレースの四主張が同居する。矩形行列への共役転置の定義と積公式の適用範囲は未整備であり、片側の逆元積だけから可逆性を結論する段階、可逆行列が非零ベクトルを非零へ送る根拠、複素数と正の実数の包含の区別、共役転置の対合性と有限和・冪の帰納、同時適用と各行参照が未解決である。定義と証明の前提を補完し分割した後に依存と閉包を再判定する。"],

  ["exp_linear_map_000b_claim_matrix_exp_series_converges", "LLMによる検証: 行列積と実数係数の包含への参照を補った。部分和・上界の定義と収束・評価の二主張、冪の評価の帰納法が同居する。行列冪の再帰は後続の指数定義に存在し、収束証明の前へ分離する必要がある。零次と正次数の分離は本文に明示済みである。上限から単調列収束への前提、有限回の三角不等式、N=0で正次数の和が空となる場合への適用説明、同時適用と各行参照が未解決であり、零行列と零次の項を保って補完・分割後に依存と閉包を再判定する。"],
  ["exp_linear_map_001_theorem_exp_series_pointwise_converges", "LLMによる検証: 行列積・非負平方根・実数係数の包含への参照を補った。作用と成分の収束、線型写像の評価・反復・級数収束・極限の線型性の六群の主張に、行列単位・上界・写像と反復の定義が同居する。行列の冪の再帰の提示順、有限和への線型性の帰納、添字写像の全単射の根拠、実数列の単調収束と極限法則、同時適用と各行参照が未解決である。零の上界と零次の反復を保持し、前提補完と分割後に依存と閉包を再判定する。"],

  ["linear_space_general_003d_claim_matrix_completeness", "LLMによる検証: Cauchy列の定義、完備性、絶対収束判定と級数のノルム評価が同居する。成分のCauchy列から行列の極限を構成する証明は存在するが、実数のCauchy完備性と極限法則の前提、有限回の三角不等式の帰納、N>Mから全添字への場合分けと各行参照の説明が未解決である。前提補完と分割後に依存と閉包を再判定する。"],
  ["linear_space_general_003b_claim_matrix_multiplication_continuity", "LLMによる検証: 行列列の所属とノルム・行列積・劣乗法性の参照を補った。主張は右因子を固定した乗算の連続性に限る。分配則を成分計算へ接続する根拠、非負性と実数列の定数倍・挟み撃ちの極限法則、各行参照が未解決である。前提補完と分割後に依存と閉包を再判定する。"],
  ["linear_space_general_003c_claim_matrix_norm_vector_bound", "LLMによる検証: 行列積・ノルム基本性質の零の絶対値・劣乗法性への欠落参照を補った。数ベクトルを第一列に置いた行列のノルムと数ベクトルのノルムを対応させる計算は存在する。行列と数ベクトルの積への定義適用、零の列を有限和から除く計算、各行参照が未解決である。n=1の第二列以降が空の範囲を保持し、前提補完と分割後に依存と閉包を再判定する。"],

  ["linear_space_general_003_claim_matrix_norm_submultiplicativity", "LLMによる検証: 行列積と非負平方根の参照を補った。三角不等式と有限列のCauchy–Schwarzを使う成分評価から平方和の評価へ進む。実行列の成分積と複素行列として定めた積の接続、有限和の分解・添字変更・平方根の性質の同時適用と各行参照が未解決である。有限和の三角不等式の帰納法は現存し、前提補完と分割後に依存と閉包を再判定する。"],
  ["linear_space_general_002c_claim_matrix_norm_triangle_inequality", "LLMによる検証: 四主張と非負平方の比較・包含写像の和と積の計算・有限列のCauchy--Schwarzの補題が同居する。有限和の零の議論、実数列の極限法則、数ベクトルの同様計算、二箇所同時適用・複数法則の同時適用と各行参照が未解決である。極限一意性の証明、包含写像の和と積の計算、Cauchy--Schwarzの零の場合の分岐は存在し、欠落とは扱わない。前提補完と分割後に依存と閉包を再判定する。"],
  ["exp_conjugation_proof_005_definition_ad_X_Ad_g_matrix", "LLMによる検証: 行列積の欠落参照を補った。内積定義から使うのは行列空間の表記だけであり、内積の値や性質は使わない。交換子写像・反復の再帰・正則性・共役写像の定義と逆行列一意性の証明が同居する。行列の和・差・単位行列、積の結合律と単位元の法則を具体的成分計算へ接続する根拠、各行参照が未解決であり、前提補完と分割後に依存と閉包を再判定する。"],
  ["exp_conjugation_proof_003_definition_M_n_C_convergence", "LLMによる検証: 内積の式に使う行列積の参照と後続の性質への案内を訂正した。行列空間の表記、二変数関数の定義、その関数が内積の性質を満たすという後続主張、既出ノルムとの一致への接続を分ける必要がある。共役転置とノルムの入力に残る未整備の定義と説明は解消済みとは扱わず、前提補完と分割後に依存と閉包を再判定する。"],
  ["eigenvalues_of_V_012_claim_star_is_norm_preserving", "LLMによる検証: 複素共役の和・積保存を行列共役へ誤参照していた箇所を、既存のFrobenius内積の性質の証明冒頭へ訂正し、その後へ依存順を移した。スカラーと行列列の所属、共役転置・複素共役・行列積・複素演算・絶対値の参照を補った。積と共役線型性、ノルム保存と極限保存の分割、有限和への帰納、第二式の同様計算、絶対値の成分式へ共役を代入する計算、添字の範囲、二箇所同時適用と各行参照が未解決である。前提補完と分割後に依存と閉包を再判定する。"],
  ["exp_conjugation_proof_003b_claim_frobenius_inner_product_axioms", "LLMによる検証: 証明冒頭には複素共役の和・積保存の成分計算が実在する。成分表示と五群の性質、その前提となる複素数の補題の分割、包含写像の和・積・逆元保存と単射性の根拠への接続、非負実数の像の平方根と実数ノルムの所属を区別する説明、同時代入・複数法則の同時適用と各行参照が未解決である。零の場合を保ち、前提補完と分割後に依存と閉包を再判定する。"],

  ["linear_space_general_002b_definition_matrix_norm", "LLMによる検証: 実数の包含写像の参照を補った。数ベクトルと行列のノルム、列の収束と極限、無限級数の記法の定義が同居する。実数列の収束・極限法則と成分の差・有限和の前提が未整備である。極限の一意性は後続のノルムの基本性質で証明しているが、定義時点ではその証明への接続が未提示であり、級数の値の一意性への接続も含め補完と分割後に依存と閉包を再判定する。絶対値の定義とその入力に残る未完も解消済みとは扱わない。"],
  ["linear_space_general_002_claim_scalar_identity_commutes", "LLMによる検証: 任意の体という記述を複素行列へ具体化し、行列積・交換子・成分の複素演算法則の参照を補った。成分ごとの和・スカラー倍・単位行列の定義と積の法則、二箇所への同時適用の分離、各行参照が未解決であり、前提補完と分割後に依存と閉包を再判定する。"],
  ["linear_space_general_001_theorem_tensor_product_basis", "LLMによる検証: 生成に関する包含の向きを逆に述べた説明を訂正した。三主張と次元・行列単位等の定義の分割、有限次元の生成族の元数の下限という未証明の一般命題を具体的複素行列へ接続する根拠、有限展開の帰納法、数ベクトルの場合の同様計算と各行参照が未解決である。前提補完と分割後に依存と閉包を再判定する。"],
  ["linear_space_general_000d_claim_kronecker_transpose", "LLMによる検証: 転置の定義とクロネッカー積の転置公式が同居しており、定義と主張への分割が未解決である。任意のM≥1の各サイズでの転置の定義の適用、定義を使う各行の参照を明示し、分割後に依存と閉包を再判定する。"],
  ["linear_space_general_000b_claim_kronecker_product_rule", "LLMによる検証: 行列積と複素数の演算法則の参照を補った。三主張と多重添字和の補題が同居し、有限和の帰納法、添字変更、二箇所の定義代入、可換律と結合律の同時適用、各行参照の分離が未解決である。M=1と空和・空積の規約を保ち、分割後に依存と閉包を再判定する。"],
  ["linear_space_general_000c_claim_kronecker_multilinear", "LLMによる検証: 複素数の演算法則の参照を補った。行列と数ベクトルの主張およびスカラー倍の特例の分割、成分ごとの和・スカラー倍の定義、積の並べ替えと分配の分離、数ベクトルの同様計算の展開と各行参照が未解決である。M=1の空積を保持し、前提補完と分割後に依存と閉包を再判定する。"],
  ["linear_space_general_000_definition_kronecker_product", "LLMによる検証: 添字集合の元数、写像の値域と全単射、数ベクトルと行列の二定義が同居する。有限集合の議論と有限和の法則、同時代入と複数演算の分離、各行参照が未解決である。M=1と単射証明の末尾の空和を保ち、前提補完と分割後に依存と閉包を再判定する。"],
  ["exp_linear_map_004_theorem_exp_zero_is_identity", "LLMによる検証: 行列サイズと複素成分の所属を明示し、行列積・実数包含・引数1の実数指数級数への参照を補った。零次の分離と正次数の零行列への置換は本文にあるが、冪の計算の帰納、収束級数の初項分離と無限和のスカラー倍・実数極限の前提、各行参照が未解決である。零行列と零次を保持し、前提補完と分割後に依存と閉包を再判定する。"],
  ["freeenergy_004_theorem_riemann_sum_to_integral", "LLMによる検証: イジング固有の導入を外し、一様連続性と積分の基本性質を一般形の外部前提として明示した。それらの本文内の証明、連続度の上限の存在、誤差評価と極限の主張分割、各行参照と複数演算の分離が未解決である。前提補完後に依存と閉包を再判定する。"],
  ["exp_linear_map_000a_claim_real_exp_series_converges", "LLMによる検証: 部分和・極限・剰余の定義と三主張が同居する。Archimedesの原理、等比和、上限から単調列収束と極限が上限になる根拠、極限の差の法則と各行参照が未提示である。零引数もa^0=1の規約で含め、前提補完と分割後に依存と閉包を再判定する。"],
  ["eigenvalues_of_V_011_definition_hermitian_positive_definite", "LLMによる検証: 共役転置・エルミート・正定値・実対称を一項に束ねている。正方行列で定めた共役転置を列ベクトルへ使う長方形への拡張、実対称の等式と正の実数を実数包含から説明する段、通常転置の記号導入、定義分割が未解決であり、補完後に依存と閉包を再判定する。"],
  ["exp_conjugation_proof_004_theorem_ad_binomial", "LLMによる検証: 交換子と二項係数の定義、符号の処理、Pascalの法則、帰納証明が同居している。正整数冪の定義と行列演算法則の根拠、符号の帰納法の展開、複数の分配律・結合律・スカラーの可換性の同時適用と二箇所への代入、各行参照と主張分割が未解決である。"],
  ["eigenvalues_of_V_002_claim_trace_properties", "LLMによる検証: 四主張の分割、線型性の成分計算と有限和の順序交換を正当化する帰納法、和の交換と複素積の交換を同時適用する段の分離、各行参照が未解決である。"],
  ["eigenvalues_of_V_003_claim_trace_of_idempotent", "LLMによる検証: 像・核の部分空間性、基底の存在と個数、直和から基底を連結する根拠、基底変換行列の可逆性と表現行列の式が未提示である。零次元の像または核を含め、一般語彙を具体的複素行列の計算へ接続する前提不足であり、説明粒度だけの不足としない。直和分解とトレースの主張分割、各行参照と前提補完後に依存と閉包を再判定する。"],
  ["critical_009_claim_closed_form_log_integral", "LLMによる検証: 三つの積分・対数評価の分割、対数の定義と法則、平方根の積商法則、合成微分の分解と各行参照が未解決である。積分の基本定理等を一般形で切り出す必要があり、解析前提の補完後に分類・依存・配置を再判定する。"],
  ["critical_010_claim_sine_integral_two_sided", "LLMによる検証: 積分の定義可能性と両側評価の分割、c0の正値性とBの数値根拠、複数の不等式と演算の分解・各行参照が未解決である。p=0の分岐を維持し、正のpだけで分母を評価する。有界差を定数差と述べた表現は訂正した。積分の一般形の前提と入力の未完事項を補った後に分類・依存・配置を再判定する。"],
  ["critical_008_claim_elementary_sine_bounds", "LLMによる検証: 主張の半角は現行sin/cosの定義域内だが、証明のt≥0全域での使用は定義域を超える。微分公式・零での値・π²の数値区間の根拠と複数不等式の分割が未解決である。R3/R4の積分の性質をイジング導入注記から一般形へ切り出す必要があり、補完後に分類・依存・配置を再判定する。"],
  ["critical_001_claim_cosh_addition_and_half_angle", "LLMによる検証: 五群の主張とarcsinhの定義を同居させ、指数対数の前提、微分規則と各行参照、同様計算の省略が残る。R3/R4の積分の性質はイジング固有の導入注記に混在しており、一般形の解析事実として切り出す必要がある。注記全体を直接入力へ加えず、補完後に分類・依存・配置を再判定する。"],
  ["calculation_formulae_047_claim_commutator_via_anticommutators", "LLMによる検証: 交換子と反交換子の二定義と恒等式を同居させている。結合律・分配則の根拠参照、同時の括弧外しと二箇所への定義代入、零の挿入の演算分解が未解決である。定義と主張を分割した後に依存と閉包を再判定する。"],
  ["calculation_formulae_046_claim_conjugation_is_ring_homomorphism", "LLMによる検証: 乗法性・単位性・合成則と積の逆元公式を一項へ束ねている。加法保存は先行の行列共役にあるが、環準同型という題への接続説明は本項にない。行列の結合律・単位元・逆元一意性の根拠と各適用行の参照が未解決であり、分割後に配置を再判定する。"],
  ["calculation_formulae_044_claim_reciprocal_of_sqrt", "LLMによる検証: 未完の平方根定義と逆数平方根の証明への依存が残る。参照先の準備から非零性を取り出す説明、各行参照と二重負号の根拠が未解決である。"],
  ["calculation_formulae_045_theorem_euler_formula_cos_sin", "LLMによる検証: 現行sin/cosは主値区間のみであり全実数上の定義が不足する。複素指数の意味付け、Euler公式自体の導出、偶奇性が未整備で、定義と証明の未完である。二等式の分割と各行参照も残る。必要な定義と公式の追加後に依存と配置を再判定する。"],
  ["calculation_formulae_041_claim_sqrt_squared_is_original", "LLMによる検証: 未完の平方根定義・極座標展開と同型性を入力にするため証明完成とは扱わない。展開式を二箇所へ同時適用する段と実数の和の計算の省略、各適用行の参照が未解決である。"],
  ["calculation_formulae_042_claim_square_of_sqrt", "LLMによる検証: 交換条件と二乗復元を合流させる場合分けだが、両入力に定義・証明の未完が及ぶ。各適用行のラベル、二重負号と積の符号の根拠の明示が未解決である。"],
  ["calculation_formulae_043_claim_sqrt_of_reciprocal", "LLMによる検証: 未完の平方根定義と交換条件・二乗復元・逆数の偏角を使うため証明完成とは扱わない。sqrt(z)の非零性とsqrt(1)=1の計算を一項へ束ね、arctan(0)=0・sin(0)=0・cos(0)=1の根拠の導出、各行参照、同時代入と複数演算の分解が未解決である。"],
  ["calculation_formulae_039_claim_sqrt_expansion_via_polar", "LLMによる検証: 代表元独立性と半径零・正の展開を一項へ束ねている。入力の平方根写像と逆方向写像が定義未完であり、本項も完成とは扱わない。二条件の同時代入、複数演算の混在、各行ラベル不足、主張分割が未解決である。"],
  ["calculation_formulae_040_claim_sqrt_commutativity_condition", "LLMによる検証: 未完の平方根写像・同型性と未整備の三角関数加法定理・π移動公式に依存し、証明は未完である。r_iとθ_iの所属と選び方を導入せずに使い、零の場合ではn_1をn_iの導入より先に使う。非負平方根の積法則の証明、複数演算の分解、同様の計算の省略、適用行の参照も未解決である。"],
  ["calculation_formulae_038_definition_sqrt_of_complex_number", "LLMによる検証: 半角は[0,π)に入り、現行sin/cosの主値区間を超える。逆方向写像の定義が未完であるため平方根写像の定義自体も未完であり、説明粒度だけの不足とは扱わない。定義域の補完と合成写像の妥当性の説明後に依存と閉包を再判定する。"],
  ["calculation_formulae_036_claim_arg_of_reciprocal", "LLMによる検証: 逆数の定義に非零仮定が必要である。未完の同型性を使う逆写像の積・単位元保存から逆元保存を導いており、証明完成とは扱わない。一般論の具体計算への展開、各行のラベルと複数の実数演算の分解が未解決である。"],
  ["calculation_formulae_035_claim_arg_of_square", "LLMによる検証: 零の場合を分けているので非零仮定は不要である。一方、未完の同型性を使う積保存に依存するため証明完成とは扱わない。逆写像の一般論の具体化、各適用行の参照、複数演算を一段にまとめた箇所の展開が未解決である。"],
  ["calculation_formulae_034_claim_range_of_args_when_product_arg_is_pi", "LLMによる検証: 未完の同型性に依存する積の偏角公式を入力に使うため、本文完成とは扱わない。場合分けの固定整数の説明は明示されているが、複数の実数演算の同時適用と各行のラベル不足は未解決である。"],
  ["calculation_formulae_033_claim_arg_of_quotient", "LLMによる検証: 未完の同型性を入力として逆写像の積保存と単位元保存を使うため、証明は未完の入力に依存する。準同型の逆写像という一般論を具体計算へ展開すること、逆元保存の適用行の参照と実数演算の分解が未解決である。"],
  ["calculation_formulae_031_definition_abs_arg", "LLMによる検証: 絶対値と偏角の二定義を一項へ束ねている。写像・射影・角度切断への参照を補ったが、二定義への分割と合成写像の値域の説明は未解決である。"],
  ["calculation_formulae_031b_claim_abs_basic_properties", "LLMによる検証: 六つの性質に平方比較・Lagrange恒等式・二成分の不等式が同居し、第一射影の代表元独立性もここで初めて示す。主張分割と妥当性の提示順、各適用行の参照、複数演算の同時適用が未解決である。加法を体の項で定めたとする文は、先行の複素数定義が既に加法を持つ現状に合わせる必要がある。成分計算は逆方向写像と未完の同型性を使わない。"],
  ["calculation_formulae_032_claim_arg_of_product", "LLMによる検証: 未完の同型性から逆写像の積保存を使うため、この証明も未完の入力に依存している。抽象的な準同型の逆写像の議論を具体計算へ展開することと、各適用行の参照、複数演算の同時適用が未解決である。"],
  ["calculation_formulae_028_definition_phi_cartesian", "LLMによる検証: 正弦・余弦の現行定義域は主値区間のみであり、任意の角度を代入する写像定義は未完である。全実数上への拡張、周期性、半径零と正を分けた代表元独立性が不足する。説明粒度だけの問題とは扱わず、定義追加後に内部依存と節の閉包を再判定する。"],
  ["calculation_formulae_029_claim_isomorphism_of_phi_cartesian", "LLMによる検証: 全実数上の三角関数、加法定理、周期性、π移動公式が未整備であり、積保存の証明は未完である。一方向の合成が恒等であることだけでは単射性は導けず、全単射の証明も未完である。極座標側の加法を定義していないため、体として同型という原稿TODOは現状の目標にできない。積保存と全単射の主張分割、定義・補題追加後に内部依存と閉包を再判定する。"],
  ["calculation_formulae_030_definition_first_and_second_projections", "LLMによる検証: 半径と角度同値類への二つの射影を一項に束ねている。半径零と正の場合を分けた代表元独立性の説明と二定義の分割が未解決である。"],
  ["calculation_formulae_024_claim_multiplicative_group_of_complex_numbers", "LLMによる検証: 非零複素数の乗法群と商の記法を一項へ束ね、分配律と結合律を同時適用して同じ定理と説明する段、一般集合 S の逆元一意性、適用行のラベル不足がある。複素数の成分計算への統一と主張分割は未解決である。"],
  ["calculation_formulae_025_claim_complex_numbers_form_a_field", "LLMによる検証: 加法の諸性質、分配律、単位元の相違、乗法逆元を一項に束ね、複数演算をまとめた段と行末ラベル不足がある。成分加法を未定義扱いした旧説明は現行の定義に合わせたが、本文の主張分割と各段の展開は未解決である。"],
  ["calculation_formulae_022_definition_operations_on_polar_representation", "LLMによる検証: 代表元から演算を定めた際の代表元独立性は後続の乗法群の主張で初めて示している。定義と妥当性の提示の整備が未解決である。"],
  ["calculation_formulae_023_claim_multiplicative_group_of_polar_representation", "LLMによる検証: モノイド性・非零部分の群・逆元公式を一項に束ね、一般集合 S の逆元一意性を挿入し、各適用行のラベルが不足する。半径と角度の対の具体的計算への統一と主張の分割は未解決である。"],
  ["calc_formulae_015_claim_cos_arctan_sin_arctan", "LLMによる検証: 逆正接の正弦と余弦の二等式を一項に束ね、適用行ごとの定義ラベルと平方根の商の根拠が不足している。構造だけを確定し、主張の分割と一ステップ一定理の説明は未解決とする。"],
  ["calc_formulae_012_definition_arc_length", "LLMによる検証: 円弧長の存在一意性を外部文献の命題番号だけで指定し、その条件と内容を本文内で説明していない。構造だけを確定し、外部文献の内容の本文内説明は未解決とする。"],
  ["calc_formulae_012b_claim_radial_normalization_exists_unique", "LLMによる検証: 正規化の存在一意性の証明は平方根と単位円の根拠を適用行ごとのラベルで引かず、実数の四則として複数の演算を一行へまとめている。節配置だけを確定し、本文の一ステップ一定理への展開は未解決である。"],
  ["calc_formulae_016_definition_angle_equivalence_class", "LLMによる検証: 商集合を定める前提となる反射性・対称性・推移性について、整数 0・-n・n+m を用いる根拠の説明が未整備である。節構造だけを確定し本文完成とは扱わない。"],
  ["calc_formulae_019_definition_polar_equivalence_class", "LLMによる検証: 半径零と正の場合を分けた反射性・対称性・推移性の説明、および同値類から商集合を作る説明が未整備である。外部入力の角度同値関係にも同じ不足がある。節構造だけを確定し本文完成とは扱わない。"],
  ["calc_formulae_014b_claim_arcsin_bijection", "円弧長に関する外部命題の証明を本文内の一ステップ一定理へ展開する余地がある。分類境界と依存順は確定している。"],
  ["transfer_matrix_001_definition_symbols", "独立した数学内容はすべて先行項へ分離済みであり、残余ブロックは旧ラベルを使う後続参照の意味を保つための参照規約と、扱う対象が具体的な有限複素行列であることの確認だけを担う。参照先が多いため自動の説明粒度判定には適合しないが、複数の定義・主張を同居させてはいないため、追加分割は不要である。"],
]);
const futureBlockSplitRecommendedById = new Set<string>();
const presentationPredecessorEntryIdsById = new Map<string, string[]>([
  ["transfer_matrix_000g_definition_positive_coupling_tanh", ["transfer_matrix_000f_claim_global_spin_flip_jordan_wigner_representation"]],
  ["transfer_matrix_000h_definition_real_logarithm_positive", ["transfer_matrix_000g_definition_positive_coupling_tanh"]],
  ["transfer_matrix_000i_definition_first_dual_coupling_constant", ["transfer_matrix_000h_definition_real_logarithm_positive"]],
  ["transfer_matrix_000j_claim_first_dual_coupling_relation", ["transfer_matrix_000i_definition_first_dual_coupling_constant"]],
  ["transfer_matrix_000k_definition_second_dual_coupling_constant", ["transfer_matrix_000j_claim_first_dual_coupling_relation"]],
  ["transfer_matrix_000l_claim_second_dual_coupling_relation", ["transfer_matrix_000k_definition_second_dual_coupling_constant"]],
  ["transfer_matrix_000m_definition_indexed_hyperbolic_abbreviations", ["transfer_matrix_000l_claim_second_dual_coupling_relation"]],
  ["transfer_matrix_000n_claim_indexed_hyperbolic_abbreviations_positive", ["transfer_matrix_000m_definition_indexed_hyperbolic_abbreviations"]],
  ["transfer_matrix_001_definition_symbols", ["transfer_matrix_000n_claim_indexed_hyperbolic_abbreviations_positive"]],
  ["transfer_matrix_004_definition_eigenspace_even_of_epsilon", ["transfer_matrix_003a_claim_V2_in_Z_Y"]],
  ["transfer_matrix_004_claim_even_eigenspace_is_complex_subspace", ["transfer_matrix_004_definition_eigenspace_even_of_epsilon"]],
  ["transfer_matrix_004_definition_eigenspaces_of_epsilon", ["transfer_matrix_004_claim_even_eigenspace_is_complex_subspace"]],
  ["transfer_matrix_004b_claim_epsilon_square_and_eigenvalues", ["transfer_matrix_004_definition_eigenspaces_of_epsilon"]],
  ["transfer_matrix_004c_claim_epsilon_action_eigenvalues", ["transfer_matrix_004b_claim_epsilon_square_and_eigenvalues"]],
  ["bridge_009_claim_epsilon_projector_properties", ["transfer_matrix_004c_claim_epsilon_action_eigenvalues"]],
  ["evensector_003_definition_half_integer_checkY", ["evensector_003_definition_half_integer_checkZ"]],
  ["evensector_003_claim_half_integer_phase_antiperiodicity", ["evensector_003_definition_half_integer_checkY"]],
  ["evensector_003_claim_half_integer_checkZ_periodicity", ["evensector_003_claim_half_integer_phase_antiperiodicity"]],
  ["evensector_003_claim_half_integer_checkY_periodicity", ["evensector_003_claim_half_integer_checkZ_periodicity"]],
  ["evensector_003_definition_half_integer_modes", ["evensector_003_claim_half_integer_checkY_periodicity"]],
  // 旧複合ブロックから切り出した二定義と二つの指数表示は、分割前の本文位置に連続して置く。
  ["transfer_matrix_011a_definition_H1_pm", ["transfer_matrix_009_claim_exp_sum"]],
  ["transfer_matrix_011b_definition_H2", ["transfer_matrix_011a_definition_H1_pm"]],
  ["transfer_matrix_011c_claim_V1_pm_exponential_representation", ["transfer_matrix_011b_definition_H2"]],
  ["transfer_matrix_011d_claim_V2_exponential_representation", ["transfer_matrix_011c_claim_V1_pm_exponential_representation"]],
  ["eigenvalues_of_V_014_claim_iH_is_real_symmetric", ["transfer_matrix_011d_claim_V2_exponential_representation"]],
  ["maxeig_claim_symmetrized_transfer_matrix_on_sectors", ["maxeig_010b_claim_epsilon_commutes_with_W"]],
  // 分割で切り出した二項は、依存関係だけなら章のずっと手前へ移せるが、本文の並びは
  // 分割前と同じ位置に保つ（読む順序を変えないため）。
  ["maxeig_010a_definition_sector_rayleigh_sup", ["maxeig_009_claim_partition_function_sandwich"]],
  ["maxeig_010b_claim_epsilon_commutes_with_W", ["maxeig_010a_definition_sector_rayleigh_sup"]],
  ["closing_definition_D0_open_chain_operator", ["eigenvalues_of_V_016_claim_sign_flip_conjugation"]],
  ["closing_definition_G_boundary_operator", ["closing_definition_D0_open_chain_operator"]],
  ["closing_claim_D0_G_diagonal_action", ["closing_004_claim_H1_plus_in_sigma_z_form"]],
  ["closing_claim_epsilon_D0_G_pairwise_commute", ["closing_claim_D0_G_diagonal_action"]],
  // 整数運動量の経路を本文から外したことで意味的前提を失った項は、外す前の章内依存順で直前にあった
  // 残存項を提示上の直前項に置き、レビュー済みの読む順序を保つ。
  ["evensectorT_007_definition_B1_B2", ["freeenergy_002_claim_gamma_is_continuous"]],
  ["evensector_007_claim_H1_H2_via_check_Z_Y", ["maxeig_010b_claim_epsilon_commutes_with_W"]],
  // 双曲線関数を数の指数関数から定義し直したことで、双曲線関数の節とそれに依存する項は行列の指数関数の
  // 後ろへ移った。移らない項は、移る前の章内依存順で直前にあった残存項を提示上の直前項に置き、
  // レビュー済みの読む順序を保つ。平方根の証明から切り出した主張は本文どおり平方根の直前に置く。
  ["calc_formulae_000c0_claim_positive_real_square_injective", ["calc_formulae_019_definition_polar_equivalence_class"]],
  ["critical_008_claim_elementary_sine_bounds", ["critical_001_claim_cosh_addition_and_half_angle"]],
  // arccosh の定義と性質（未レビュー）は、本文どおり実対数の直後に置く。
  ["transfer_matrix_000h2_definition_arccosh", ["transfer_matrix_000h_definition_real_logarithm_positive"]],
  // V_1, V_2 の成分定義一本化で転送行列記号の要約が両パウリ表示の後ろへ移り、それに依存しない
  // 境界符号の差・指数和・半整数運動量の項が前へ浮く。移る前の章内依存順で直前にあった残存項を
  // 提示上の直前項に置き、レビュー済みの読む順序を保つ。
  // (−) セクターの退避で 010 の可換性の主張が V_1^{(+)} とその平方根を通じて H_1^{(+)} に依存するようになったため、
  // それより前で依存の循環を作らない直前の残存項（V_1^{(+)} の定義）の後に置く。
  ["transfer_matrix_008_definition_delta_M", ["transfer_matrix_007_definition_V1_pm"]],
  // 010 に一本化した V_1^{(+)} の平方根の定義は H_1^{(+)} に依存するようになった。二つの一般生成子と二つの
  // 指数表示の節を分断しないよう、V_2 の指数表示の後に置く。
  ["bridge_definition_V1_pm_square_root", ["transfer_matrix_011d_claim_V2_exponential_representation"]],
  ["maxeig_001_definition_transfer_matrix_square_root", ["critical_002a_definition_critical_sinh_product_A"]],
  ["evensectorT_claim_V1_plus_half_invertible", ["evenEigen_claim_V_plus_inverse_positive_and_traces"]],
  ["evensectorT_claim_V2_invertible", ["evensectorT_claim_V1_plus_half_invertible"]],
  ["evensectorT_claim_V_plus_factors_invertible", ["evensectorT_claim_V2_invertible"]],
  ["evensectorT_006_claim_linearity_of_T", ["evensectorT_claim_V_plus_factors_invertible"]],
  ["evensectorT_006a_claim_linearity_of_T_V2", ["evensectorT_006_claim_linearity_of_T"]],
]);
const isingPattern = /Ising|イジング|spin|スピン|lattice|格子|site|サイト|transfer|転送|sector|セクター|momentum|運動量|fermion|フェルミオン/i;
const abstractPatterns = [
  { name: "リー群", pattern: /Lie\s*group|リー群/i },
  { name: "リー環", pattern: /Lie\s*algebra|リー環/i },
  { name: "抽象テンソル積", pattern: /abstract\s+tensor|抽象テンソル積/i },
  { name: "一般の体・環", pattern: /\\mathbb\{K\}|\bK\s*:=\s*\\mathbb\{(?:R|C)\}|Mat\([^)]*,K\)|任意の体|一般の体|一般の環/i },
  { name: "抽象線型写像", pattern: /\\mathrm\{End\}|線型写像|linear\s+map/i },
  { name: "群の一般論", pattern: /群|group/i },
];

// 参照は ref ノードと、数式の文字列の中の \blkref{ラベル}（出版物で \cref に展開される）の二通りで書かれる。
function collectTargets(value: unknown, targets = new Set<string>()): Set<string> {
  if (typeof value === "string") {
    for (const match of value.matchAll(/\\blkref\{([^}]*)\}/g)) {
      for (const label of match[1]!.split(",")) targets.add(label.trim());
    }
  } else if (Array.isArray(value)) for (const item of value) collectTargets(item, targets);
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
// 設定表が指す項目とラベルは実在しなければならない。改名で消えた名前を黙って無視すると依存の辺が欠ける。
{
  const blockIds = new Set(allBlocks.map(({ block }) => block.id));
  const missing: string[] = [];
  const requireId = (id: string, where: string) => { if (!blockIds.has(id)) missing.push(`${where}: 項目 ${id}`); };
  const requireLabel = (label: string, where: string) => { if (!labelOwners.has(label)) missing.push(`${where}: ラベル ${label}`); };
  for (const id of mathematicalToolEntryIdsOutsideToolFiles) requireId(id, "mathematicalToolEntryIdsOutsideToolFiles");
  for (const [table, map] of [
    ["nonPrerequisiteReferenceLabelsById", nonPrerequisiteReferenceLabelsById],
    ["explicitSemanticPrerequisiteLabelsById", explicitSemanticPrerequisiteLabelsById],
    ["forwardPrerequisiteLabelsById", forwardPrerequisiteLabelsById],
  ] as const) for (const [id, labels] of map) { requireId(id, table); for (const label of labels) requireLabel(label, table); }
  for (const [id, labels] of forwardNavigationReviewById) {
    requireId(id, "forwardNavigationReviewById");
    for (const label of labels.keys()) requireLabel(label, "forwardNavigationReviewById");
  }
  for (const id of manualGranularityReviewById.keys()) requireId(id, "manualGranularityReviewById");
  for (const [id, predecessors] of presentationPredecessorEntryIdsById) {
    requireId(id, "presentationPredecessorEntryIdsById");
    for (const predecessor of predecessors) requireId(predecessor, "presentationPredecessorEntryIdsById");
  }
  for (const label of ["set_and_algebra_notation", "definition_of_cc", "def_H1_plus", "def_H2"]) requireLabel(label, "記号使用から導く意味的前提");
  if (missing.length > 0) throw new Error(`設定表が存在しない項目・ラベルを指しています:\n${missing.join("\n")}`);
}
const titleKey = (title: unknown): string => JSON.stringify(title);
// 本文の各項目が、いまどの章見出し（level 2 の見出し）の下にあるか。level 1 の見出しで章の区切りは切れる。
const enclosingChapterHeadingKeyById = new Map<string, string | null>();
{
  let currentChapterHeadingKey: string | null = null;
  for (const { block } of allBlocks) {
    if (block.kind === "heading" && block.level <= 2) currentChapterHeadingKey = block.level === 2 ? titleKey(block.title) : null;
    enclosingChapterHeadingKeyById.set(block.id, currentChapterHeadingKey);
  }
}
// 章立ての章の見出しの下に組み直し済みの項目か。組み直しの途中では、組み直した章は番号を持つ旧い章のファイルより
// 後ろに置かれる（`TRAILING_CONTENT_FILES`）ので、まだ組み直していない旧い章の項目が組み直し済みの章の項目を指すと、
// 本文の並びでは前方参照になる。これは組み直しの途中にだけ起き、両方を組み直せば消える。
// 判定は、ブロックが `TRAILING_CONTENT_FILES` のファイルにあり、かつ章立ての章の題の見出しの下にあることで行う。
// 章立ての章の題の見出しが旧い章のファイルにあれば、題の一致だけでは組み直し済みと区別できないので落とす。
const plannedChapterTitleKeys = new Set(plannedParts.flatMap((part) => part.chapters.map((chapter) => titleKey(chapter.title))));
const trailingContentFiles: ReadonlySet<string> = new Set(TRAILING_CONTENT_FILES);
{
  const misplaced = allBlocks.filter(({ file, block }) => block.kind === "heading" && block.level === 2
    && plannedChapterTitleKeys.has(titleKey(block.title)) && !trailingContentFiles.has(file));
  if (misplaced.length > 0) {
    throw new Error(`章立ての章の題の見出しが、組み直した章のファイル（TRAILING_CONTENT_FILES）の外にあります: ${
      misplaced.map(({ file, block }) => `${file}: ${block.id}`).join(", ")}`);
  }
}
const fileById = new Map(allBlocks.map(({ file, block }) => [block.id, file]));
const isUnderPlannedChapterHeading = (id: string): boolean => {
  const key = enclosingChapterHeadingKeyById.get(id);
  return trailingContentFiles.has(fileById.get(id)!) && key !== undefined && key !== null && plannedChapterTitleKeys.has(key);
};
const incoming = new Map<string, number>();
for (const { block } of allBlocks) for (const target of collectTargets(block)) incoming.set(target, (incoming.get(target) ?? 0) + 1);

const baseEntries = targetBlocks.map(({ file, block }) => {
  const record = block as unknown as Record<string, unknown>;
  const inspected = JSON.stringify({ title: record.title, statement: record.statement, proof: record.proof });
  const inspectedContentSha256 = createHash("sha256").update(inspected).digest("hex");
  const isingSemanticMatches = [...new Set(inspected.match(isingPattern) ?? [])].sort();
  const abstractVocabularyMatches = abstractPatterns.filter(({ pattern }) => pattern.test(inspected)).map(({ name }) => name);
  const toolCandidate = mathematicalToolFiles.has(file) || mathematicalToolEntryIdsOutsideToolFiles.has(block.id);
  const classification: Classification = toolCandidate && isingSemanticMatches.length === 0
    ? "数学的道具立て" : "2次元イジングモデル";
  const statementReferenceLabels = [...collectTargets(record.statement)].sort();
  const proofReferenceLabels = [...collectTargets(record.proof)].sort();
  const semanticPrerequisiteLabels: string[] = [];
  if (block.id !== "calculation_formulae_definition_set_and_algebra_notation" && /\\mathbb\s*(?:\{[NZR]\}|[NZR])/.test(inspected)) semanticPrerequisiteLabels.push("set_and_algebra_notation");
  if (!["calculation_formulae_definition_set_and_algebra_notation", "calc_formulae_006_definition_of_cc"].includes(block.id) && /\\mathbb\s*\{?C\}?/.test(inspected)) semanticPrerequisiteLabels.push("definition_of_cc");
  if (block.id !== "transfer_matrix_011a_definition_H1_pm" && /H_1/.test(inspected)) {
    semanticPrerequisiteLabels.push("def_H1_plus");
  }
  if (block.id !== "transfer_matrix_011b_definition_H2" && /H_2/.test(inspected)) {
    semanticPrerequisiteLabels.push("def_H2");
  }
  semanticPrerequisiteLabels.push(...(explicitSemanticPrerequisiteLabelsById.get(block.id) ?? []));
  const rawReferenceLabels = [...new Set([...statementReferenceLabels, ...proofReferenceLabels, ...semanticPrerequisiteLabels])].sort();
  const configuredExclusions = nonPrerequisiteReferenceLabelsById.get(block.id) ?? new Set<string>();
  const documentOrderForwardStatementReferenceLabels = statementReferenceLabels.filter((label) => {
    const ownerId = labelOwners.get(label);
    return ownerId !== undefined && blockPositionById.get(ownerId)! > blockPositionById.get(block.id)!;
  });
  // 数学的道具立ての項は最終的に本文の先頭に来るので、そこからの前方参照は組み直しが終わっても消えない。除外しない。
  const interimForwardReferenceLabelsToReorganizedChapters = isUnderPlannedChapterHeading(block.id) || classification === "数学的道具立て"
    ? []
    : documentOrderForwardStatementReferenceLabels.filter((label) => isUnderPlannedChapterHeading(labelOwners.get(label)!));
  const forwardStatementReferenceLabels = documentOrderForwardStatementReferenceLabels
    .filter((label) => !interimForwardReferenceLabelsToReorganizedChapters.includes(label));
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
    sourceOrdinal: block.origin?.ordinal ?? null, classification,
    classificationEvidence: {
      mathematicalToolCandidateFile: mathematicalToolFiles.has(file),
      mathematicalToolCandidateEntry: mathematicalToolEntryIdsOutsideToolFiles.has(block.id),
      incomingReferenceCount: block.labels.reduce((sum, label) => sum + (incoming.get(label) ?? 0), 0),
      isingSemanticMatches,
      rule: "項目ごとの意味レビューで一般的な複素数・行列計算と確認され、内容にイジング固有語彙がなければ数学的道具立て、それ以外は2次元イジングモデル",
      rationale: classification === "数学的道具立て"
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
    interimForwardReferenceLabelsToReorganizedChapters,
    staleForwardReferenceReviewLabels: [...reviewedLabels].filter((label) => !forwardStatementReferenceLabels.includes(label)).sort(),
    blockSplitRequiredBeforeFinalOrdering: forwardStatementReferenceLabels.length > 0 && !forwardReviewMatches,
    futureBlockSplitRecommended: futureBlockSplitRecommendedById.has(block.id),
    presentationPredecessorEntryIds: presentationPredecessorEntryIdsById.get(block.id) ?? [],
  };
});
const entryById = new Map(baseEntries.map((entry) => [entry.id, entry]));
const entryOrderingDependencies = (entryIds: ReadonlySet<string>) => new Map([...entryIds].map((id) => {
  const entry = entryById.get(id)!;
  return [id, [...new Set([...entry.dependsOnEntryIds, ...entry.presentationPredecessorEntryIds])].filter((x) => entryIds.has(x))];
}));
const classificationStructures = classifications.map((classification) => {
  const classifiedEntries = baseEntries.filter((entry) => entry.classification === classification);
  const classifiedIds = new Set(classifiedEntries.map(({ id }) => id));
  const dependencies = entryOrderingDependencies(classifiedIds);
  const ordered = topologicalComponents(stronglyConnectedComponents([...classifiedIds], dependencies), dependencies);
  return {
    classification, entryCount: classifiedEntries.length, dependencyDirection: "prerequisite から dependent へ",
    topologicalOrder: ordered.map((entryIds, i) => ({ order: i + 1, entryIds, inseparableDependencyUnit: entryIds.length > 1 })),
    crossClassificationPrerequisites: classifiedEntries.flatMap((entry) => entry.dependsOnEntryIds
      .filter((id) => entryById.get(id)?.classification !== classification)
      .map((prerequisiteId) => ({ dependentId: entry.id, prerequisiteId }))),
  };
});
const toolStructure = classificationStructures.find(({ classification }) => classification === "数学的道具立て")!;
if (toolStructure.crossClassificationPrerequisites.length > 0) {
  throw new Error(`数学的道具立てが2次元イジングモデルの項を前提にしています: ${JSON.stringify(toolStructure.crossClassificationPrerequisites)}`);
}
const order = new Map<string, { classificationOrder: number; dependencyUnitEntryIds: string[] }>();
for (const structure of classificationStructures) for (const unit of structure.topologicalOrder) for (const id of unit.entryIds) {
  order.set(id, { classificationOrder: unit.order, dependencyUnitEntryIds: unit.entryIds });
}
const staleForwardReferenceReviews = baseEntries.filter((entry) => entry.staleForwardReferenceReviewLabels.length > 0);
if (staleForwardReferenceReviews.length > 0) {
  throw new Error(`前方参照として記録した参照が、本文の並びではもう前方参照ではありません（記録を外す）: ${
    staleForwardReferenceReviews.map(({ id, staleForwardReferenceReviewLabels }) => `${id} -> ${staleForwardReferenceReviewLabels.join(", ")}`).join("; ")}`);
}
const unresolvedBlockSplits = baseEntries.filter((entry) => entry.blockSplitRequiredBeforeFinalOrdering);
if (unresolvedBlockSplits.length > 0) {
  throw new Error(`未レビューの前方参照が残っています: ${unresolvedBlockSplits.map(({ id }) => id).join(", ")}`);
}

const plannedChapters = plannedParts.flatMap((part) => part.chapters.map((chapter) => ({ part: part.title, ...chapter })));
for (const chapter of plannedChapters) {
  const ownerId = labelOwners.get(chapter.organizationGoalLabel);
  const owner = allBlocks.find(({ block }) => block.id === ownerId)?.block;
  if (owner === undefined || !("title" in owner) || titleKey(owner.title) !== titleKey(chapter.title)) {
    throw new Error(`章立ての説明の章のゴールの題が、章立ての題と一致しません: ${chapter.organizationGoalLabel}`);
  }
}
const chapterKeyById = new Map<string, string>();
const goalEntryIdsByChapter = new Map<string, string[]>();
for (const chapter of plannedChapters) {
  const goalEntryIds = chapter.goalLabels.map((label) => {
    const id = labelOwners.get(label);
    if (id === undefined || entryById.get(id)?.classification !== "2次元イジングモデル") {
      throw new Error(`章のゴールのラベルが2次元イジングモデルの項を指していません: ${chapter.organizationGoalLabel}: ${label}`);
    }
    const earlierChapter = chapterKeyById.get(id);
    if (earlierChapter !== undefined) {
      throw new Error(`章のゴールの項が前の章の依存閉包に入っています: ${chapter.organizationGoalLabel}: ${label} は ${earlierChapter}`);
    }
    return id;
  });
  goalEntryIdsByChapter.set(chapter.organizationGoalLabel, goalEntryIds);
  const stack = [...goalEntryIds];
  const closure = new Set<string>();
  while (stack.length > 0) {
    const id = stack.pop()!;
    if (closure.has(id)) continue;
    closure.add(id);
    stack.push(...entryById.get(id)!.dependsOnEntryIds);
  }
  for (const id of closure) {
    if (entryById.get(id)!.classification === "2次元イジングモデル" && !chapterKeyById.has(id)) {
      chapterKeyById.set(id, chapter.organizationGoalLabel);
    }
  }
}
const chapterRank = new Map<string, number>(plannedChapters.map(({ organizationGoalLabel }, rank) => [organizationGoalLabel, rank]));
for (const [id, chapterKey] of chapterKeyById) for (const prerequisiteId of entryById.get(id)!.dependsOnEntryIds) {
  const prerequisiteChapter = chapterKeyById.get(prerequisiteId);
  if (entryById.get(prerequisiteId)!.classification === "2次元イジングモデル"
    && (prerequisiteChapter === undefined || chapterRank.get(prerequisiteChapter)! > chapterRank.get(chapterKey)!)) {
    throw new Error(`章の割り当てに前方参照があります: ${id}（${chapterKey}）が ${prerequisiteId}（${prerequisiteChapter ?? "どの章にもない"}）を使います`);
  }
}

// 依存から外した参照（後続への案内など）のうち、後ろの章かどの章にも入らない項を指すもの。
// 章の割り当てには効かないが、組み直した本文では前方参照になるので、章ごとの組み直しで扱う。
const crossChapterNavigationReferences = [...chapterKeyById].flatMap(([id, chapterKey]) =>
  entryById.get(id)!.referenceLabelsNotUsedAsPrerequisites.flatMap((label) => {
    const targetId = labelOwners.get(label);
    if (targetId === undefined || entryById.get(targetId)?.classification !== "2次元イジングモデル") return [];
    const targetChapter = chapterKeyById.get(targetId);
    if (targetChapter !== undefined && chapterRank.get(targetChapter)! <= chapterRank.get(chapterKey)!) return [];
    return [{ fromEntryId: id, fromChapterKey: chapterKey, label, toEntryId: targetId, toChapterKey: targetChapter ?? null }];
  }));

function orderByDependencyThenPosition(entryIds: ReadonlySet<string>): string[][] {
  const dependencies = entryOrderingDependencies(entryIds);
  const components = stronglyConnectedComponents([...entryIds], dependencies)
    .map((component) => [...component].sort((a, b) => blockPositionById.get(a)! - blockPositionById.get(b)!));
  const owner = new Map<string, number>();
  components.forEach((component, i) => component.forEach((id) => owner.set(id, i)));
  const remaining = new Map(components.map((component, i) => [i, new Set(component.flatMap((id) => dependencies.get(id)!)
    .map((dependency) => owner.get(dependency)!).filter((dependency) => dependency !== i))]));
  const result: string[][] = [];
  while (remaining.size > 0) {
    const ready = [...remaining].filter(([, prerequisites]) => prerequisites.size === 0).map(([i]) => i);
    if (ready.length === 0) throw new Error("章の中の依存順を確定できません");
    const next = ready.sort((a, b) => blockPositionById.get(components[a]![0]!)! - blockPositionById.get(components[b]![0]!)!)[0]!;
    result.push(components[next]!);
    remaining.delete(next);
    for (const prerequisites of remaining.values()) prerequisites.delete(next);
  }
  return result;
}
const parts = plannedParts.map((part) => ({
  title: part.title,
  chapters: part.chapters.map((chapter) => {
    const chapterEntryIds = new Set([...chapterKeyById].filter(([, key]) => key === chapter.organizationGoalLabel).map(([id]) => id));
    const dependencyOrder = orderByDependencyThenPosition(chapterEntryIds);
    return {
      key: chapter.organizationGoalLabel,
      title: "tex" in chapter.title ? chapter.title.tex : chapter.title.text,
      titleFormat: "tex" in chapter.title ? "tex" as const : "text" as const,
      goalEntryIds: goalEntryIdsByChapter.get(chapter.organizationGoalLabel)!,
      entryCount: chapterEntryIds.size,
      proposalEntryCount: chapter.proposalEntryCount,
      dependencyOrder: dependencyOrder.map((entryIds) => ({ entryIds, inseparableDependencyUnit: entryIds.length > 1 })),
      placedUnderChapterHeadingEntryIds: dependencyOrder.flat()
        .filter((id) => enclosingChapterHeadingKeyById.get(id) === titleKey(chapter.title)),
    };
  }),
}));
const unassignedIsingEntryIds = baseEntries
  .filter((entry) => entry.classification === "2次元イジングモデル" && !chapterKeyById.has(entry.id)).map(({ id }) => id);
const entries = baseEntries.map((entry) => ({
  ...entry,
  chapterKey: chapterKeyById.get(entry.id) ?? null,
  dependencyPlacement: order.get(entry.id),
}));

const toolEntries = entries.filter((entry) => entry.classification === "数学的道具立て");
const groupRules: [string, RegExp][] = [
  ["三角関数の評価・有限和・積分", /^(critical_008|critical_009|critical_010|freeenergy_004)/],
  ["トレース・共役転置・正定値性", /^eigenvalues_of_V_|^maxeig_005|frobenius|exp_conjugation_proof_003/],
  ["可逆行列・線型写像との対応・共役変換", /^transfer_matrix_005|^transfer_matrix_claim_end_|^TV1_hatZ_hatY_01[015]|^TV1_hatZ_hatY_009|exp_conjugation_proof_005|^calculation_formulae_046/],
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
  ["可逆行列・線型写像との対応・共役変換", { input: "可逆な複素行列、行列単位、数ベクトルの基底", output: "行列と作用の一対一対応、逆行列による共役作用", reason: "行列の式とベクトルへの作用を同じ成分表で行き来し、対称性を左右から掛ける計算で追うため。" }],
  ["トレース・共役転置・正定値性", { input: "複素行列、共役転置、固有ベクトル", output: "トレース公式、Frobenius内積、エルミート性、正定値性とCauchy–Schwarz評価", reason: "最大固有値と重複度を、成分和と二次式の符号から判定するため。" }],
  ["三角関数の評価・有限和・積分", { input: "連続な実数関数、有限和、初等的な三角関数の不等式", output: "リーマン和の極限、積分の閉形式と上下評価", reason: "有限サイズの行列計算から自由エネルギーと臨界挙動を読み取る最後の計算に必要なため。" }],
]);
const mathematicalToolGroups = [...groupDescriptions].map(([name, description]) => ({
  name, ...description,
  entryIds: toolEntries.filter((entry) => groupOf(entry) === name).sort((a, b) => a.dependencyPlacement!.classificationOrder - b.dependencyPlacement!.classificationOrder).map(({ id }) => id),
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
const assignedChapterEntryCount = chapterKeyById.size;
const placedUnderChapterHeadingEntryCount = parts
  .flatMap(({ chapters }) => chapters).reduce((sum, chapter) => sum + chapter.placedUnderChapterHeadingEntryIds.length, 0);
const inventory = {
  schemaVersion: 4,
  scope: "exact-solution-of-2d-ising-model/structured-latex/content の全 definition・claim・theorem",
  organizingTheme: "高校生でも読める具体的な複素数・行列計算として2次元イジング模型の厳密解を積み上げる",
  classificationRule: "イジング模型を一切参照せずに定義・主張できる複素数・複素行列の道具は数学的道具立て、記号の由来がスピン・格子・転送行列・全スピン反転行列・Jordan–Wigner 行列族などに依存するものは2次元イジングモデルとする。",
  chapterAssignmentRule: "承認済みの章立ての章の順に、各章のゴールの式を構成するブロックから依存閉包を取り、まだどの章にも入っていない2次元イジングモデルの項をその章に入れる。各章は、それより前の章と数学的道具立てだけを使う。",
  classifications,
  mathematicalToolPartTitle,
  entryCount: entries.length,
  classificationEntryCounts: Object.fromEntries(classifications.map((classification) =>
    [classification, entries.filter((entry) => entry.classification === classification).length])),
  chapterPlacementProgress: {
    assignedChapterEntryCount,
    placedUnderChapterHeadingEntryCount,
    unassignedIsingEntryCount: unassignedIsingEntryIds.length,
  },
  parts,
  unassignedIsingEntryIds,
  crossChapterNavigationReferences,
  mathematicalToolGroups,
  explanationGranularityReview: {
    reviewedEntryCount: entries.length,
    criterion: "高度な抽象理論を導入せず、複素数と有限行列の具体的な計算を依存先から順に追えること",
    flaggedEntryIds: entries.filter((entry) =>
      entry.explanationGranularityReview.abstractVocabularyMatches.length > 0 || entry.explanationGranularityReview.forwardNavigationMixedIntoStatement || entry.explanationGranularityReview.manualReview !== null
    ).map(({ id }) => id),
  },
  mathematicalToolSemanticContaminationReview: {
    inspectedEntryCount: toolEntries.length,
    contaminatedEntryIds: toolEntries.filter((entry) => entry.classificationEvidence.isingSemanticMatches.length > 0).map(({ id }) => id),
  },
  classificationStructures,
  dependencySupportNodeCount: dependencySupportNodes.length,
  unnamedEntryIds: entries.filter(({ title }) => title === null).map(({ id }) => id),
  unlabeledEntryIds: entries.filter(({ labels }) => labels.length === 0).map(({ id }) => id),
  unresolvedInventoryDependencies: [...new Set(allDependencyLabels)].filter((label) => !labelOwners.has(label)).sort(),
  entries, dependencySupportNodes,
};
mkdirSync(dirname(outputPath), { recursive: true });
writeFileSync(outputPath, `${JSON.stringify(inventory, null, 2)}\n`);
console.log(`wrote ${entries.length} entries to ${outputPath}`);
for (const part of parts) for (const chapter of part.chapters) {
  console.log(`  ${part.title} / ${chapter.title}: ${chapter.entryCount} 項（章立て案 ${chapter.proposalEntryCount} 項）`);
}
console.log(`  どの章のゴールからも辿れない項: ${unassignedIsingEntryIds.length}`);
